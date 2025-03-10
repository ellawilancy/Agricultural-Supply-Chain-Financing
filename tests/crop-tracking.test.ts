import { describe, it, expect, vi } from "vitest"

describe("Crop Tracking Contract", () => {
  const mockContractCall = vi.fn()
  
  it("should register a new crop", () => {
    mockContractCall.mockReturnValueOnce({ result: { value: true } })
    const result = mockContractCall("register-crop", [1, "wheat", 1625097600])
    expect(result.result.value).toBe(true)
  })
  
  it("should update crop status", () => {
    mockContractCall.mockReturnValueOnce({ result: { value: true } })
    const result = mockContractCall("update-crop-status", [1, "harvested"])
    expect(result.result.value).toBe(true)
  })
  
  it("should get crop info", () => {
    const cropInfo = {
      farmer: "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM",
      "crop-type": "wheat",
      "planting-date": 1625097600,
      status: "harvested",
    }
    mockContractCall.mockReturnValueOnce({ result: { value: cropInfo } })
    const result = mockContractCall("get-crop-info", [1])
    expect(result.result.value).toEqual(cropInfo)
  })
})

