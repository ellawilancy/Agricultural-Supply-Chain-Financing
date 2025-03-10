import { describe, it, expect, vi } from "vitest"

describe("Invoice Tokenization Contract", () => {
  const mockContractCall = vi.fn()
  
  it("should tokenize an invoice", () => {
    mockContractCall.mockReturnValueOnce({ result: { value: 1 } })
    const result = mockContractCall("tokenize-invoice", [1, 1000])
    expect(result.result.value).toBe(1)
  })
  
  it("should transfer a token", () => {
    mockContractCall.mockReturnValueOnce({ result: { value: true } })
    const result = mockContractCall("transfer-token", [1, "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM"])
    expect(result.result.value).toBe(true)
  })
  
  it("should get invoice info", () => {
    const invoiceInfo = {
      issuer: "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM",
      amount: 1000,
      status: "tokenized",
    }
    mockContractCall.mockReturnValueOnce({ result: { value: invoiceInfo } })
    const result = mockContractCall("get-invoice", [1])
    expect(result.result.value).toEqual(invoiceInfo)
  })
  
  it("should get token info", () => {
    const tokenInfo = {
      owner: "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM",
      "invoice-id": 1,
    }
    mockContractCall.mockReturnValueOnce({ result: { value: tokenInfo } })
    const result = mockContractCall("get-token", [1])
    expect(result.result.value).toEqual(tokenInfo)
  })
})

