#lang racket/base

(require racket/port)

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

(define (gc-content fasta)
  (define (count-gc dna-string)
    (foldl (λ [e sum] (if (or (char=? e #\C) (char=? e #\G))
                          (add1 sum)
                          sum))
           0
           (string->list dna-string)))
  (hash-map fasta (λ [key val] (list key (/ (* 100.0 (count-gc val))
                                            (string-length val))))))

(define (max-gc-content fasta)
  (for/fold ([max-gc (list "" 0)])
      ([dna-string (gc-content fasta)])
    (if (> (cadr dna-string)
           (cadr max-gc))
        (values dna-string)
        (values max-gc))))
