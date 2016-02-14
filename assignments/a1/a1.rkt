#lang R5RS
;@author Seena Rowhani [100945353]
;Question 1
;================================
(define q1-a (+ 2 (* 4 (+ (* 3 4) (* 6 7)) 9)))
(define q1-b (+ -1 (/ (* (+ 3 (* 4 1) -6) 3) (* 7 2))))

(display "Question 1\na) ")
(display q1-a)
(display "\nb) ")
(display q1-b)
;Question 2
;================================
;Recursive factorial.
;@args n (type Number)
;@output [type Number]
;f(n) = n, if n<4 
;f(n) = f(n-1) + 2f(n-2) + 3f(n-3) + 4f(n-4), otherwise
(define (rec-f n)
  (if (< n 4) n
              (+ (rec-f (- n 1))
                 (* 2 (rec-f (- n 2)))
                 (* 3 (rec-f (- n 3)))
                 (* 4 (rec-f (- n 4))))))
;Iterative factorial.
;Supply value n, calls helper function enclosed within it-f, that uses tail recursion to
;execute the recursive process in rec-f in constant time.
;@args n (type Number)
;@output [type Number]
(define (it-f n)
  (define (it-f-iter a b c d i)
  (if (< i 4)
      a
      (it-f-iter (+ a (* 2 b) (* 3 c) (* 4 d)) a
                 b
                 c
                 (- i 1))))
  (it-f-iter 3 2 1 0 n))
(display "\nQuestion 2\n(rec-f 3) => ")
(display (rec-f 3))
(display "\n(it-f 3) => ")
(display (it-f 3))
(display "\n(rec-f 6) => ")
(display (rec-f 6))
(display "\n(it-f 6) => ")
(display (it-f 6))

;Question 3
;================================
;(pascals r c)
;@arg r - index for current row
;@arg c - index for current column
;If the column index is 0, or the column is equal to row
;on the triangle, the element is a 1. The goal is to
;count the number of ones recursively. This will give you the value
; of the element at row r, column c.
;@output [type Number]
(define (pascals r c)
  (cond ((= c 0) 1) ; along left side of tri
        ((= c r) 1) ; along right side of tri
        (else (+ (pascals (- r 1) (- c 1))
                 (pascals (- r 1) c)))))
(display "\nQuestion 3\n(pascals 0 0) => ")
(display (pascals 0 0))
(display "\n(pascals 2 1) => ")
(display (pascals 2 1))
(display "\n(pascals 4 2) => ")
(display (pascals 4 2))
;Question 4
;================================
;increments a given x by 1
(define (inc x) (+ x 1))
;returns value x given x.
(define (identity x) x)
(define (sum-integers a b)
	(sum identity a inc b))
;(sum term a next b)
;@arg term - procedure to apply to current iterated value
;@arg a - number at which to start summation.
;@arg next - procedure to apply to iterate to next value.
;Sums numbers from a to b
;@output [type Number]
(define (sum term a next b)
  (define (iter current result)
    (if (> current b)
        result
        (iter
          (next current)
          (+ (term current) result))))
  (iter a 0))

(display "\nQuestion 4\n(sum identity 1 inc 3) => ")
(display (sum identity 1 inc 3))
(display "\n(sum identity 10 inc 15) => ")
(display (sum identity 10 inc 15))

;Question 5
;================================
;a)
;(product term a next b)
;@arg term - procedure to apply to current value during iteration.
;@arg a - starting value
;@arg next - procedure to iterate through a to b
;@arg b - ending value
; Recursively returns product of a to b.
;@output [type Number]
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))
(display "\nQuestion 5\na) (product identity 1 inc 3) => ")
(display (product identity 1 inc 3))
(display "\n(product identity 10 inc 15) => ")
(display (product identity 10 inc 15))
;b)
;(factorial n)
;@arg n - number of which to return factorial of.
;@output [type Number]
(define (factorial n)
  (product identity 1 inc n))
(display "\nb) (factorial 0) => ")
(display (factorial 0))
(display "\n(factorial 1) => ")
(display (factorial 1))
(display "\n(factorial 5) => ")
(display (factorial 5))
;c)
;(product-iter term a next b)
;@arg term - procedure to apply to current value during iteration.
;@arg a - starting value
;@arg next - procedure to iterate through a to b
;@arg b - ending value
;returns product of all numbers from a - b in an iterative manner (tail recursive).
(define (product-iter term a next b)
  (define (iter current result)
    (if (> current b)
        result
        (iter
         (next current)
         (* (term current) result))))
  (iter a 1))
