;;;; +----------------------------------------------------------------+
;;;; | Hspell bindings                                                |
;;;; +----------------------------------------------------------------+

;;;; System definitions

;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem #:hspell
  :description "Hspell bindings for Common Lisp."
  :author "death <github.com/death>"
  :license "MIT"
  :depends-on (#:cffi #:trivial-garbage)
  :serial t
  :components
  ((:file "packages")
   (:file "low-level")
   (:file "hspell")))
