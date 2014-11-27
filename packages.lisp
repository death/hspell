;;;; +----------------------------------------------------------------+
;;;; | Hspell bindings                                                |
;;;; +----------------------------------------------------------------+

(in-package #:cl-user)


;;;; Package definitions

(defpackage #:hspell
  (:use #:cl)
  (:import-from #:trivial-garbage #:finalize)
  (:import-from #:cffi #:define-foreign-library #:use-foreign-library
                #:defcfun #:defcvar #:defcstruct #:defbitfield
                #:with-foreign-string #:foreign-string-to-lisp
                #:with-foreign-object #:foreign-slot-value
                #:defcallback #:callback #:mem-ref)
  (:export
   #:make-hspell
   #:*hspell*
   #:correct-spelling-p
   #:correct-spelling
   #:canonic-gimetria-p
   #:dictionary-path
   #:word-splits))
