;;;; +----------------------------------------------------------------+
;;;; | Hspell bindings                                                |
;;;; +----------------------------------------------------------------+

(in-package #:cl-user)


;;;; Package definitions

(defpackage #:hspell
  (:use #:cl #:cffi #:trivial-garbage #:babel)
  (:export
   #:make-hspell
   #:*hspell*
   #:correct-spelling-p
   #:correct-spelling
   #:canonic-gimetria-p
   #:dictionary-path
   #:word-splits))
