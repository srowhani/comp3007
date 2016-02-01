#lang racket
(define (t x y) (lambda (m)(m x y)))
(define y (t 1 2))
(display (y +))

(define a (list 1 2 3 4 5))


(define (get items n)
  (if (= n 0)
      (car items)
      (get (cdr items) (- n 1))))

(define (len L)
  (if (null? L)
      0
      (+ 1 (len (cdr L)))))
(define (push L1 L2)
  (if (null? L1)
      L2
      (cons (car L1) (push (cdr L1) L2))))
(define (reverse L)
  (if (null? L)
      L
      (push (reverse (cdr L)) (list (car L)))))
(define (rev-iter L)
  (define (iter items res)
    (if (null? items)
        res
        (iter (cdr items) (cons (car items) res))))
  (iter L `()))

;(iter (list 1 2 3) '())
;(iter (list 2 3) (list 1))
;(iter (list 3) (list 2 1))
;(iter (list '()) (list 3 2 1))
;(list 3 2 1)

(define (scale L factor)
  (if (null? L)
      '()
      (cons (* (car L) factor)
            (scale (cdr L) factor))))
(define (map L procedure)
   (if (null? L)
      '()
      (cons ((procedure (car L))
            (map (cdr L) procedure))))