#lang racket/base

(require "string.rkt")

(define (reverse-palindrome? dna-string)
  (string=? dna-string (dna-reverse-complement dna-string)))

(define (reverse-palindromes dna-string)
  (for*/list ([i (string-length dna-string)]
              [l (in-range 4 (add1 (min 12
                                        (- (string-length dna-string) i))))]
              #:when (reverse-palindrome? (substring dna-string i (+ i l))))
    (list (add1 i) l)))
