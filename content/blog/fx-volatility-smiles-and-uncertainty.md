+++
title = 'FX Volatility Smiles and Uncertainty'
date = 2025-03-10
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'Volatility', 'Smiles']
+++

## Week 7 — 10 March 2025

The syllabus records “Black-Scholes shortcomings: smile effects.” The source export contains the volatility-surface helper below and explicitly labels it “Vol Surface Functions — Not to be completed by Student.” I am preserving that status rather than presenting it as a finished calibration method.

### Risk-reversal and fly interpolation

~~~vb
' ------------------- ' ------------------- ' ------------------- ' ------------------- ' -------------------
' ------------------- ' ------------------- ' ------------------- ' ------------------- ' -------------------
' ------------------- ' ------------------- ' ------------------- ' ------------------- ' -------------------
' ------------------- Vol Surface Functions - Not to be completed by Student ---------------------
Function RRFlyQuadraticFit(lowStrike As Double, _
                    atmFStrike As Double, _
                    highStrike As Double, _
                    ATMFVol As Double, _
                    RRvol As Double, _
                    FlyVol As Double, _
                    XpointATMF As Double, _
                    XPoint As Double)
    Dim VollowStrike As Double
    Dim VolATF As Double
    Dim VolHighStrike As Double
    Dim lowStrikeRelative As Double
    Dim highStrikeRelative As Double
    Dim XPointRelative As Double
    Dim zero As Double
    'If a crazy strike
    If Abs(XPoint) > atmFStrike * 1000 Or Abs(XPoint) < atmFStrike / 1000 Then
     RRFlyQuadraticFit = 0#
    'If not a crazy strike
    Else
     'Make everything relative to ATMF
     lowStrikeRelative = lowStrike - atmFStrike
     highStrikeRelative = highStrike - atmFStrike
     XPointRelative = XPoint - XpointATMF
     zero = 0#
     ' Low Strike vol
      VollowStrike = ATMFVol - RRvol / 2 + FlyVol
      VolATF = ATMFVol
       VolHighStrike = ATMFVol + RRvol / 2 + FlyVol
        RRFlyQuadraticFit = QuadraticFit(lowStrikeRelative, _
                                         VollowStrike, _
                                         zero, _
                                         VolATF, _
                                         highStrikeRelative, _
                                         VolHighStrike, _
                                         XPointRelative)
    End If
End Function
Function QuadraticFit(X1 As Double, _
                    Y1 As Double, _
                    X2 As Double, _
                    Y2 As Double, _
                    X3 As Double, _
                    Y3 As Double, _
                    XPoint As Double)
    Dim Acoef As Double
    Dim Bcoef As Double
    Dim Ccoef As Double
    Acoef = ((Y2 - Y1) * (X1 - X3) + _
         (Y3 - Y1) * (X2 - X1)) / _
        ((X1 - X3) * (X2 ^ 2 - X1 ^ 2) + _
         (X2 - X1) * (X3 ^ 2 - X1 ^ 2))
    Bcoef = ((Y2 - Y1) - Acoef * (X2 ^ 2 - X1 ^ 2)) _
        / (X2 - X1)
    Ccoef = Y1 - Acoef * X1 ^ 2 - Bcoef * X1
    QuadraticFit = Acoef * XPoint ^ 2 + Bcoef * XPoint + Ccoef
End Function
'------------------- AUXILIARY FUNCTIONS --------------------
~~~

### Auxiliary normal terms

~~~vb
' D1 calculation
Function dOne(S, X, T, r, v)
    dOne = (Log(S / X) + (0.5 * v ^ 2) * T) / (v * (Sqr(T)))
End Function
' N(d1) calculation
Function NdOne(S, X, T, r, v)
    NdOne = Exp(-(dOne(S, X, T, r, v) ^ 2) / 2) / (Sqr(2 * Application.WorksheetFunction.Pi()))
End Function
' D2 calculation
Function dTwo(S, X, T, r, v)
    dTwo = dOne(S, X, T, r, v) - v * Sqr(T)
End Function
 ' N(D2) calculation
Function NdTwo(S, X, T, r, v)
~~~

The source gives an implementation sketch for interpolating a quadratic through low-strike, at-the-money-forward, and high-strike volatilities. It does not include a worked smile calibration or a claim that the helper was completed.
