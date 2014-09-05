#lang racket/base

(require racket/string)

(define (ordered-symbols alphabet n)
  (cond
   [(= n 1) (map list alphabet)]
   [else (for/fold ([words '()])
             ([c alphabet])
           (values
            (append
             words
             (map (λ [l] (cons c l)) (ordered-symbols alphabet (sub1 n))))))]))

(define (ordered-strings alphabet n)
  (for ([s (map
            (λ [l] (string-join (map symbol->string l) ""))
            (ordered-symbols alphabet n))])
    (displayln s)))
