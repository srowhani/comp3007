#lang racket
; make-node label
; Creates a Node Object
; @param  label - Label for given node
; @return Node
(define (make-node label)
  (define (get) label)
  (define (set l)
    (begin
      (set! label l)
      l))
  (define (dispatch m)
    (cond ((eq? m 'set) set)
          ((eq? m 'get) get)))
  dispatch)
; make-edge a b
; Creates an Edge object, essentially a relation between
; two Nodes.
; @param  a - Starting node
; @param  b - Ending node
; @return Edge
(define (make-edge a b)
  (define get (λ () (cons a b)))
  (define (dispatch m)
    (cond
      ((eq? m 'get) get)))
  dispatch)
  ; make-graph
  ; Creates a graph object.
  ; Maintains a collection of Nodes and Edges,
  ; and the relation between them.
  ; @return Graph
(define (make-graph)
  (let ((nodes '()) (edges '()))
    (define get-nodes (λ () nodes))
    (define get-edges (λ () edges))
    (define (add-node n)
      (begin
        (set! nodes (append nodes (list n)))
        nodes))
    (define (del-node n)
      (begin
        (set! nodes (remove n nodes))
        nodes))
    (define (add-edge e)
      (if (and (member (car ((e 'get))) nodes) (member (cdr ((e 'get))) nodes))
          (begin
            (set! edges (append edges (list e)))
            edges)
          "Unable to add edge."))
    (define (del-edge e)
      (begin
        (set! edges (remove e edges))
        edges))
    (define (print-graph)
      (map (λ (node)
        (append (list ((node 'get))) (list (map (λ (_edge)
          (if (eq? (car ((_edge 'get))) node)
            (((cdr ((_edge 'get))) 'get))
            (((car ((_edge 'get))) 'get))))
          (filter (λ (edge)
            (eq? node (car ((edge 'get)))))
            edges)))))
        nodes))
    (define (dispatch m)
      (cond ((eq? m 'add-node) add-node)
            ((eq? m 'del-node) del-node)
            ((eq? m 'add-edge) add-edge)
            ((eq? m 'get-nodes) get-nodes)
            ((eq? m 'get-edges) get-edges)
            ((eq? m 'del-edge) del-edge)
            ((eq? m 'print-graph) print-graph)))
    dispatch))

(provide (all-defined-out))
