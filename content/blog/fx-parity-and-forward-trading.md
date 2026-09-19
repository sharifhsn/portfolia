+++
title = 'FX Parity and Forward Trading'
date = 2025-02-10
source = 'FE-635 | Risk Engineering'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Juan'
term = 'Spring 2025'
[taxonomies]
categories = ['FX']
tags = ['FX', 'FX Parity', 'Forward Contracts']
+++

## Week 3 — 10 February 2025

The syllabus records this class as “Stochastic Processes — Intro to FX: FX parity; Spot and Forward trading; FX conventions.” The source document does not contain a prose derivation of covered interest parity, so I am keeping the implementation notes and the topic record rather than filling that gap with a generated explanation.

### Notes on inputs

The workbook notes record the conventions used by the later pricing functions:

- Days-to-time conversion uses a 365-day year.
- (S) is the forward FX rate, not spot FX.
- Contract types are (C) (call), (P) (put), (F) (forward), (D) (deposit in local currency, usually USD), and (M) (deposit in the foreign currency, usually MXN).
- (DiscRate) is the discounting-currency rate; (ExtRate) is the foreign-currency rate.
- Prices are returned in USD. Notionals are entered in MXN except for a USD deposit ((D)).

The quote direction and domestic/foreign labels therefore need to be fixed before comparing a spot, forward, or parity calculation.

### Source boundary

The personal course export contains the syllabus and these workbook conventions, but no worked parity example. This article intentionally marks that source boundary instead of presenting an LLM-generated derivation as class notes.
