#lang racket


;creating a procedure that returns a procedure that takes a string as method.
;knows which to run based on param

(define (account balance)
  (define (withdraw am)
    (if (>= balance am)
        (begin
          (set! balance (- balance am))
          balance)
        "Other if option"))
  (define (deposit am)
    (set! balance (+ balance am))
    balance)
  (lambda (m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error (string-append "Unknown Request: [" (symbol->string m) "]"))))))

(((account 10000) 'withdraw) 100)
(((account 10000) 'wrong_symbol) '())

          