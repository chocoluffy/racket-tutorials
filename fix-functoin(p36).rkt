#lang racket
(define (find-sub n lst front)
  (cond [(= n 1) front]
        [else (find-sub (- n 1) (rest lst) (append front (list (car lst))))])
  )

(define (find-sub-back n lst)
  (cond [(= n 1) lst]
        [else (find-sub-back (- n 1) (rest lst))]
    )
  )

(define (fix f n x)
  (lambda args
    (let ([front-args (find-sub n args '())]
         [back-args (find-sub-back n args)]
         )
    (apply f (append (append front-args (list x)) back-args))
    )
  ))