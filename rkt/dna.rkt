#lang racket/base

(define (letter-count dataset)
  (define counter (make-hash))
  (for ([c dataset])
    (hash-update! counter c add1 0))
  (list (hash-ref counter #\A)
        (hash-ref counter #\C)
        (hash-ref counter #\G)
        (hash-ref counter #\T)))
