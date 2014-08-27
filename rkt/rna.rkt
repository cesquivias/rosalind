#lang racket/base

(require racket/string)

(define (transcribe-dna dna)
  (string-replace dna "T" "U"))
