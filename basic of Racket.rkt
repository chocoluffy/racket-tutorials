#lang racket
(define x 3)

(define my_bad
  (lambda (x y) (+ x y)))

(define (adding x y)
  (+ x y))

; no mutation! define:

;(let* (local bindings) body)
;evaluate all the bindings, then evaluate the body, and return the value of body

(define (f x y z)
  (let* ([temp (* x 10)]
         [temp2 (+ y z)])
    (< temp temp2)
    )
  )


;cond
; passes the value to functions for the substitutions. "eager evaluation"
; Racket uses left-to-right eager evaluation
; "lazy evaluation" : python Stream

;'(1 2 (+ 1 2)) : quote will turn a list into literal
;'(first '(sqr 1 2)) : 'sqr
; first \ rest
; cons : construct a new list (number and a list)
; append : append a list with another list

(define (sum lst)
  (cond [(empty? lst) 0]
        [else (+ (first lst) (sum (rest lst)))])
  )

#|

(define (f x)
(g x))

(define (g x)
(+ 1 x))

eager evaluation happens in the call

+ can be returned to f without evaluating in g

tail call optimization : from linear space to constant space;

modern interpreter can detect a tail recursion and convert it to a for loop;

compilers: optimizatoin;

|#






