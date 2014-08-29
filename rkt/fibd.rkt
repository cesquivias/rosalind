#lang racket/base

(require racket/list)

(define (sum l)
  (foldl + 0 l))

(define (fib-die n m)
  (define-values (young adults)
    (for/fold ([young 1]
               [adults (for/list ([i (sub1 m)]) 0)])
        ([i (sub1 n)])
      (values (sum adults) (cons young (drop-right adults 1)))))
  (+ young (sum adults)))
