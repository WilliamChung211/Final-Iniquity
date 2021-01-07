#lang racket
(provide (all-defined-out))
(require "compile.rkt" "syntax.rkt" "asm/interp.rkt")

;; String -> Void
;; Compile contents of given file name,
;; emit asm code on stdout
(define (main fn)
  (with-input-from-file fn
    (λ ()
      (let ((p (sexpr->prog (read-program))))
        (unless (and (prog? p) (closed? p))
          (error "syntax error"))          
        (asm-interp (compile p))))))

(define (read-program)
  (regexp-match "^#lang racket" (current-input-port))
  (read))

(main "text.txt")