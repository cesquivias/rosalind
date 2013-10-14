#lang racket

;; http://rosalind.info/problems/iprb/

(define (mating% 1st-parent% 2nd-parent%)
  (* 1st-parent% 2nd-parent%))

(define (total-%-child-of-random-parents-has-dominant-allele
         num-homozygous-dominant
         num-heterozygous
         num-homozygous-recessive)
  (define total (+ num-homozygous-dominant
                   num-heterozygous
                   num-homozygous-recessive))
  (define total-1 (sub1 total))
  (let* ([1st-AA% (/ num-homozygous-dominant total)]
         [AA+AA% (mating% 1st-AA%
                          (/ (sub1 num-homozygous-dominant) total-1))]
         [AA+Aa% (mating% 1st-AA%
                          (/ num-heterozygous total-1))]
         [AA+aa% (mating% 1st-AA%
                          (/ num-homozygous-recessive total-1))]

         [1st-Aa% (/ num-heterozygous total)]
         [Aa+AA% (mating% 1st-Aa%
                          (/ num-homozygous-dominant total-1))]
         [Aa+Aa% (mating% 1st-Aa%
                          (/ (sub1 num-heterozygous) total-1))]
         [Aa+aa% (mating% 1st-Aa%
                          (/ num-homozygous-recessive total-1))]

         [1st-aa% (/ num-homozygous-recessive total)]
         [aa+AA% (mating% 1st-aa%
                          (/ num-homozygous-dominant total-1))]
         [aa+Aa% (mating% 1st-aa%
                          (/ num-heterozygous total-1))]
         [aa+aa% (mating% 1st-aa%
                          (/ (sub1 num-homozygous-recessive) total-1))])
    (exact->inexact
     (+ (* 1 AA+AA%)
        (* 1 AA+Aa%)
        (* 1 AA+aa%)
        (* 1 Aa+AA%)
        (* 3/4 Aa+Aa%)
        (* 1/2 Aa+aa%)
        (* 1 aa+AA%)
        (* 1/2 aa+Aa%)
        (* 0 aa+aa%)))))
