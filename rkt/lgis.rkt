#lang racket/base

(require racket/list)
(require racket/port)
(require racket/string)
(require racket/vector)

(require (planet dherman/memoize:3:1))

(define lines (port->lines (open-input-file "/tmp/rosalind_lgis_5.txt")))
(define nums (list->vector
              (map string->number (string-split (cadr lines) " "))))

(define (longest-comp-subsequence comp v)
  (define/memo (LS i)
    (define el (vector-ref v i))
    (cond
     [(= i 0) (vector el)]
     [else (vector-append (max-subsequence
                                       el
                                       (foldl (λ [i l] (cons (LS i)
                                                             l))
                                              '()
                                              (range i)))
                          (vector el))]))
  (define (max-subsequence el seqs)
    (for/fold ([max #()])
        ([seq (filter (λ [v] (comp el
                                   (vector-ref v (sub1 (vector-length v)))))
                      seqs)])
      (if (> (vector-length seq)
             (vector-length max))
          (values seq)
          (values max))))

  (for/fold ([max-seq #()])
      ([i (in-range (vector-length v))])
    (define seq (LS i))
    (if (> (vector-length seq) (vector-length max-seq))
        (values seq)
        (values max-seq))))


(define (longest-increasing-subsequence v)
  (longest-comp-subsequence > v))

(define (longest-decreasing-subsequence v)
  (longest-comp-subsequence < v))

