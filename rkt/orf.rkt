#lang racket/base

(require racket/function)
(require racket/list)
(require racket/string)

(require "string.rkt")

(provide dna-string->codons proteins)

(define dna-codon
  (hash
   "TTT" "F"      "CTT" "L"      "ATT" "I"      "GTT" "V"
   "TTC" "F"      "CTC" "L"      "ATC" "I"      "GTC" "V"
   "TTA" "L"      "CTA" "L"      "ATA" "I"      "GTA" "V"
   "TTG" "L"      "CTG" "L"      "ATG" "M"      "GTG" "V"
   "TCT" "S"      "CCT" "P"      "ACT" "T"      "GCT" "A"
   "TCC" "S"      "CCC" "P"      "ACC" "T"      "GCC" "A"
   "TCA" "S"      "CCA" "P"      "ACA" "T"      "GCA" "A"
   "TCG" "S"      "CCG" "P"      "ACG" "T"      "GCG" "A"
   "TAT" "Y"      "CAT" "H"      "AAT" "N"      "GAT" "D"
   "TAC" "Y"      "CAC" "H"      "AAC" "N"      "GAC" "D"
   "TAA" "Stop"   "CAA" "Q"      "AAA" "K"      "GAA" "E"
   "TAG" "Stop"   "CAG" "Q"      "AAG" "K"      "GAG" "E"
   "TGT" "C"      "CGT" "R"      "AGT" "S"      "GGT" "G"
   "TGC" "C"      "CGC" "R"      "AGC" "S"      "GGC" "G"
   "TGA" "Stop"   "CGA" "R"      "AGA" "R"      "GGA" "G"
   "TGG" "W"      "CGG" "R"      "AGG" "R"      "GGG" "G"))

(define (part n lst)
  (let loop ([parts '()]
             [rest lst])
    (cond
     [(null? rest) (reverse parts)]
     [(< (length rest) n) (loop (cons rest parts) '())]
     [else (loop (cons (take rest n) parts)
                 (drop rest n))])))

(define (dna-string->codons dna-string)
  (map (λ [dna3] (hash-ref dna-codon dna3))
       (filter (λ [s] (= 3 (string-length s)))
               (map list->string (part 3 (string->list dna-string))))))

(define (candidate-protein-strings dna-string)
  (remove-duplicates
   (filter (negate null?)
           (for/fold ([candidates '()])
               ([start-i '(0 1 2)])
             (values (append
                      (proteins
                       (dna-string->codons (substring
                                            (dna-reverse-complement dna-string)
                                            start-i)))
                      (proteins
                       (dna-string->codons (substring dna-string start-i)))
                      candidates))))))

(define (index-of-f lst f)
  (let loop ([l lst]
             [i 0])
    (cond
     [(null? l) #f]
     [(f (car l)) i]
     [else (loop (cdr l) (add1 i))])))

(define (proteins codons-list)
  (let loop ([codons (member "M" codons-list)]
             [result '()])
    (cond
     [(not codons) result]
     [(not (index-of-f codons (λ [c] (string=? "Stop" c)))) result]
     [else (loop (member "M" (cdr codons))
                 (cons
                  (string-join
                   (takef codons (λ [codon] (not (string=? codon "Stop"))))
                   "")
                  result))])))
