#lang racket/base

(require racket/contract)
(require racket/port)

(provide (contract-out
          [port->fasta (-> input-port? hash?)]))

(define (port->fasta iport)
  (define (match pattern port)
    (bytes->string/utf-8 (car (regexp-match pattern port))))
  (let loop ([current-dna-string '()]
             [fasta-map (hash)])
    (define peeked-char (peek-char iport))
    (cond
     [(eof-object? peeked-char) fasta-map]
     [(char=? #\> peeked-char)
      (read-char iport)
      (loop (match #rx"(?-s:^.*)" iport) fasta-map)]
     [(char=? #\newline peeked-char)
      (read-char iport)
      (loop current-dna-string fasta-map)]
     [else (define line (match #rx"(?-s:^.*)" iport))
           (loop current-dna-string
                 (hash-update fasta-map current-dna-string
                              (λ [s] (string-append s line))
                              ""))])))
