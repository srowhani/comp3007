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
; -
  ; Adds an interval
  ; @param  {[type]} define (add-interval a b [description]
  ; @return {[type]}        [description]
 ; -
(define (add-interval a b)
  (cons (+ (lower a) (lower b))
        (+ (upper a) (upper b))))
; -
  ; Subtracts an interval
  ; @param  {[type]} define (subtract-interval a b [description]
  ; @return {[type]}        [description]
 ; -
(define (subtract-interval a b)
  (cons (- (lower a) (upper b))
        (- (upper a) (lower b))))
; -
  ; Multiplies an interval
  ; @param  {[type]} define (multiply-interval a b [description]
  ; @return {[type]}        [description]
 ; -
(define (multiply-interval a b)
  (cons (min ( ; (lower a) (lower b)) ( ; (lower a) (upper b)) ( ; (upper a) (lower b)) ( ; (upper a) (upper b)))
        (max ( ; (lower a) (lower b)) ( ; (lower a) (upper b)) ( ; (upper a) (lower b)) ( ; (upper a) (upper b)))))
; -
  ; Divides an Interval
  ; @param  {[type]} define (divide-interval a b [description]
  ; @return {[type]}        [description]
 ; -
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
; -
  ; Array.reduce function from javascript
  ; @param  {[type]} define (accumulate   operator initial sequence [description]
  ; @return {[type]}        [description]
 ; -
(define (accumulate operator initial sequence)
  (if (null? sequence)
      initial
      (operator (car sequence) (accumulate operator initial (cdr sequence)))))
;a
; -
  ; Mapping function using accumulate, and cons
  ; @param  {[type]} define (my-map       proc seq [description]
  ; @return {[type]}        [description]
 ; -
(define (my-map proc seq)
  (accumulate (lambda (x y) (cons (proc x) y)) '() seq))
;b
; -
  ; Appends a sequence using accumulate and cons
  ; @param  {[type]} define (my-append    seq1 seq2 [description]
  ; @return {[type]}        [description]
 ; -
(define (my-append seq1 seq2)
  (accumulate cons seq2 seq1))
;c
; -
  ; uses accumulate to get length
  ; @param  {[type]} define (my-length    seq [description]
  ; @return {[type]}        [description]
 ; -
(define (my-length seq)
  (accumulate (lambda (x y) (+ y 1)) 0 seq)) ; count number of 'y's (current els)

;q3)
; -
  ; cons using a lambda that binds x y to a procedure
  ; @param  {[type]} define (special-cons x y [description]
  ; @return {[type]}        [description]
 ; -
(define (special-cons x y)
  (lambda (m) (m x y)))
; -
  ; Retrieves first value in pair formed by special-cons proc
  ; @param  {[type]} define (special-car  z [description]
  ; @return {[type]}        [description]
 ; -
(define (special-car z)
  (z (lambda (p q) p)))
; -
  ; Retrieves last value in pair formed by special-cons
  ; @param  {[type]} define (special-cdr  z [description]
  ; @return {[type]}        [description]
 ; -
(define (special-cdr z)
  (z (lambda (p q) q)))
;c)
; -
  ; Uses special cons to tie three els together.
  ; @param  {[type]} define (triple       x y z [description]
  ; @return {[type]}        [description]
 ; -
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
; -
  ; Powerset of list 'list'
  ; @param  {[type]} define (subsets      list [description]
  ; @return {[type]}        [description]
 ; -
(define (subsets list)
  (if (not (empty? list))
      (let ((universe (subsets (cdr list))))
        (append (map (lambda (x) (cons (first list) x))
                     universe)
                universe))
      '(())))
;b)
; -
  ; The intersection of set 1 and set 2 iteratively
  ; @param  {[type]} define (intersection-set-iter s1 s2 [description]
  ; @return {[type]}        [description]
 ; -
(define (intersection-set-iter s1 s2)
  (define (helper s1 s2 reduce)
    (cond ((null? s1) reduce)
          (else (helper (cdr s1) s2 (if (member (car s1) s2) (append (list (car s1)) reduce) reduce)))))
  (helper s1 s2 '()))

;c)
; -
  ; Same as above, but recursive.
  ; @param  {[type]} define (intersection-set s1 s2 [description]
  ; @return {[type]}        [description]
 ; -
(define (intersection-set s1 s2)
  (filter (lambda (x) (member x s2)) s1))

(define (mean L)
  (let ((l (filter number? L)))
    (/ (accumulate + 0 l) (length l))))

;q5
(define (compose f g)(lambda (x) (f (g x))))
; -
  ;  currys procedures with procedure f to apply to value applied to procedure that is returned.
  ;  @param  {[type]} define (repeated     f n [description]
  ;  @return {[type]}        [description]
 ; -
(define (repeated f n)
  (if (> n 0)
      (compose (repeated f (- n 1)) f)
      identity))
; -
  ;  Same as above but iteratively.
  ;  @param  {[type]} define (repeated-iter f n [description]
  ;  @return {[type]}        [description]
 ; -
(define (repeated-iter f n)
  (if (<= n 0)
      identity
      (compose (repeated-iter f (- n 1)) f))) ; call (repeat (sqr (- n 1)) sqr) -> does sqr, will do again until n is 0. then returns identity to show value

;q6
; -
  ; Counts the depth recursively. Counts depth of all leaves, and use cool hack apply to max to return largest of branches.
  ; @param  {[type]} define (depth        T [description]
  ; @return {[type]}        [description]
 ; -
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
; -
  ; Finds index.
  ; @param  {[type]} define (index        i L [description]
  ; @return {[type]}        [description]
 ; -
(define (index i L)
  (if (eq? i 0)
      (car L)
      (if (null? L)
          (error 'IndexOutOfRangeError)
          (index (- i 1) (cdr L)))))

(define r (lambda (p x) (if (null? x) x (p x))))
; -
  ; rearrange a list in terms of the indices but with the elements placed at specified indicies.
  ; @param  {[type]} define (rearrange    indices elements [description]
  ; @return {[type]}        [description]
 ; -
(define (rearrange indices elements)
  (define (helper current indy L)
    (cond ((null? current) L)
          ((number? current) (helper (r car indy) (r cdr indy) (append L (list (index (- current 1) elements)))))
          ((list? current) (helper (r car indy) (r cdr indy)   (append L (list (rearrange current elements)))))))
  (cdr (helper (car indices) indices '())))

;q8
; -
  ; Maps a tree using proc f.
  ; @param  {[type]} define (treemap      f T [description]
  ; @return {[type]}        [description]
 ; -
(define (treemap f T)
  (cond
    ((null? T) '())
    ((list? T) ;if pair, return new pair of map of left and right
         (cons (treemap f (car T))
               (treemap f (cdr T))))
    ((number? T) (f T))))

(provide (all-defined-out))
