#lang racket/base

(require racket/list)
(require racket/port)
(require racket/string)

(define (longest-compared comp seq)
  (define (new-candidates el lst)
    (for/list ([n lst]
               #:when (comp el n))
      (list el n)))

  (define (grown-candidates el hsh)
    (for/fold ([candidates '()])
        ([list-of-lists (hash-values hsh)])
      (values
       (append
        (for/list ([lst list-of-lists]
                   #:when (comp el (car lst)))
          (cons el lst))
        candidates))))

  (define (longest-candidates list-of-lists)
    (define max-length (for/fold ([max-length 0])
                           ([lst list-of-lists]
                            #:when (comp (length lst) max-length))
                         (values (length lst))))
    (filter (λ [l] (= max-length (length l)))
            list-of-lists))

  (let loop ([elements '()]
             [candidates (hash)]
             [seq (reverse seq)])
    (cond
     [(null? seq) (car (longest-candidates (map car (hash-values candidates))))]
     [else (define el (car seq))
           (when (= 0 (modulo (length elements) 100))
             (displayln (length elements)))
           (define el-candidates (longest-candidates
                                  (append (new-candidates el elements)
                                          (grown-candidates el candidates))))
           (loop (cons el elements)
                 (if (null? el-candidates)
                     candidates
                     (hash-set candidates el el-candidates))
                 (cdr seq))])))

(define (longest-decreasing seq)
  (longest-compared > seq))

(define (longest-increasing seq)
  (reverse (longest-compared > (reverse seq))))

(define lines (port->lines (open-input-file "/tmp/rosalind_lgis.txt")))
(define nums (map string->number (string-split (cadr lines) " ")))
