#lang racket

;; http://rosalind.info/problems/fib/

(define (fib generations growth-rate)
  (let loop ([n generations])
    (cond [(= n 1) 1]
          [(= n 2) 1]
          [else (+ (loop (sub1 n))
                   (* growth-rate (loop (- n 2))))])))
