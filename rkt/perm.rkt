#lang racket/base

(require racket/list)
(require racket/string)

(define (output-permutations n)
  (displayln (foldl * 1 (range 1 (add1 n))))
  (for ([p (permutations (range 1 (add1 n)))])
    (displayln (string-join (map number->string p)))))
