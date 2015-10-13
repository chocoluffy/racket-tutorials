#lang racket
(define (map_fake fn lst)
  (foldl (lambda (x y) (append y (list (fn x)))) (list (fn (first lst))) (rest lst))
  )
; use function foldl to simulate the effect of map, then since we could use map to simulate the filter, then we are done.