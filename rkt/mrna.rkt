#lang racket/base

(define codon-possibilities
  (hash
   #\A 4
   #\C 2
   #\D 2
   #\E 2
   #\F 2
   #\G 4
   #\H 2
   #\I 3
   #\K 2
   #\L 6
   #\M 1
   #\N 2
   #\P 4
   #\Q 2
   #\R 6
   #\S 6
   #\newline 3
   #\T 4
   #\V 4
   #\W 1
   #\Y 2))

(define (different-rna-strings protein-string)
  (modulo
   (for/product ([c protein-string])
     (hash-ref codon-possibilities c))
   1000000))
