#lang racket/base

(define (dna-complement dna)
  (define (compliment bp)
    (case bp
      [(#\A) #\T]
      [(#\T) #\A]
      [(#\C) #\G]
      [(#\G) #\C]))
  (list->string
   (foldl (λ [bp opposite] (cons (compliment bp) opposite))
          '()
          (string->list dna))))

