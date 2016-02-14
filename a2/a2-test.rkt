#lang racket
(require "a2.rkt")
;q1 - testing
(define a (make-interval 5 10))
(define b (make-interval 10 20))
(define c (make-interval 0 10))

(display "Question 1:\n")
(~a "(add-interval (make-interval 5 10) (make-interval 10 20)) => " (add-interval a b))
(~a "(subtract-interval (make-interval 10 20) (make-interval 0 10)) => " (subtract-interval b c))
(~a "(multiply-interval (make-interval 5 10) (make-interval 10 20)) => " (multiply-interval a b))
(~a "(divide-interval (make-interval 5 10) (make-interval 0 10)) => " (divide-interval a c))

;q2 - testing
(display "Question 2:\n")
(~a "(my-map sqr (list 1 2 3 4 5)) => " (my-map sqr (list 1 2 3 4 5)))
(~a "(my-append (list 6 7 8 9) (list 1 2 3 4 5)) => " (my-append (list 6 7 8 9) (list 1 2 3 4 5)))
(~a "(my-map sqr (list 1 2 3 4 5) => " (my-map sqr (list 1 2 3 4 5)))

;q3 - testing
(display "Question 3: \n")
(~a "(special-car (special-cons 1 2)) => " (special-car (special-cons 1 2))); => 1
;b)
(~a "(special-cdr (special-cons 1 2)) => " (special-cdr (special-cons 1 2))); => 2
(~a "(special-car (special-car (special-cons (special-cons 1 2) 3))) => " (special-car (special-car (special-cons (special-cons 1 2) 3)))); => 1

(define triple_test (triple 1 2 3))
(~a "(triple-first triple_test) => " (triple-first triple_test)); -> 1
(~a "(triple-second triple_test) =>  " (triple-second triple_test)); -> 2
(~a "(triple-third triple_test) => " (triple-third triple_test)); -> 3

;q4 - testing
(display "Question 4: \n")
(~a "a) (subsets (list 1 2 3)) => " (subsets (list 1 2 3)))
(~a "b) (intersection-set-iter (list 1 2 3) (list 2 3 4)) => " (intersection-set-iter (list 1 2 3) (list 2 3 4))); => '(3,2)

(~a "c) (mean '(1 2 3 4 5)) => " (mean '(1 2 3 4 5)))
(~a "c) (mean '(1 _a 2 _b _c _d _e 3)) => " (mean '(1 _a 2 _b _c _d _e 3)))

;q5 - testing
(display "Question 5: \n")
(~a "((repeated sqr 3) 2) => " ((repeated sqr 3) 2))
(~a "((repeated-iter sqr 3) 2) => " ((repeated-iter sqr 3) 2))

;q6 - testing
(display "Question 6: \n")
(~a "(depth 'a) => " (depth 'a)); → 0
(~a "(depth '(a)) => " (depth '(a))); → 1
(~a "(depth '(a (b) c)) => " (depth '(a (b) c))); → 2
(~a "(depth '(((((a(((b))))))))) => " (depth '(((((a(((b)))))))))); → 8

;q7 - testing
(display "Question 7: \n")
(~a "(rearrange '(4 3 2 1) '(a b c d)) -> " (rearrange '(4 3 2 1) '(a b c d))); → (d c b a)
(~a "(rearrange '(4 3 2 1 1 2 3 4) '(a b c d)) -> " (rearrange '(4 3 2 1 1 2 3 4) '(a b c d))); → (d c b a a b c d)
(~a "(rearrange '(4 (4 2) 1) '(a b c d)) -> " (rearrange '(4 (4 2) 1) '(a b c d))); → (d (d b) a)
(~a "(rearrange '(1 2 4 2 3) '(a (b) ((c)) d)) -> " (rearrange '(1 2 4 2 3) '(a (b) ((c)) d))); → (a (b) d (b) ((c)))
;(~a "(rearrange '(4 2) '(a b)) -> " (rearrange '(4 2) '(a b))); → index out of range error

;q8 - testing
(display "Question 8: \n")
(~a "(treemap sqr '(1 (2 3) ((4 5) (6 7)) (((8 (9)))))) => " (treemap sqr '(1 (2 3) ((4 5) (6 7)) (((8 (9)))))))
