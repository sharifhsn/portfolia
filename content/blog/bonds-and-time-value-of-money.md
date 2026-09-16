+++
title = 'Bonds and the Time Value of Money'
date = 2024-10-10
source = 'FE-535 | Risk Management'
source_date_basis = "Meeting date verified against the personal Academics calendar."
instructor = 'Majeed Simaan'
term = 'Fall 2024'
[taxonomies]
categories = ['Risk Management']
tags = ['Risk Management', 'Bonds', 'Time Value of Money']
+++
The bond material in the FE-535 notes treats a fixed-coupon bond as a stream of future cash flows. Discounting those cash flows gives its present value, and the yield is the constant rate that makes the present value equal to the quoted price.

The notes distinguish clean price from dirty price. Accrued interest belongs in the cash price even though market quotations commonly show the clean price:

$$\text{Dirty Price}=\text{Clean Price}+\text{Accrued Interest}.$$

This decomposition is operationally important for a risk report. Two prices can differ simply because one includes the coupon accrued since the last payment. Day-count convention and payment frequency must be stated before comparing yields.
