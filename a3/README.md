## COMP3007

__Student Name__: Seena Rowhani

__Student Number__: 100945353

#### Testing

Run the following command in terminal:

```bash
  racket aq_test.rkt
```

Or you can also run `a3_test.rkt` from __DrRacket__.

#### Notes

Regarding `a3_q4.rkt`, since there is a prompt for input, the input must be typed by whomever marks this assignment.

To test what's been specified, the following snipped should be sufficient.

```
  (let ((a 1)) (+ a 1))
```

Which should return 2.

__Lines of Interest in `a3_q4.rkt`__:

37: `((let? exp) (eval (let->combo exp) env))`

149:158: Where I've defined `let`.

### Test Output

```
"((g 'add-node) n1) -> (#<procedure:dispatch>)"
"((g 'add-node) n2) -> (#<procedure:dispatch> #<procedure:dispatch>)"
"((g 'add-node) n3) -> (#<procedure:dispatch> #<procedure:dispatch> #<procedure:dispatch>)"
"((g 'add-edge) e1) -> (#<procedure:dispatch>)"
"((g 'add-edge) e2) -> (#<procedure:dispatch> #<procedure:dispatch>)"
"((g 'add-edge) e3) -> (#<procedure:dispatch> #<procedure:dispatch> #<procedure:dispatch>)"
"((g 'add-edge) e4) -> Unable to add edge."
"((g 'print-graph)) -> ((1 (2 3)) (2 (3)) (3 ()))"
"(stream-ref (seq-gen) 5) -> 6"
"(stream->list (first 5 (seq-gen))) -> (1 2 3 4 5)"
"(stream->list (first 5 (stream-filter odd? (seq-gen)))) -> (1 3 5 7 9)"
"(stream->list (first 5 (random-gen))) -> (49 80 7 68 73)"

"(stream->list (first 10 (fib-gen))) -> (0 1 2 3 10 22 51 125 293 696)"
"(list->stream (list 1 2 3)) -> (1 . #<promise:...radigms/a3/a3_q3.rkt:4:30>)"
"(stream-cdr (list->stream (list 1 2 3))) -> (2 . #<promise:...radigms/a3/a3_q3.rkt:4:30>)"
"(stream->list (first 10 (partial-sums (seq-gen)))) -> (1 3 6 10 15 21 28 36 45 55)"
```
