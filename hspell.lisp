;;;; +----------------------------------------------------------------+
;;;; | Hspell bindings                                                |
;;;; +----------------------------------------------------------------+

(in-package #:hspell)

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
  (with-foreign-string (s word :encoding :iso-8859-8)
    (with-foreign-object (prefix-length :int)
      (values (hspell-check-word (handle hspell) s prefix-length)
              (mem-ref prefix-length :int)))))

(defun correct-spelling (word &optional (hspell *hspell*))
  (declare (ignore word hspell))
  (error "To Be Done."))

(defun canonic-gimatria-p (word &optional (hspell *hspell*))
  (declare (ignore word hspell))
  (error "To Be Done."))

(defun dictionary-path ()
  (hspell-get-dictionary-path))

(defun (setf dictionary-path) (new-value)
  (hspell-set-dictionary-path new-value))

(defun word-splits (word &optional (hspell *hspell*))
  (error "To Be Done."))
