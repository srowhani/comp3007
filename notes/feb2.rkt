#lang racket

(define (reduce op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (reduce op initial (cdr sequence)))))
;create a list of values a-b
; enumerate 1 10 -> 1 ... 10
(define (enum a b)
  (if (> a b)
      '()
      (cons a (enum (+ a 1) b))))

;compute the list of even fibonacci numbers from 1 to 20

(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(define a (enum 1 20))
(map fib (enum 1 20))
(filter even? (map fib (enum 1 20)))

;compute the list of squares of the first 10 fibonacci numbers

(map (lambda (x)(* x x))(map fib (enum 1 10)))
;compute the product of the square of all odd numbers from 1 to 100
(reduce * 1 (map (lambda (x)(* x x))(filter odd? (enum 1 100))))

(define (flatten-map procedure sequence) 
        (reduce append '() (map procedure sequence)))
;(map (lambda (x) (list x x)) (list 1 2 3)) => '((1 1) (2 2) (3 3))

(define x (list 1 3 (list 5 7) 9))
(car (cdaddr x)) ; returns 7

(define y (cons 1 (cons 3 (cons (cons 5 (cons 7 '())) (cons 9 '())))))

(define _a (list 1 2 3))
(define _b (list 4 5 6))

;know the difference between cons, list, and append


;tree stuff
(define T (list (list 1 2) 3 4))
(define (initialize-tree) '())	     ; Initialize a tree as empty
(define (make-tree root left right)
  (list root left right))
(define (count-leaves tree)
  (cond ((null? tree) 0) ;tree is null
        ((not (pair? tree)) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))))

(define (in-tree? x t) 
  (cond	((null? t) #f)
        ((= x (car t))	#t) 
        ((> x (car t)) (in-tree? x (caddr t)))
        ((< x (car t)) (in-tree? x (cadr t)))))


(define (insert x t)                 ; Create tree if empty
  (cond ((null? t) 
         (make-tree x (initialize-tree) (initialize-tree)))
        ((> x (car t))              ; Add to right subtree
         (make-tree (car t) (cadr t) 
                    (insert x (caddr t))))
        ((< x (car t))              ; Add to left subtree
         (make-tree (car t) (insert x (cadr t)) 
                    (caddr t)))))              
(define (print-tree t)               ; Empty tree is not printed!
  (if (not (null? t))
      (begin 
        (display "(")
        (display (car t))
        (display ";")
        (print-tree (cadr t))
        (display ";")
        (print-tree (caddr t))
        (display ")"))
      #f
      ))
(define t0 (initialize-tree))
(define t1 (insert 5 t0)) 
(define t2 (insert 3 t1))
(define t3 (insert 7 t2))
(define t4 (insert 2 t3))
(define t5 (insert 6 t4))
(print-tree t5)
(newline)
;(count T)
;(+ (count (list 1 2) (count (list 3 4)))
;...
;(+ (+ 1 1) (+ 1 1))