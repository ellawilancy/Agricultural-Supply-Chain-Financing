;; Invoice Tokenization Contract

;; Data Maps
(define-map invoices
  { invoice-id: uint }
  { issuer: principal, amount: uint, status: (string-ascii 20) })

(define-map invoice-tokens
  { token-id: uint }
  { owner: principal, invoice-id: uint })

;; Variables
(define-data-var next-token-id uint u1)

;; Public Functions
(define-public (tokenize-invoice (invoice-id uint) (amount uint))
  (let ((caller tx-sender)
        (token-id (var-get next-token-id)))
    (if (is-eq (map-get? invoices { invoice-id: invoice-id }) none)
      (begin
        (map-set invoices { invoice-id: invoice-id } { issuer: caller, amount: amount, status: "tokenized" })
        (map-set invoice-tokens { token-id: token-id } { owner: caller, invoice-id: invoice-id })
        (var-set next-token-id (+ token-id u1))
        (ok token-id))
      (err u1))))

(define-public (transfer-token (token-id uint) (recipient principal))
  (let ((token (unwrap! (map-get? invoice-tokens { token-id: token-id }) (err u2))))
    (if (is-eq (get owner token) tx-sender)
      (ok (map-set invoice-tokens { token-id: token-id } (merge token { owner: recipient })))
      (err u3))))

;; Read-only Functions
(define-read-only (get-invoice (invoice-id uint))
  (map-get? invoices { invoice-id: invoice-id }))

(define-read-only (get-token (token-id uint))
  (map-get? invoice-tokens { token-id: token-id }))

