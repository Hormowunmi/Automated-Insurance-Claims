;; Simple test contract
(define-constant ERR-NOT-AUTHORIZED u1)

(define-data-var contract-owner principal tx-sender)

(define-read-only (get-owner)
  (var-get contract-owner)
)
