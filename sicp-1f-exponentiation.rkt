;;; sicp-1f-exponentiation.rkt

#lang racket

(require "check.rkt"
         "simple-table.rkt")


;; Recursive exponentiation.
;; Theta(n) steps.
;; Theta(n) space.
(define (expo1 b n)
  (if (= n 0) 
      1
      (* b (expo1 b (- n 1)))))

;; As tail-recursive procedure.
;; Steps ==> Theta(n).
;; Space ==> Theta(1)
(define (expo2 b n)
  (let loop ((n n) (result 1))
      (if (zero? n)
          result
          (loop (sub1 n)
                (* b result)))))

;; Fast exponentiation: b^8...
;; b^8 = b^4 * b^4
;; b^4 = b^2 * b^2
;; b^2 = b^1 * b^1
;;
;; Fast exponentiation: b^12...
;; b^12 = b^6 * b^6
;; b^6  = b^3 * b^3
;; b^3  = b^1 * b^2 (odd case)
;; b^2  = b^1 * b^1
;;
;; Use these recursive steps to reduce the
;; problem to a smaller one.
;;
;; (even n) b^n = (b^(n/2))^2
;; (odd  n) b^n = b^1 * b^(n-1)
;;
;; Steps grow as Theta(log(n)).
(define (expo3 b n)
  (define (square x) (* x x))
  (cond ((= n 0)
         1)
        ((odd? n) 
         (* b (expo3 b (sub1 n))))
        (else
         (square (expo3 b (/ n 2))))))



;; Exercise 1.16 ========================================

;; Iterative (tail recursive) version of fast exponentiation.
;; Use an extra state variable that accumulates the answer,
;; such that a*b^n 9s always the same. Since a starts at 1,
;; the combination a*b^n = b0^n0 at every step. When
;; the computation terminates, n=0 and b^n is 1, meaning
;; that a=b0^n0 now.
;;
;; Use [b^(n/2)]^2 = [b^2]^(n/2)
;;
;; To reduce the size of n when n is even.
(define (expo4 b n)
  (define (square x) (* x x))
  (let loop ((b b) (n n) (a 1))
    (cond ((= n 0)
           a)
          ((odd? n)
           (loop b 
                 (sub1 n) 
                 (* b a)))
          (else
           ;; Note that this only makes n smaller.
           ;; There's no actual "computation"! We
           ;; are instead increasing the size of b
           ;; and decreasing n!
           (loop (square b) 
                 (/ n 2) 
                 a)))))
 
;; Beautiful idea!


;; Exercise 1.17 ========================================


;; Exercise 1.18 ========================================

 
;; Exercise 1.19 ========================================




