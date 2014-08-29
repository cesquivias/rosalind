#lang racket/base

(define (dominant-phenotype-exptected-value AA-AA AA-Aa AA-aa
                                            Aa-Aa Aa-aa aa-aa)
  (* 2
     (+ AA-AA AA-Aa AA-aa
        (* 0.75 Aa-Aa)
        (* 0.5 Aa-aa))))
