(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch method)
    (cond     ((eq? method 'withdraw) withdraw)
              ((eq? method 'deposit) deposit)
              (else (lambda() (display "Unknown Request: ")(display method)(newline)))))
  dispatch)

Make account creates a closure around balance
Define some procedures in there
Return a procedure (dispatch) that will reference these enclosed procedures
	Using symbols and a cond block kind of like an object referencing properties with keys.
