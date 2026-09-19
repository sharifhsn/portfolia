+++
title = 'Black–Scholes Pricing for FX'
date = 2025-02-24
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'Black–Scholes', 'Option Pricing']
+++

## Week 5 — 24 February 2025

The syllabus calls this class “Introduction to Black-Scholes. BS usage for a practitioner. First and Second order risks. Xgamma. Intuitive awareness.” The source notes are the VBA workbook below, so the article preserves the implementation rather than replacing it with a summary.

### Notes on inputs

- (T = Days / 365)
- (S = Forward) (the workbook expects forward FX)
- (X = Strike)
- (r = DiscRate)
- (v = vol)
- (ExtRate) is the foreign-currency rate.
- All returned prices are in USD.

### BSPrice

This is a cleaned transcription of the source workbook function. The branches cover calls, puts, forwards, and the two zero-coupon deposits recorded in the notes.

~~~vb
Function BSPrice(ContractType As String, _
                 Forward As Double, _
                 Strike As Double, _
                 Days As Double, _
                 DiscRate As Double, _
                 ExtRate As Double, _
                 vol As Double)
    T = Days / 365
    S = Forward
    X = Strike
    r = DiscRate
    v = vol
    OptionType = ContractType
    ' Call Option
    If OptionType = "C" Then
        BSPrice = Exp(-r * T) * (S * Application.NormSDist(dOne(S, X, T, r, v)) - X * Application.NormSDist(dTwo(S, X, T, r, v)))
    ' Put Option
    ElseIf OptionType = "P" Then
        BSPrice = Exp(-r * T) * (X * Application.NormSDist(-dTwo(S, X, T, r, v)) - S * Application.NormSDist(-dOne(S, X, T, r, v)))
    ' Fwd FX
    ElseIf OptionType = "F" Then
        BSPrice = Exp(-r * T) * (S - X)
    ' Deposit in USD (ZC in USD)
    ElseIf OptionType = "D" Then
        BSPrice = Exp(-r * T)
    ' Deposit in MXN (ZCB in MXN)
    ElseIf OptionType = "M" Then
        BSPrice = Exp(-r * T) * S
    End If
End Function
~~~
