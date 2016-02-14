#lang racket
;@author Seena Rowhani
;q1
;--defs
(define (make-interval a b)
  (cons a b))
(define (lower a)
  (car a))
(define (upper a)
  (cdr a))

(define (add-interval a b)
  (cons (+ (lower a) (lower b))
        (+ (upper a) (upper b))))
(define (subtract-interval a b)
  (cons (- (lower a) (upper b))
        (- (upper a) (lower b))))
(define (multiply-interval a b)
  (cons (min (* (lower a) (lower b)) (* (lower a) (upper b)) (* (upper a) (lower b)) (* (upper a) (upper b)))
        (max (* (lower a) (lower b)) (* (lower a) (upper b)) (* (upper a) (lower b)) (* (upper a) (upper b)))))
(define (divide-interval a b)
  (if (or (= (lower b) 0) (= (upper b) 0))
      (~a "Error: " 'DivideByZero)
      (multiply-interval a
                         (make-interval (/ 1.0 (upper b))
                                        (/ 1.0 (lower b))))))

(define a (make-interval 5 10))
(define b (make-interval 10 20))
(define c (make-interval 0 10))

;q1 - testing

(display "Question 1:\n")
(~a "(add-interval (make-interval 5 10) (make-interval 10 20)) => " (add-interval a b))
(~a "(subtract-interval (make-interval 10 20) (make-interval 0 10)) => " (subtract-interval b c))
(~a "(multiply-interval (make-interval 5 10) (make-interval 10 20)) => " (multiply-interval a b))
(~a "(divide-interval (make-interval 5 10) (make-interval 0 10)) => " (divide-interval a c))

;q2)
(define (enum a b)
  (cond ((> a b) '())
        (else (cons a (enum (+ a 1) b)))))

(define (accumulate operator initial sequence)
  (if (null? sequence)
      initial
      (operator (car sequence) (accumulate operator initial (cdr sequence)))))
;a
(define (my-map proc seq)
  (accumulate (lambda (x y) (cons (proc x) y)) '() seq))
;b
(define (my-append seq1 seq2)
  (accumulate cons seq2 seq1))
;c
(define (my-length seq)
  (accumulate (lambda (x y) (+ y 1)) 0 seq)) ; count number of 'y's (current els)
;q2 - testing
(display "Question 2:\n")
(~a "(my-map sqr (list 1 2 3 4 5)) => " (my-map sqr (list 1 2 3 4 5)))
(~a "(my-append (list 6 7 8 9) (list 1 2 3 4 5)) => " (my-append (list 6 7 8 9) (list 1 2 3 4 5)))
(~a "(my-map sqr (list 1 2 3 4 5) =>" (my-map sqr (list 1 2 3 4 5)))

;q3)
(define (special-cons x y)
  (lambda (m) (m x y)))

(define (special-car z)
  (z (lambda (p q) p)))

(define (special-cdr z)
  (z (lambda (p q) q)))
;a)
(display "Question 3: \n")
(~a "(special-car (special-cons 1 2)) => " (special-car (special-cons 1 2))); => 1
;b) 
(~a "(special-cdr (special-cons 1 2)) => " (special-cdr (special-cons 1 2))); => 2
(~a "(special-car (special-car (special-cons (special-cons 1 2) 3))) => " (special-car (special-car (special-cons (special-cons 1 2) 3)))); => 1

;special-cons returns procedure 'P' with x and y embedded, awaiting a procedure 'm' to apply to x,y
;special-car takes procedure 'P', and applies procedure 'm'
;where it takes two arguments, and returns the first

