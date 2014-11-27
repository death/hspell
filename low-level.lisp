;;;; +----------------------------------------------------------------+
;;;; | Hspell bindings                                                |
;;;; +----------------------------------------------------------------+

(in-package #:hspell)

(define-foreign-library libhspell
  (t (:default "libhspell")))

(use-foreign-library libhspell)

(defconstant hspell-opt-default 0)
(defconstant hspell-opt-he-sheela 1)
(defconstant hspell-opt-linguistics 2)

(defcfun hspell-init :int
  (dictp :pointer)
  (flags :int))

(defcfun hspell-check-word :boolean
  (dict :pointer)
  (word :string)
  (preflen :pointer))

(defcfun hspell-trycorrect :void
  (dict :pointer)
  (word :string)
  (corlist :pointer))

(defcfun hspell-is-canonic-gimatria :unsigned-int
  (word :string))

(defcfun hspell-uninit :void
  (dict :pointer))

(defcfun hspell-get-dictionary-path :string)

(defcfun hspell-set-dictionary-path :void
  (path :string))

(defcvar hspell-debug :int)

(defconstant n-corlist-words 50)
(defconstant n-corlist-len 30)

(defcstruct corlist
  (correction :char :count 1500)
  (n :int))

(defcfun corlist-add :int
  (corlist :pointer)
  (word :string))

(defcfun corlist-init :int
  (corlist :pointer))

(defcfun corlist-free :int
  (corlist :pointer))

(defbitfield prefix-bits
  (:b 1)
  (:l 2)
  (:verb 4)
  (:nondef 8)
  (:imper 16)
  (:misc 32))

(defcfun hspell-enum-splits :int
  (dict :pointer)
  (word :string)
  (enumf :pointer))
