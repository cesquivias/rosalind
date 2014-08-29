#lang racket/base

(define (adjacents start-dna fasta)
  (define end (substring start-dna (- (string-length start-dna) 3)))

  (define (string-starts-with? p)
    (define s (cdr p))
    (and (>= (string-length s) (string-length end))
         (for/and ([c s]
                   [c-sub end])
           (char=? c c-sub))))
  (map car (filter string-starts-with? (hash->list fasta))))

(define (adjacency-list fasta)
  (for/fold ([adjacencies '()])
      ([(name dna) fasta])
    (append (map (λ [n] (list name n)) (adjacents dna (hash-remove fasta name)))
            adjacencies)))

(define (grph-output adjacencies)
  (for ([adj adjacencies])
    (printf "~a ~a\n" (car adj) (cadr adj))))
