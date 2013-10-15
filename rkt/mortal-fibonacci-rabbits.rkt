#lang racket

;; http://rosalind.info/problems/fibd/

(define (rabbit-population month lifespan)
  (define (growth-iter m population)
    (if (= m 0)
        population
        (let ([pop (make-hash)])
          (hash-set! pop 1
                     (for/fold ([children 0])
                         ([age (in-range 2 (add1 lifespan))])
                       (values (+ children (hash-ref population age 0)))))
          (for ([age (in-range 1 lifespan)])
            (hash-set! pop
                       (add1 age)
                       (hash-ref population age 0)))
          (growth-iter (sub1 m) pop))))
  (if (= month 1)
      1
      (foldl + 0 (hash-values (growth-iter (sub1 month) #hash((1 . 1)))))))
