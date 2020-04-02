# hspell

Common Lisp bindings for [hspell](http://hspell.ivrix.org.il/).

# Example

```lisp
HSPELL> (correct-spelling-p "עפשרות")
NIL
1
HSPELL> (correct-spelling "עפשרות")
("הפשרות" "אפשרות")
HSPELL> (word-splits "כלב")
(("כלב" 0 (:VERB :NONDEF :IMPER :MISC)) ("לב" 1 (:L :NONDEF :MISC)))
HSPELL> (canonic-gimatria-p "תרס\"ו")
666
```

# Note

You may need to compile `hspell` in order to create a shared object:


```sh
$ ./configure --enable-shared && PERL5LIB=. make
```

# License

MIT
