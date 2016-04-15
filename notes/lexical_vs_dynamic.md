Scope rules define the visibility rules for names in a programming language. What if you have references to a variable named k in different parts of the program? Do these refer to the same variable or to different ones?

Languages such as Haskell, Algol, Ada, C, Pascal and Scheme are lexically scoped. A block defines a new scope. Variables can be declared in that scope, and aren't visible from the outside. However, variables outside the scope -- in enclosing scopes -- are visible unless they are overridden (shadowed). In Algol and Pascal (but not C or Ada) these scope rules also apply to the names of functions and procedures.

Lexical scoping is also called static scoping.

Lexical Scoping Examples

We'll use Scheme to write the examples -- but the concept applies in many different languages.

(define m 50)
(define n 100)

(define (hardy)
   (display (list "In Hardy, n=" n))
   (newline))

(define (laurel n)
   (display (list "In Laurel, m=" m))
   (newline)
   (display (list "In Laurel, n=" n))
   (newline)
   (hardy))


(display (list "In main program, n=" n))
(newline)
(laurel 1)
(hardy)
Output:
In main program, n = 100
In laurel, m = 50
In laurel, n = 1
In hardy, n = 100     ;; called from laurel
in hardy, n = 100   ;; called from main
Dynamic Scoping

Some older languages use dynamic scoping. Using this scoping rule, we first look for a local definition of a variable. If it isn't found, we look up the calling stack for a definition. Dynamic scoping was the norm in versions of Lisp before Common Lisp, and is also used in some older, interpreted languages such as SNOBOL and APL. We can declare a variable as dynamically scoped in Common Lisp using defvar (but not in Scheme).
Example:

;; Repeat the  example above, but assume
;; that Scheme is dynamically scoped.
Output:
In main program, n = 100
In laurel, m = 50
In laurel, n = 1
In hardy, n = 1     ;; <== NOTE!!  called from laurel
in hardy, n = 100   ;; called from main


DYNAMIC LOOKS UP STACK
LEXICAL LOOKS UP ENCLOSING ENVIRONMENTS UP TO ROOT
