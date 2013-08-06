;;;; +----------------------------------------------------------------+
;;;; | Hspell bindings                                                |
;;;; +----------------------------------------------------------------+

(in-package #:hspell)

(define-foreign-library libhspell
  (t (:default "libhspell")))

(use-foreign-library libhspell)
