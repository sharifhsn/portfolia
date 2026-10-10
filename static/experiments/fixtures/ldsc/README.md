# Recorded LDSC results

This fixture contains aggregate results from the native `sharifhsn/ldsc` project.
The website reads `results.json` in Rust at build time.
The website does not execute a genome analysis in the browser.

The snapshot date is October 10, 2026.
The source checkout was `52ce733a3d26cdc2dda53de690bb2ea3b167f9cc`.
Some retained result files are outside Git history.
The JSON records their source paths and SHA-256 hashes.
The hashes identify the exact files that supplied the values.

## Runtime comparison

`benchmark.txt` preserves the March 7, 2026 entry from `docs/perf-log.md`.
The public performance log at commit `413a7c3254fcb5c9283e17c8b8050178231aef22` contains the same benchmark entry.
Python and Rust used a Ryzen 5 5600X with 32 GB RAM.
The input contained 1,664,852 variants and 2,490 reference samples.
The window was 1,000 kb.

Python had one measured run. Each Rust mode had three measured runs.
The Rust error terms are standard deviations.

The display calculates the f64 speedup as `1548.5 / 85.4 = 18.1` after rounding.
It does not combine the Python time with later AWS or Apple measurements.
The recorded zero f64 difference applies to that build and those settings.
The f32 path had a maximum absolute difference of 0.008 LD-score units.

## Reference distribution

The input was `preprint/data/sim_ldscores_sketch/1000g_exact_masked22.l2.ldscore.gz`.
A complete gzip read produced 18,627 LD scores from its `L2` column.
The European reference had 503 samples, a 1,000 kb window, and MAF > 0.05.
This filtered chromosome 22 reference differs from the full-panel runtime input.

The histogram counts scores in intervals of width 10.
Each interval includes the lower bound and excludes the upper bound.
The last interval contains all scores of 100 or more.
The interval counts sum to 18,627.
The JSON also preserves the mean, median, and maximum of the complete input.
No individual genotypes enter this fixture.

## BMI result

`worked-example-bmi.txt` preserves the retained regression output without changes.
The native pipeline used Yengo et al. (2018) GWAS summaries and a 503-sample 1000G European reference.
The GWAS and reference panel are separate inputs.
The regression merged 1,030,015 variants.

Heritability was 0.2032 with standard error 0.0055 on the observed scale.
The percentage display multiplies these values by 100.
The confounding ratio agrees with `(intercept - 1) / (mean_chi2 - 1)` after rounding.

`preprint/main.typ` records step times of 29, 10, and 2 seconds on an Apple M5 Pro.
Those times describe a separate pipeline measurement.
They do not establish a speedup against Python.
The website reports this historical result, not a fresh reproduction.

The 1000G reference supplies LD information.
It does not establish trait heritability without a GWAS input.
This BMI result does not calculate genetic correlation between traits.
