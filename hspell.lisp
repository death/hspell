;;;; +----------------------------------------------------------------+
;;;; | Hspell bindings                                                |
;;;; +----------------------------------------------------------------+

(in-package #:hspell)

;;; Implementation utilities

(defmacro with-hspell-string ((foreign-var lisp-string) &body forms)
  `(with-foreign-string (,foreign-var ,lisp-string :encoding :iso-8859-8)
     ,@forms))

(defun hspell-string-to-lisp (ptr &optional (offset 0))
  (foreign-string-to-lisp ptr :offset offset :encoding :iso-8859-8))

(defmacro with-corlist ((var) &body forms)
  `(with-foreign-object (,var '(:struct corlist))
     (corlist-init ,var)
     (unwind-protect
          (progn ,@forms)
       (corlist-free ,var))))

(defun corlist-n (corlist)
  (foreign-slot-value corlist '(:struct corlist) 'n))

(defun corlist-correction (corlist)
  (foreign-slot-value corlist '(:struct corlist) 'correction))

(defvar *splits*)

(defcallback splits-cb :int ((word :pointer)
                             (baseword :pointer)
                             (preflen :int)
                             (prefspec prefix-bits))
  (declare (ignore word))
  (push (list (hspell-string-to-lisp baseword) preflen prefspec)
        *splits*)
  0)

(defmacro with-splits (&body forms)
  `(let ((*splits* '()))
     ,@forms
     (nreverse *splits*)))

;;; Public interface

(defclass hspell ()
  ((handle :initarg :handle :accessor handle)))

(defun make-hspell (&key he-sheela linguistics)
  (let ((flags (logior (if he-sheela
                           hspell-opt-he-sheela
                           0)
                       (if linguistics
                           hspell-opt-linguistics
                           0))))
    (with-foreign-object (dictp :pointer)
      (let ((ret (hspell-init dictp flags)))
        (if (zerop ret)
            (let ((dict (mem-ref dictp :pointer)))
              (finalize (make-instance 'hspell :handle dict)
                        (lambda () (hspell-uninit dict))))
            (error "Hspell initialization failed with error ~D." ret))))))

(defvar *hspell* (make-hspell))

(defun correct-spelling-p (word &optional (hspell *hspell*))
  (with-hspell-string (s word)
    (with-foreign-object (prefix-length :int)
      (values (hspell-check-word (handle hspell) s prefix-length)
              (mem-ref prefix-length :int)))))

(defun correct-spelling (word &optional (hspell *hspell*))
  (with-hspell-string (s word)
    (with-corlist (cors)
      (hspell-trycorrect (handle hspell) s cors)
      (loop for i below (corlist-n cors)
            for offset = (* i n-corlist-len)
            collect (hspell-string-to-lisp (corlist-correction cors) offset)))))

(defun canonic-gimatria-p (word &optional (hspell *hspell*))
  (declare (ignore hspell))
  (with-hspell-string (s word)
    (let ((val (hspell-is-canonic-gimatria s)))
      (if (zerop val)
          nil
          val))))

(defun dictionary-path ()
  (hspell-get-dictionary-path))

(defun (setf dictionary-path) (new-value)
  (hspell-set-dictionary-path new-value))

(defun word-splits (word &optional (hspell *hspell*))
  (with-hspell-string (s word)
    (with-splits
      (hspell-enum-splits (handle hspell) s (callback splits-cb)))))
