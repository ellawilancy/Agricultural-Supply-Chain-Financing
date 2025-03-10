;; Inventory Verification Contract

;; Data Maps
(define-map inventory
  { product-id: uint }
  { owner: principal, quantity: uint, quality: (string-ascii 20) })

;; Public Functions
(define-public (add-inventory (product-id uint) (quantity uint) (quality (string-ascii 20)))
  (let ((caller tx-sender))
    (if (is-eq (map-get? inventory { product-id: product-id }) none)
      (ok (map-set inventory { product-id: product-id } { owner: caller, quantity: quantity, quality: quality }))
      (err u1))))

(define-public (update-inventory (product-id uint) (new-quantity uint) (new-quality (string-ascii 20)))
  (let ((item (unwrap! (map-get? inventory { product-id: product-id }) (err u2))))
    (if (is-eq (get owner item) tx-sender)
      (ok (map-set inventory { product-id: product-id } { owner: tx-sender, quantity: new-quantity, quality: new-quality }))
      (err u3))))

;; Read-only Functions
(define-read-only (get-inventory (product-id uint))
  (map-get? inventory { product-id: product-id }))

