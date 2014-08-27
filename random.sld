;;;=============================================================================

;;; File: "random.sld"

;;; Copyright (c) 2006-2014 by Marc Feeley, All Rights Reserved.

;;;=============================================================================

;;; Provides procedures to get random bits of high quality.

(define-library (http://github.com/feeley/random)

  (export make-random-u8vector
          random-nonneg-integer)

  (import (gambit)
          (http://github.com/feeley/nonneg-integer))

  (include "random.scm")
)

;;;=============================================================================