(display "\nc) (product-iter identity 1 inc 5) => ")
(display (product-iter identity 1 inc 5))
;Question 6
;================================
; a) Applicative order will never stop evaluating. It will evaluate all arguments when
; the procedure is applied. So it will keep evaluating y, leading to infinite recursion.
; UNLESS you use lazy evaluation. Which changes schemes behaviour to normal ordered.
;
; b) With normal order, the test procedure will return 0. Normal order evaluates arguments when
; the actual argument is NEEDED.
;
; c) Scheme uses applicative order.

;Question 7
;================================
;(cube x)
;@arg x - number of which to cube-root.
;Returns cube root of x by using newtons method of approximation.
;@output [type Number]
(define (cube x)
  (define (good? guess)
    (< (/ (abs (- (* guess guess guess) x)) guess) 0.0001))

  (define (improve y)
    (/ (+ (/ x (* y y)) (* 2 y)) 3))

  (define (iter attempt)
    (if (good? attempt)
        attempt
        (iter (improve attempt))
    ))
  (iter 1.0))
(display "\nQuestion 7\n(cube 64) => ")
(display (cube 64))
(display "\n(cube 512) => ")
(display (cube 512))
;Question 8
;================================
(define (a-b a b)
   ((cond ((> b 0)+)
          ((= b 0) -)
          (else *)) a b))

; What happens:
;   There is a condition procedure which determines what operator to use..
;     If b is greater than 0, it will add a and b together
;     If b is equal to 0, it will subtract b from a
;     Otherwise, b is less than 0, multiply a and b together
;   This procedure that's been created we now apply arguments a and b to it.

;(a-b 5 10)
;(+ 5 10)
;15
;(a-b 5 0)
;(- 5 0)
;5
;(a-b 5 -1)
;(* 5 -1)
;-5

;Question 9
;================================
(define (good? g x)
  (< (abs (- (* g g) x)) 0.000000000000001))

;a)
(define (sqrt x good?)
  (define (average x y)
    (/ (+ x y) 2))

  (define (improve guess)
    (average guess ( / x guess)))

  (define (sqrt-iteration guess)
        (if (good? guess x)
            guess
            (sqrt-iteration (improve guess))))
  (sqrt-iteration 1.0))
;b)
(define (sqrt2 x good? limit)
  (define (average x y)
    (/ (+ x y) 2))

  (define (improve guess)
    (average guess ( / x guess)))

  (define (sqrt-iteration guess lim)
    (if (< lim 1)
        guess
        (if (good? guess x)
            guess
            (sqrt-iteration (improve guess) (- lim 1)))))
  (sqrt-iteration 1.0 limit))
;c)
(define (new-if predicate consequent alternate)
   (cond (predicate consequent)
         (else alternate)))

(define (sqrt3 x good? limit)
  (define (average x y)
    (/ (+ x y) 2))

  (define (improve guess)
    (average guess ( / x guess)))

  (define (sqrt-iteration guess lim)
    (new-if (< lim 1)
        guess
        (new-if (good? guess x)
            guess
            (sqrt-iteration (improve guess) (- lim 1)))))
  (sqrt-iteration 1.0 limit))
;  It doesn't work. It looks like the else block also gets evaluated, resulting in an infinite loop.

;Testing
;Question 1
;a) 1946
;b) -11/14
;Question 2
;(rec-f 3) => 3
;(it-f 3) => 3
;(rec-f 6) => 63
;(it-f 6) => 63
;Question 3
;(pascals 0 0) => 1
;(pascals 2 1) => 2
;(pascals 4 2) => 6
;Question 4
;(sum identity 1 inc 3) => 6
;(sum identity 10 inc 15) => 75
;Question 5
;a) (product identity 1 inc 3) => 6
;(product identity 10 inc 15) => 3603600
;b) (factorial 0) => 1
;(factorial 1) => 1
;(factorial 5) => 120
;c) (product-iter identity 1 inc 5) => 120
;Question 7
;(cube 64) => 4.000000000076121
;(cube 512) => 8.00000003355707