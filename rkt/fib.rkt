#lang racket/base

(define (rabbit-recurrence months pairs-produced)
  (define (iterate m)
    (cond
     [(= m 1) 1]
     [(= m 2) 1]
     [else (+ (* (iterate (- m 2)) pairs-produced)
              (iterate (- m 1)))]))
  (iterate months))
