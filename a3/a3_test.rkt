#lang racket
(require "a3_q1.rkt")
(require "a3_q3.rkt")
;q1==============================
(define g (make-graph))
(define n1 (make-node 1))
(define n2 (make-node 2))
(define n3 (make-node 3))
(define e1 (make-edge n1 n2))
(define e2 (make-edge n1 n3))
(define e3 (make-edge n2 n3))


((g 'add-node) n1)
((g 'add-node) n2)
((g 'add-node) n3)

((g 'add-edge) e1)
((g 'add-edge) e2)
((g 'add-edge) e3)

((g 'print-graph))

;q3==============================