;c)
(define (triple x y z)
  (special-cons x (special-cons y (special-cons z '()))))

(define (triple-first T)
  (special-car T))
(define (triple-second T)
  (special-car (special-cdr T)))
(define (triple-third T)
  (T (lambda (x y) (if (null? y) x (triple-third y)))))

(define triple_test (triple 1 2 3))
(~a "(triple-first triple_test) => " (triple-first triple_test)); -> 1
(~a "(triple-second triple_test) =>  " (triple-second triple_test)); -> 2
(~a "(triple-third triple_test) => " (triple-third triple_test)); -> 3

;q4
;a)
(define (subsets list)
  (if (not (empty? list))
      (let ((universe (subsets (cdr list))))
        (append (map (lambda (x) (cons (first list) x))
                     universe)
                universe))
      '(())))
(display "Question 4: \n")
(~a "a) (subsets (list 1 2 3)) => " (subsets (list 1 2 3)))

;b)

(define (intersection-set-iter s1 s2)
  (define (helper s1 s2 reduce)
    (cond ((null? s1) reduce)
          (else (helper (cdr s1) s2 (if (member (car s1) s2) (append (list (car s1)) reduce) reduce)))))
  (helper s1 s2 '()))

(~a "b) (intersection-set-iter (list 1 2 3) (list 2 3 4)) => " (intersection-set-iter (list 1 2 3) (list 2 3 4))); => '(3,2)

;c)
(define (intersection-set s1 s2)
  (filter (lambda (x) (member x s2)) s1))

(define (mean L)
  (let ((l (filter number? L)))
    (/ (accumulate + 0 l) (length l))))

(~a "c) (mean '(1 2 3 4 5)) => " (mean '(1 2 3 4 5)))
(~a "c) (mean '(1 _a 2 _b _c _d _e 3)) => " (mean '(1 _a 2 _b _c _d _e 3)))


;q5
(define (compose f g)(lambda (x) (f (g x))))
;a
(define (repeated f n)
  (if (> n 0)
      (compose (repeated f (- n 1)) f)
      identity))
((repeated sqr 3) 2)
;q5 testing
;((repeated (repeated sqr 2 2)) 2)
(display "Question 5: \n")
(~a "((repeated sqr 3) 2) => " ((repeated sqr 3) 2))

;b
(define (repeated-iter f n)
  (if (<= n 0)
      identity
      (compose (repeated-iter f (- n 1)) f))) ; call (repeat (sqr (- n 1)) sqr) -> does sqr, will do again until n is 0. then returns identity to show value

((repeated-iter sqr 3) 2); => 256.
(~a "((repeated-iter sqr 3) 2) => " ((repeated-iter sqr 3) 2))
;q6
(define (depth T)
  (apply max (let helper ((_T T)
                          (count 0)
                          (R '()))
               (cond
                 ((null? _T) R)
                 ((pair? _T) (helper (car _T)
                                     (+ 1 count)
                                     (helper (cdr _T)
                                             count
                                             R)))
                 (else (cons count R))))))
(display "Question 6: \n")
(~a "(depth 'a) => " (depth 'a)); → 0
(~a "(depth '(a)) => " (depth '(a))); → 1
(~a "(depth '(a (b) c)) => " (depth '(a (b) c))); → 2
(~a "(depth '(((((a(((b))))))))) => " (depth '(((((a(((b)))))))))); → 8

;q7
(define (index i L)
  (if (eq? i 0)
      (car L)
      (if (null? L)
          (error 'IndexOutOfRangeError)
          (index (- i 1) (cdr L)))))

(define r (lambda (p x) (if (null? x) x (p x))))
(define (rearrange indices elements)
  (define (helper current indy L)
    (cond ((null? current) L)
          ((number? current) (helper (r car indy) (r cdr indy) (append L (list (index (- current 1) elements)))))
          ((list? current) (helper (r car indy) (r cdr indy)   (append L (list (rearrange current elements)))))))
  (cdr (helper (car indices) indices '())))


(display "Question 7: \n")
(~a "(rearrange '(4 3 2 1) '(a b c d)) -> " (rearrange '(4 3 2 1) '(a b c d))); → (d c b a)
(~a "(rearrange '(4 3 2 1 1 2 3 4) '(a b c d)) -> " (rearrange '(4 3 2 1 1 2 3 4) '(a b c d))); → (d c b a a b c d)
(~a "(rearrange '(4 (4 2) 1) '(a b c d)) -> " (rearrange '(4 (4 2) 1) '(a b c d))); → (d (d b) a)
(~a "(rearrange '(1 2 4 2 3) '(a (b) ((c)) d)) -> " (rearrange '(1 2 4 2 3) '(a (b) ((c)) d))); → (a (b) d (b) ((c)))
;(~a "(rearrange '(4 2) '(a b)) -> " (rearrange '(4 2) '(a b))); → index out of range error

;q8
(define (treemap f T)
  (cond
    ((null? T) '())
    ((list? T) ;if pair, return new pair of map of left and right
         (cons (treemap f (car T))
               (treemap f (cdr T))))
    (else (f T))))
;q8 - testig
(display "Question 8: \n")
(~a "(treemap sqr '(1 (2 3) ((4 5) (6 7)) (((8 (9)))))) => " (treemap sqr '(1 (2 3) ((4 5) (6 7)) (((8 (9)))))))