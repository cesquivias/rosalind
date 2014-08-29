#lang racket/base

(require racket/function)
(require racket/string)
(require "fasta.rkt")

(define (profile-matrix fasta)
  (define dna-strings (hash-values fasta))
  (define dna-length (string-length (car dna-strings)))
  (define matrix (make-hash (list (cons #\A (make-vector dna-length 0))
                                  (cons #\C (make-vector dna-length 0))
                                  (cons #\G (make-vector dna-length 0))
                                  (cons #\T (make-vector dna-length 0)))))
  (for* ([dna dna-strings]
         [i dna-length])
    (define sym (string-ref dna i))
    (hash-update! matrix sym (λ [v]
                                (vector-set! v i (add1 (vector-ref v i)))
                                v)))
  matrix)

(define (consensus profile)
  (define (profile-row-ref i k v)
    (cons k (vector-ref v i)))
  (define v-length (vector-length
                    (hash-iterate-value profile
                                        (hash-iterate-first profile))))
  (apply string
         (map car
              (for/list ([i v-length])
                (foldl (λ [x mx] (if (> (cdr x) (cdr mx)) x mx))
                       (cons 0 0)
                       (hash-map profile (curry profile-row-ref i)))))))

(define (cons-output fname)
  (define profile (profile-matrix (port->fasta (open-input-file fname))))
  (define (print-nuleotide n)
    (printf "~a: ~a\n"
            n
            (string-join
             (map number->string
                  (vector->list (hash-ref profile n))) " ")))

  (displayln (consensus profile))
  (for ([n '(#\A #\C #\G #\T)])
    (print-nuleotide n)))
