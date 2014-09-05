#lang racket/base

(require racket/list)
(require racket/port)
(require racket/string)

(require "fasta.rkt")
(require "prot.rkt")
(require "orf.rkt")

(define (dna->protein dna-string introns)
  (string-join
   (drop-right
    (dna-string->codons
     (foldl (λ [intron s] (string-replace s intron ""))
            dna-string
            introns))
    1)
   ""))

(define (splc filename)
  (define fasta (port->fasta (open-input-file filename)))
  (define dna-strings (sort (hash-values fasta) > #:key string-length))
  (dna->protein (car dna-strings) (cdr dna-strings)))
