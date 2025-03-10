;; Financing Management Contract

;; Data Maps
(define-map loans
  { loan-id: uint }
  { borrower: principal, amount: uint, collateral-type: (string-ascii 20), collateral-id: uint, status: (string-ascii 20) })

;; Variables
(define-data-var next-loan-id uint u1)

;; Public Functions
(define-public (request-loan (amount uint) (collateral-type (string-ascii 20)) (collateral-id uint))
  (let ((loan-id (var-get next-loan-id)))
    (map-set loans
      { loan-id: loan-id }
      { borrower: tx-sender, amount: amount, collateral-type: collateral-type, collateral-id: collateral-id, status: "pending" })
    (var-set next-loan-id (+ loan-id u1))
    (ok loan-id)))

(define-public (approve-loan (loan-id uint))
  (let ((loan (unwrap! (map-get? loans { loan-id: loan-id }) (err u1))))
    (if (is-eq (get status loan) "pending")
      (ok (map-set loans { loan-id: loan-id } (merge loan { status: "approved" })))
      (err u2))))

(define-public (repay-loan (loan-id uint))
  (let ((loan (unwrap! (map-get? loans { loan-id: loan-id }) (err u1))))
    (if (and (is-eq (get borrower loan) tx-sender) (is-eq (get status loan) "approved"))
      (ok (map-set loans { loan-id: loan-id } (merge loan { status: "repaid" })))
      (err u3))))

;; Read-only Functions
(define-read-only (get-loan (loan-id uint))
  (map-get? loans { loan-id: loan-id }))

