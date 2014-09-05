#lang racket/base

(provide dna-reverse-complement)

(define dna-nucleotide-pair
  (hash #\A #\T
        #\C #\G
        #\G #\C
        #\T #\A))

(define (dna-reverse-complement dna-string)
  (list->string
   (reverse
    (map (λ [n] (hash-ref dna-nucleotide-pair n)) (string->list dna-string)))))
