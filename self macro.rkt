#lang racket
; macro on self recursively define

; purpose: solving those method that need to call its own methods.
; using letrec allows to recursively define a function! so that we finish self method!
(define (A x)
  (letrec ([self
            (lambda (msg)
              (cond [(equal? msg "x") x]
                    [(equal? msg "f")
                     (lambda (y)
                       (+ x y))]
                    [(equal? msg "g")
                     (lambda ()
                       ; Need to call "f" on 3
                       ((self "f") 3))]
                    ))])
    ; The body is simply the function itself
    self))


(define-syntax class
  (syntax-rules ()
    [(class class-name (attr ...)
       [(method-name arg ...) body] ...)
     (define (class-name attr ...)
       ; use letrec here
       (letrec ([self
                 (lambda (msg)
                   (cond [(equal? msg (symbol->string (quote attr))) attr]
                         ...
                         [(equal? msg (symbol->string (quote method-name)))
                          (lambda (arg ...) body)]
                         ...
                         [else "Unrecognized message!"]))])
         self))]))

#|
Unfortunately, trying to define our class A using this macro yields an unbound identifier
 for self when we try to use it in the class definition. What gives?
Hygienic macros, that's what! Remember that to avoid inadvertent name capture
, all Racket macros obey lexical scope. In particular, this means that no identifier
bound in the body of a macro can be referenced from outside the macro definition.
In our case, we're trying to use self outside the macro to refer to the one bound locally
in the letrec in the macro definition. Because this isn't allowed, Racket cannot find a
binding for self when we use it in our class definition, causing the error.

(class A (x)
  [(f y) (+ x y)]
  [(g) ((self "f") 3)])

|#