#lang racket/base

(provide literal-in-space
         ~space-literal)

(require syntax/parse ee-lib
         (for-syntax racket/base syntax/parse))

(define-syntax-class (literal-in-space target-id binding-space)
  (pattern id:id
           #:when (same-binding? ((in-space binding-space) (attribute id))
                                 ((in-space binding-space) target-id))))

(define-syntax ~space-literal
  (pattern-expander
   (syntax-parser
     [(_ target-id:id binding-space:id)
      #'(~var _ (literal-in-space #'target-id 'binding-space))])))