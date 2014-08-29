#lang racket/base

(require srfi/13/string)

(define (shared-motif fasta)
  (define dna-name (hash-iterate-key fasta (hash-iterate-first fasta)))
  (define dna-string (hash-ref fasta dna-name))
  (define other-dnas (hash-remove fasta dna-name))
  (let loop ([motif ""]
             [dna-string dna-string]
             [len 2])
    (cond
     [(> len (string-length dna-string)) motif]
     [(for/and ([(name dna) other-dnas])
        (string-contains dna (substring dna-string 0 len)))
      (loop (substring dna-string 0 len) dna-string (add1 len))]
     [else
      (loop motif (substring dna-string 1) (add1 (string-length motif)))])))
