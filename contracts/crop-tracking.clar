;; Crop Tracking Contract

;; Data Maps
(define-map crops
  { crop-id: uint }
  { farmer: principal, crop-type: (string-ascii 64), planting-date: uint, status: (string-ascii 20) })

;; Public Functions
(define-public (register-crop (crop-id uint) (crop-type (string-ascii 64)) (planting-date uint))
  (let ((caller tx-sender))
    (if (is-eq (map-get? crops { crop-id: crop-id }) none)
      (ok (map-set crops { crop-id: crop-id } { farmer: caller, crop-type: crop-type, planting-date: planting-date, status: "planted" }))
      (err u1))))

(define-public (update-crop-status (crop-id uint) (new-status (string-ascii 20)))
  (let ((crop (unwrap! (map-get? crops { crop-id: crop-id }) (err u2))))
    (if (is-eq (get farmer crop) tx-sender)
      (ok (map-set crops { crop-id: crop-id } (merge crop { status: new-status })))
      (err u3))))

;; Read-only Functions
(define-read-only (get-crop-info (crop-id uint))
  (map-get? crops { crop-id: crop-id }))

