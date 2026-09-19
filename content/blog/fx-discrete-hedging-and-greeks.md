+++
title = 'FX Discrete Hedging and Greeks'
date = 2025-03-03
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'Greeks', 'Discrete Hedging']
+++

## Week 6 — 3 March 2025

The syllabus labels this class “Black-Scholes shortcomings: discrete hedging; volatility uncertainty.” The source workbook expresses the risk measures as functions. It does not contain a separate prose lecture summary, so the functions are kept here as the primary note.

### Delta, theta, gamma, vega, and rho

The functions below are transcribed from the workbook. BSDailyTheta uses a one-day change; BSVega uses a 0.01 volatility bump; the two rho functions use a one-basis-point domestic or foreign-rate bump.

~~~vb
' Calculate the FX Delta of the option
Function BSDelta(ContractType As String, _
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
    If OptionType = "F" Or OptionType = "M" Then
        OptionDelta = Exp(-ExtRate * T)
    ElseIf OptionType = "D" Then
        OptionDelta = 0
     ElseIf OptionType = "C" Then
        OptionDelta = Exp(-ExtRate * T) * Application.NormSDist(dOne(S, X, T, r, v))
    ElseIf OptionType = "P" Then
        OptionDelta = Exp(-ExtRate * T) * (Application.NormSDist(dOne(S, X, T, r, v)) - 1)
    End If
     BSDelta = OptionDelta
End Function
Function BSDailyTheta(ContractType As String, _
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
    rFor = ExtRate
    v = vol
    OptionType = ContractType
    ' Making Sure Strike is OK for MXN Deposit
    If OptionType = "M" Then
        X = 0.0000000001
    End If
    If OptionType = "F" Or OptionType = "M" Then
        Theta = BSPrice(ContractType, Forward * Exp(-(rFor - r) * (-1) / 365), Strike, Days - 1, DiscRate, ExtRate, vol)
        Theta2 = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
        Theta = Theta - Theta2
    ElseIf OptionType = "D" Then
        Theta = r * Exp(-r * T) * 1 / 365
    ElseIf OptionType = "C" Then
        Theta = BSPrice(ContractType, Forward * Exp(-(rFor - r) * (-1) / 365), Strike, Days - 1, DiscRate, ExtRate, vol)
        Theta2 = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
        Theta = Theta - Theta2
    ElseIf OptionType = "P" Then
        Theta = BSPrice(ContractType, Forward * Exp(-(rFor - r) * (-1) / 365), Strike, Days - 1, DiscRate, ExtRate, vol)
        Theta2 = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
        Theta = Theta - Theta2
    End If
  BSDailyTheta = Theta
End Function
' Calculate the Gamma of the contract
Function BSGamma(ContractType As String, _
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
    If OptionType = "D" Or OptionType = "M" Then
         Gamma = 0
    ElseIf OptionType = "F" Then
    Gamma = 0
    ElseIf OptionType = "C" Then
        Gamma = Exp(-(2 * ExtRate - DiscRate) * T) * NdOne(S, X, T, r, v) / (S * (v * Sqr(T)))
    ElseIf OptionType = "P" Then
        Gamma = Exp(-(2 * ExtRate - DiscRate) * T) * NdOne(S, X, T, r, v) / (S * (v * Sqr(T)))
    End If
  BSGamma = Gamma
End Function
' Function to calculate the Vega
Function BSVega(ContractType As String, _
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
    If OptionType = "F" Or OptionType = "D" Or OptionType = "M" Then
         Vega = 0
    ElseIf OptionType = "C" Then
        VegaBase = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
        VegaBump = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol + 0.01)
        Vega = VegaBump - VegaBase
    ElseIf OptionType = "P" Then
        Vega = 0
        VegaBase = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
        VegaBump = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol + 0.01)
        Vega = VegaBump - VegaBase
    End If
  BSVega = Vega
End Function
'Function that calculates the sensitivity to 1bps bump on Domestic interest rates (usually USD rates)
Function BSDailyRhoUSD(ContractType As String, _
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
    rFor = ExtRate
    v = vol
    OptionType = ContractType
    ' Making Sure Strike is OK for MXN Deposit
    If OptionType = "M" Then
        X = 0.0000000001
    End If
    If OptionType = "F" Or OptionType = "M" Then
       Rho = BSPrice(ContractType, Forward * Exp(0.0001 * T), Strike, Days, DiscRate + 0.0001, ExtRate, vol)
       Rho2 = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
       Rho = Rho - Rho2
    ElseIf OptionType = "D" Then
       Rho = -T * Exp(-r * T) * 0.0001
    ElseIf OptionType = "C" Then
       Rho = BSPrice(ContractType, Forward * Exp(0.0001 * T), Strike, Days, DiscRate + 0.0001, ExtRate, vol)
       Rho2 = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
       Rho = Rho - Rho2
    ElseIf OptionType = "P" Then
       Rho = BSPrice(ContractType, Forward * Exp(0.0001 * T), Strike, Days, DiscRate + 0.0001, ExtRate, vol)
       Rho2 = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
       Rho = Rho - Rho2
'----------------------------------------------
    End If
  BSDailyRhoUSD = Rho
End Function
'Function that calculates the sensitivity to 1bps bump on External interest rates (usually MXN rates)
Function BSDailyRhoExt(ContractType As String, _
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
    rFor = ExtRate
    v = vol
    OptionType = ContractType
    ' Making Sure Strike is OK for MXN Deposit
    If OptionType = "M" Then
        X = 0.0000000001
    End If
    If OptionType = "F" Or OptionType = "M" Then
       Rho = BSPrice(ContractType, Forward * Exp(-0.0001 * T), Strike, Days, DiscRate, ExtRate, vol)
       Rho2 = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
       Rho = Rho - Rho2
    ElseIf OptionType = "D" Then
       Rho = BSPrice(ContractType, Forward * Exp(-0.0001 * T), Strike, Days, DiscRate, ExtRate, vol)
       Rho2 = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
       Rho = Rho - Rho2
    ElseIf OptionType = "C" Then
       Rho = BSPrice(ContractType, Forward * Exp(-0.0001 * T), Strike, Days, DiscRate, ExtRate, vol)
       Rho2 = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
       Rho = Rho - Rho2
    ElseIf OptionType = "P" Then
       Rho = BSPrice(ContractType, Forward * Exp(-0.0001 * T), Strike, Days, DiscRate, ExtRate, vol)
       Rho2 = BSPrice(ContractType, Forward, Strike, Days, DiscRate, ExtRate, vol)
       Rho = Rho - Rho2
    End If
  BSDailyRhoExt = Rho
End Function
~~~

The implementation makes the discrete-hedging convention concrete: the “Greek” is a finite bump around the workbook's forward, strike, rates, volatility, and 365-day maturity convention.
