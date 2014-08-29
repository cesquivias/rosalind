#lang racket/base

(define (gc-content fasta)
  (define (count-gc dna-string)
    (foldl (λ [e sum] (if (or (char=? e #\C) (char=? e #\G))
                          (add1 sum)
                          sum))
           0
           (string->list dna-string)))
  (hash-map fasta (λ [key val] (list key (/ (* 100.0 (count-gc val))
                                            (string-length val))))))

(define (max-gc-content fasta)
  (for/fold ([max-gc (list "" 0)])
      ([dna-string (gc-content fasta)])
    (if (> (cadr dna-string)
           (cadr max-gc))
        (values dna-string)
        (values max-gc))))
