# PDS-LASSO Impact Evaluation: Youth Employment Program in Uganda

This repository contains selected Stata code from my master's thesis,
*"Short-term effects of a youth employment program in Uganda: A
nonexperimental evaluation using the PDS-LASSO estimator."*

It demonstrates an applied econometric pipeline using PDS-LASSO
(Belloni, Chernozhukov & Hansen, 2014) for data-driven control variable
selection and geographic and graphical output for policy-relevant
presentation of results.

## Example outputs

![Map of treatment and control schools](https://github.com/mrosadio/pdslasso-impact-evaluation/blob/main/output/UG_schools_distributions_alternative.png)

*Geographic distribution of program (treatment) and control schools across
Uganda. It shows by controlling for regional fixed effects, by visualizing
that school location, and therefore access to local labor markets, varies
across treatment and control groups.*

![PDS-LASSO robustness check](https://github.com/mrosadio/pdslasso-impact-evaluation/blob/main/output/figure_robustness_lambda_intermediary_outcomes.png)

*Treatment effect estimates for intermediary outcomes (job search duration,
interviews, confidence) under two PDS-LASSO penalty specifications: the
plugin lambda and a 50% increase, used as a robustness check.*

## Data policy

- No raw or processed data is included in this repository.
- Survey data and school/city coordinates are not published due to
  participant confidentiality.
- Scripts are provided for methodological reference.

## What is included

- `01_estimation_pdslasso.do`: PDS-LASSO estimation of treatment effects
  on intermediary and labor market outcomes, across three treatment
  definitions, two samples, and three fixed-effects specifications.
- `02_map.do`: Map of treatment and control school locations across
  Uganda's regions.
- `03_coefplot_robustness.do`: Coefficient plots comparing PDS-LASSO
  estimates under the plugin lambda vs. a 50% increase (robustness check).
- `outputs/`: Example figures referenced above.

## Method note

PDS-LASSO selects control variables separately for the outcome and
treatment equations from a large set of candidate baseline characteristics
(individual, household, and school-level), then estimates the treatment
effect using the union of selected controls ("post" estimation). This
avoids manual specification search while controlling for a rich set of
observable characteristics. The robustness check re-estimates all models
with the LASSO penalty parameter increased by 50%, to assess sensitivity
of the results to this choice.

## Requirements

- Stata 16.1 or later