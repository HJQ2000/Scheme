(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.
(define(cons-all num list)
          (map (lambda (x) (cons num x)) list))


  (define (zip pairs)
      (cons (map (lambda (lst) (car lst)) pairs)
           (cons (map (lambda (lst) (car (cdr lst))) pairs) nil)
      )
    )

;; Problem 17
;; Returns a list of two-element lists

(define (enumerate s)
  ; BEGIN PROBLEM 17
  (define (helper num s)
    (if (null? s)
         nil
         (cons (cons num (cons (car s) nil))
               (helper (+ num 1) (cdr s))))
  )
  (helper 0 s))
  ; END PROBLEM 17


;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  (cond
    ((null? denoms) nil)
    ((< total 0) nil)
    ((= total 0) (list(list(car denoms))))
    ((> (car denoms) total) (list-change total (cdr denoms)))
    ((= (car denoms) total) (append (list-change (- total (car denoms)) denoms) (list-change total (cdr denoms))) )
    (else (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms)) (list-change total (cdr denoms))))
  ))


  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons form(cons params (let-to-lambda body) ))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
          ;(cons (cons 'lambda (cons (car (zip (values))) (let-to-lambda body)))(cadr (zip (values))))

           (cons (list 'lambda (car (zip (let-to-lambda values))) (car (let-to-lambda body))) (cadr (zip (let-to-lambda values))) ))
           ; END PROBLEM 19
           )
        (else
         ; BEGIN PROBLEM 19
         (map let-to-lambda expr)
         ; END PROBLEM 19
         )))
