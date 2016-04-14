#lang racket
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream a b)(cons a (delay b)))))
;defs
(define (stream-car s)(car s))
(define (stream-cdr s)(force (cdr s)))
(define (stream-null? stream )
     (null? stream))

;a.i
; (stream-ref str n) -- returns the nth element in stream str
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))
;a.ii
;(stream-filter pred str) -- makes a new stream of elements satisfying pred
(define (stream-filter pred s)
  (if (pred (stream-car s))
      (cons-stream (stream-car s)
                   (stream-filter pred (stream-cdr s)))
      (stream-filter pred (stream-cdr s))))
;a.iii
;(stream-map proc str) -- applies proc to each element of str
(define (stream-map procedure stream )
     (if (stream-null? stream )
          '()
          (stream (procedure (stream-car stream))
                                (stream-map procedure (stream-cdr stream)))))
;a.iv
;(first n str) -- makes a new stream of the first n items in str
(define (first n s)
  (if (= n 0)
        '()
        (cons-stream (stream-car s) (first (- n 1) (stream-cdr s)))))
;a.v
;(list->stream lis) -- makes a stream from list lis
(define (list->stream list)
	  (if (null? list)
              '()
              (cons-stream (car list) (list->stream (stream-cdr list)))))
;a.vi
;(stream->list str) -- reverse of above (assume str is finite)
(define (stream->list list)
  	  (if (null? list)
              '()
              (cons (car list) (stream->list (stream-cdr list)))))
;GENERATORS
;b.i
;an infinite stream of 1's
(define (ones-gen)
  (cons-stream 1 (ones-gen)))
;b.ii
;an infinite stream of all odd integers
(define (odds-gen)
  (define (odd n)
    (cons-stream n (odd (+ n 2))))
  (odd 1))
;b.iii
;an infinite stream of random numbers between 1 and 100
(define (random-gen)
  (cons-stream (random 100) (random-gen)))
;b.iv
;an infinite stream of the values of function f(n) = f(n-1) + 2f(n-2) + 3f(n-3) (given f(n)=n iff n<4).
(define (fib-gen)
  (define (fib n)
    (cond ((< n 4) n)
          (else (+ (fib (- n 1)) (* 2 (fib (- n 2))) (* 3 (fib (- n 3)))))))
  (define (gen n)
    (cons-stream (fib n) (gen (+ n 1))))
  (gen 0))
;prelim def for c
(define (seq-gen)
  (define (a n) (cons-stream n (a (+ n 1)))) (a 1))
;c
(define (partial-sums stream)
  (define (h n s)
    (cons-stream n (h (+ n (stream-car (stream-cdr s))) (stream-cdr s))))
  (h (stream-car stream) stream))
(provide (all-defined-out))
