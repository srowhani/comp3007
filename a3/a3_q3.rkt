#lang racket
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream a b)(cons a (delay b)))))

(define (stream-car s)(car s))
(define (stream-cdr s)(force (cdr s)))
(define (stream-null? stream ) 
     (null? stream))

;a.i
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))
;a.ii
(define (stream-filter pred s)
  (if (pred (stream-car s))
      (cons-stream (stream-car s)
                   (stream-filter pred (stream-cdr s)))
      (stream-filter pred (stream-cdr s))))
;a.iii
(define (stream-map procedure stream ) 
     (if (stream-null? stream ) 
          '()
          (stream (procedure (stream-car stream)) 
                                (stream-map procedure (stream-cdr stream)))))
;a.iv
(define (first n s)
  (if (= n 0)
        '()
        (cons-stream (stream-car s) (first (- n 1) (stream-cdr s)))))
;a.v
(define (list->stream list)
	  (if (null? list)
              '()
              (cons-stream (car list) (list->stream (stream-cdr list)))))
;a.vi
(define (stream->list list)
  	  (if (null? list)
              '()
              (cons (car list) (stream->list (stream-cdr list)))))

;b.i
(define (ones-gen)
  (cons-stream 1 (ones-gen)))
;b.ii
(define (odds-gen)
  (define (odd n)
    (cons-stream n (odd (+ n 2))))
  (odd 1))
;b.iii
(define (random-gen)
  (cons-stream (random 100) (random-gen)))
;b.iv
(define (fib-gen)
  (define (fib n)
    (cond ((< n 4) n)
          (else (+ (fib (- n 1)) (* 2 (fib (- n 2))) (* 3 (fib (- n 3)))))))
  (define (gen n)
    (cons-stream (fib n) (gen (+ n 1))))
  (gen 0))
;c
(define (partial-sums stream)
  (define (h n s)
    (cons-stream n (h (+ n (stream-car (stream-cdr s))) (stream-cdr s))))
  (h (stream-car stream) stream))

(provide (all-defined-out))
