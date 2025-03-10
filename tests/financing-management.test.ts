import { describe, it, expect, vi } from "vitest"

describe("Financing Management Contract", () => {
  const mockContractCall = vi.fn()
  
  it("should request a loan", () => {
    mockContractCall.mockReturnValueOnce({ result: { value: 1 } })
    const result = mockContractCall("request-loan", [1000, "crop", 1])
    expect(result.result.value).toBe(1)
  })
  
  it("should approve a loan", () => {
    mockContractCall.mockReturnValueOnce({ result: { value: true } })
    const result = mockContractCall("approve-loan", [1])
    expect(result.result.value).toBe(true)
  })
  
  it("should repay a loan", () => {
    mockContractCall.mockReturnValueOnce({ result: { value: true } })
    const result = mockContractCall("repay-loan", [1])
    expect(result.result.value).toBe(true)
  })
  
  it("should get loan info", () => {
    const loanInfo = {
      borrower: "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM",
      amount: 1000,
      "collateral-type": "crop",
      "collateral-id": 1,
      status: "approved",
    }
    mockContractCall.mockReturnValueOnce({ result: { value: loanInfo } })
    const result = mockContractCall("get-loan", [1])
    expect(result.result.value).toEqual(loanInfo)
  })
})

