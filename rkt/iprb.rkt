#lang racket/base

(define (dominant-allele k m n)
  (define total (* 1.0 (+ k m n)))
  (define total-1 (sub1 total))
  (+ (/ k total)
     (* (/ m total)
        (+ (/ k total-1) ;; km
           (* 3/4 (/ (max 0 (sub1 m)) total-1)) ;; mm
           (* 1/2 (/ n total-1)))) ;; nm
     (* (/ n total)
        (+ (/ k total-1) ;; kn
           (* 1/2 (/ m total-1)) ;; mn
           0 ;; nn
           ))))
