#lang racket/base

(require racket/string)

(define codon-table (hash 
                     "UUU" "F" "CUU" "L" "AUU" "I" "GUU" "V" "UUC" "F"
                     "CUC" "L" "AUC" "I" "GUC" "V" "UUA" "L" "CUA" "L"
                     "AUA" "I" "GUA" "V" "UUG" "L" "CUG" "L" "AUG" "M"
                     "GUG" "V" "UCU" "S" "CCU" "P" "ACU" "T" "GCU" "A"
                     "UCC" "S" "CCC" "P" "ACC" "T" "GCC" "A" "UCA" "S"
                     "CCA" "P" "ACA" "T" "GCA" "A" "UCG" "S" "CCG" "P"
                     "ACG" "T" "GCG" "A" "UAU" "Y" "CAU" "H" "AAU" "N"
                     "GAU" "D" "UAC" "Y" "CAC" "H" "AAC" "N" "GAC" "D"
                     "CAA" "Q" "AAA" "K" "GAA" "E" "CAG" "Q" "AAG" "K"
                     "GAG" "E" "UGU" "C" "CGU" "R" "AGU" "S" "GGU" "G"
                     "UGC" "C" "CGC" "R" "AGC" "S" "GGC" "G" "CGA" "R"
                     "AGA" "R" "GGA" "G" "UGG" "W" "CGG" "R" "AGG" "R"
                     "GGG" "G"
                     ;; stop amino acids
                     "UAA" "" "UAG" "" "UGA" ""))

(define (encoded-protein dna-string)
  (let loop ([dna (string-replace dna-string #px"[[:space:]]" "")]
             [protein ""])
    (define codon (substring dna 0 3))
    (define amino-acid (hash-ref codon-table codon))
    (if (= 3 (string-length dna))
        (string-append protein amino-acid)
        (loop (substring dna 3)
              (string-append protein amino-acid)))))
