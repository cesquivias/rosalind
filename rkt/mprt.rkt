#lang racket/base

(require net/url)
(require racket/port)
(require racket/string)
(require "fasta.rkt")

(define b ">sp|B5ZC00|SYG_UREU1 Glycine--tRNA ligase OS=Ureaplasma urealyticum serovar 10 (strain ATCC 33699 / Western) GN=glyQS PE=3 SV=1
MKNKFKTQEELVNHLKTVGFVFANSEIYNGLANAWDYGPLGVLLKNNLKNLWWKEFVTKQ
KDVVGLDSAIILNPLVWKASGHLDNFSDPLIDCKNCKARYRADKLIESFDENIHIAENSS
NEEFAKVLNDYEISCPTCKQFNWTEIRHFNLMFKTYQGVIEDAKNVVYLRPETAQGIFVN
FKNVQRSMRLHLPFGIAQIGKSFRNEITPGNFIFRTREFEQMEIEFFLKEESAYDIFDKY
LNQIENWLVSACGLSLNNLRKHEHPKEELSHYSKKTIDFEYNFLHGFSELYGIAYRTNYD
LSVHMNLSKKDLTYFDEQTKEKYVPHVIEPSVGVERLLYAILTEATFIEKLENDDERILM
DLKYDLAPYKIAVMPLVNKLKDKAEEIYGKILDLNISATFDNSGSIGKRYRRQDAIGTIY
CLTIDFDSLDDQQDPSFTIRERNSMAQKRIKLSELPLYLNQKAHEDFQRQCQK
")

(define N-glycosylation-motif #px"N[^P][ST][^P]")

(define (protein-motif fasta)
  (define f (port->fasta fasta))
  (for/first ([(name dna-string) f]
              #:when (regexp-match N-glycosylation-motif dna-string))
    (map (λ [p] (format "~a" (add1 (car p))))
         (regexp-match-positions* N-glycosylation-motif dna-string ))))

(define (motif-indices port)
  (define s (for/first ([(k v) (port->fasta port)]) v))
  (let loop ([indices '()]
             [i 0])
    (cond [(regexp-match? N-glycosylation-motif s i)
           (let ([n (add1 (caar (regexp-match-positions 
                                 N-glycosylation-motif s i)))])
             (loop (cons (format "~a" n) indices)
                   n))]
          [else (reverse indices)])))
                   
    
(define (motifs-for-file port)
  (for ([uniprot-id (port->lines port)])
    (define motifs (protein-indices
                    (get-pure-port
                     (string->url 
                      (format "http://www.uniprot.org/uniprot/~a.fasta"
                              uniprot-id))
                     #:redirections 5)))
    (when motifs
      (displayln uniprot-id)
      (displayln (string-join motifs " ")))))