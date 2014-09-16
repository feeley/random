;;;=============================================================================

;;; File: "random.scm"

;;; Copyright (c) 2006-2014 by Marc Feeley, All Rights Reserved.

;;;=============================================================================

;;; Provides procedures to get random bits of high quality.

;;;=============================================================================

(define-library (https://github.com/feeley/random)

  (export make-random-u8vector
          random-nonneg-integer)

  (import (gambit)
          (https://github.com/feeley/nonneg-integer))

  (begin

;;;=============================================================================

(declare
  (standard-bindings)
  (extended-bindings)
  (fixnum)
  (not safe))

;;;----------------------------------------------------------------------------

(define random-bits-file "/dev/random")

(define (make-random-u8vector len)
  (let* ((in (open-input-file random-bits-file))
         (u8vect (make-u8vector len))
         (n (read-subu8vector u8vect 0 len in)))
    (close-input-port in)
    (if (= n len)
        u8vect
        (error "random bits file ended prematurely"))))

;;;----------------------------------------------------------------------------

(define (random-nonneg-integer range)

  (declare (generic))

  (let* ((range-bits (integer-length range))
         (len (quotient (+ range-bits 20) 8))
         (n (expt 256 len))
         (divisor (quotient n range))
         (limit (* divisor range)))
    (let loop ()
      (let* ((u8vect (make-random-u8vector len))
             (x (digits->nonneg-integer (u8vector->list u8vect) 256)))
        (if (>= x limit)
            (loop)
            (quotient x divisor))))))

))

;;;=============================================================================
