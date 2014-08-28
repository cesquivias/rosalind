#lang racket/base

(require racket/file)
(require racket/string)

(define (hamming-distance dna-1 dna-2)
  (for/sum ([nt-1 dna-1]
            [nt-2 dna-2])
    (if (char=? nt-1 nt-2)
        0
        1)))

(define (file->hamming-distance fname)
  (apply hamming-distance (string-split (file->string fname) "\n")))
