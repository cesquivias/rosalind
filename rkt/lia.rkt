#lang racket/base

(require unstable/hash)

(define (allele-sort s1 s2)
  (if (char<? s1 s2)
      (list s1 s2)
      (list s2 s1)))

(define (foil left right)
  (for*/fold ([h (hash)])
      ([l left]
       [r right])
    (values (hash-update h (list->string (allele-sort l r))
                         (λ [n] (+ 1/4 n)) 0))))

;; mate-1 -> (hash (listof factor?) real?)
(define (mate-1 mom dad p)
  (for/hash ([(genotype prob) (foil (string->list mom) (string->list dad))])
    (values genotype (* prob p))))

(define (generation population other num-children)
  (for/fold ([result (hash)])
      ([(event probability) population])
    (values (hash-union (mate event other num-children probability)
                        result
                        #:combine/key (λ [k v1 v2] (+ v1 v2))))))

(define population? hash?)

(define (union-generations pop1 pop2)
  (hash-union pop1 pop2
              #:combine/key (λ [k v1 v2]
                               (if (population? v1)
                                   (union-generations v1 v2)
                                   (+ v1 v2)))))

(define (mate-old events1 events2 probability num-children)
  (define (-mate event1 event2)
    (mate-1 event1 event2 probability))
  (define top (make-hash))
  (define children (list top))
  (for ([event-gen-hash (map -mate events1 events2)])
    (for ([child-gen-hash children])
      (define ch '())
      (hash-for-each child-gen-hash
                     (λ [factor prob]
                        (define new-child
                          (apply hash-map event-gen-hash
                                 (λ [f p]
                                    (cons f (* p prob)))))
                        (set! ch (cons new-child ch))
                        new-child))
      ch)))

(define (next-generation-old population fellow num-children)
  (let loop ([events '()] ;; the events we've traversed
             [probability-or-events population]) ;; the current level
    (if (population? probability-or-events)
        ;; another level to traverse
        (for/fold ([gen (hash)])
            ([(event next-level) probability-or-events])
          (values
           (union-generations gen
                              (loop (cons event events) next-level))))
        (mate (reverse events) fellow probability-or-events num-children))))

(define factor? string?)
(define generation? hash?)

(define (generation-first-level h)
  (hash-iterate-value h (hash-iterate-first h)))

;; generation? -> (listof (pair/c (listof factor?) . real?))
(define (generation->list gen)
  (if (generation? (generation-first-level gen))
      (for/fold ([l '()])
          ([(factor next-level) gen])
        (values (append l
                        (map (λ [factors-prob]
                                (define factors (car factors-prob))
                                (define probability (cdr factors-prob))
                                (cons (cons factor factors)
                                      probability))
                             (generation->list next-level)))))
      (map (λ [p] (cons (list (car p))
                        (cdr p)))
           (hash->list gen))))

;; mom : (listof factor?)
;; dad : (listof factor?)
;; start-probability : real?
;; num-children : integer?
;; mate -> (listof (pair/c (listof factor?) . real?))
(define (mate mom dad start-probability num-children)
  (define independent-factors
    (reverse
     (for/list ([mom-factor mom]
                [dad-factor dad])
       (mate-1 mom-factor dad-factor start-probability))))
  (let merge ([indy-factors (cdr independent-factors)]
              [joined-factors
               (map (λ [p] (cons (list (car p)) (cdr p)))
                    (hash->list (car independent-factors)))])
    (if (null? indy-factors)
        joined-factors
        (merge (cdr indy-factors)
               (for/fold ([l '()])
                   ([(factor prob) (car indy-factors)])
                 (values
                  (append
                   l
                   (map (λ [f-p]
                           (cons (cons factor (car f-p))
                                 (* num-children prob (cdr f-p))))
                        joined-factors))))))))

(define (list->generation l)
  (define h (make-hash))
  (for ([p l])
    (define-values (level thk)
      (for/fold ([last-level h]
                 [thk (λ [] #f)])
          ([factor (car p)])
        (define level (hash-ref! last-level factor (make-hash)))
        (values level (λ [] (hash-set! last-level factor (cdr p))))))
    (thk))
  (gen->immutable-gen h))

(define (gen->immutable-gen gen)
  (cond
    [(hash? gen) 
     (make-immutable-hash
      (hash-map gen
                (λ [k v] (cons k (gen->immutable-gen v)))))]
    [else gen]))

;; generation generation?
;; fellow (listof factor?)
(define (next-generation generation fellow num-children)
  (foldl union-generations
         generation
         (map (λ (parent-prob)
                (list->generation
                 (mate (car parent-prob) fellow (cdr parent-prob) num-children)))
              (generation->list generation))))
