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

;q3)
(define (special-cons x y)
  (lambda (m) (m x y)))

(define (special-car z)
  (z (lambda (p q) p)))

(define (special-cdr z)
  (z (lambda (p q) q)))
;c)
(define (triple x y z)
  (special-cons x (special-cons y (special-cons z '()))))

(define (triple-first T)
  (special-car T))
(define (triple-second T)
  (special-car (special-cdr T)))
(define (triple-third T)
  (T (lambda (x y) (if (null? y) x (triple-third y)))))
;q4
;a)
(define (subsets list)
  (if (not (empty? list))
      (let ((universe (subsets (cdr list))))
        (append (map (lambda (x) (cons (first list) x))
                     universe)
                universe))
      '(())))
;b)
(define (intersection-set-iter s1 s2)
  (define (helper s1 s2 reduce)
    (cond ((null? s1) reduce)
          (else (helper (cdr s1) s2 (if (member (car s1) s2) (append (list (car s1)) reduce) reduce)))))
  (helper s1 s2 '()))

;c)
(define (intersection-set s1 s2)
  (filter (lambda (x) (member x s2)) s1))

(define (mean L)
  (let ((l (filter number? L)))
    (/ (accumulate + 0 l) (length l))))

;q5
(define (compose f g)(lambda (x) (f (g x))))
(define (repeated f n)
  (if (> n 0)
      (compose (repeated f (- n 1)) f)
      identity))

(define (repeated-iter f n)
  (if (<= n 0)
      identity
      (compose (repeated-iter f (- n 1)) f))) ; call (repeat (sqr (- n 1)) sqr) -> does sqr, will do again until n is 0. then returns identity to show value

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

;q8
(define (treemap f T)
  (cond
    ((null? T) '())
    ((list? T) ;if pair, return new pair of map of left and right
         (cons (treemap f (car T))
               (treemap f (cdr T))))
    ((number? T) (f T))))

(provide (all-defined-out))
