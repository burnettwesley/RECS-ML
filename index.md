## The Demand for Household-Level Energy Services: Estimating Price Elasticities Using Statistical Learning

**Abstract:** This paper presents a novel approach to estimate short-run price elasticities and economies of scale for household energy demand, while controlling for a high-dimensional dataset of housing, socio-economic, and behavioral characteristics. We explore household energy consumption in the context of recent national- and state-level trends in residential energy prices and changes to energy efficiency policies. To estimate elasticities across time, we use various years of data from the U.S. Energy Information Administration's ongoing Residential Energy Consumption Survey. Given the broad set of data offered by this survey, we use a statistical learning approach to analyze the most salient determinants of energy consumption and compare that approach to linear regression methods. The statistical learning estimator provides superior out-of-sample predictions of energy price elasticities relative to a reduced-form, linear regression approach. Moreover, we find increasing economies of scale in electricity but not natural gas expenditures. Finally, we discuss how statistical learning can be used for energy policy.

This repository includes the most recent working paper version, data, and Stata (version 16) code for Burnett & Kiesling research using the EIA RECS data. The .do files contain the code and .dta files contain the data to replicate the results. We did separate regression analyses for each survey year of RECS, so the files are labeled according to the survey year. For example, the 2009 survey contains the data file entitled "recs_rates_2009.dta." The main do file to recreate the estimates is entitled "stat_learn_recs.do."

- [Working paper](https://github.com/lkkinetic/RECS-LASSO/blob/main/KB__RECS_and_Machine_Learning.pdf), 3 May 2021
- [Data: RECS 2001](https://github.com/lkkinetic/RECS-LASSO/blob/main/recs_rates_2001.dta), 3 May 2021
- [Data: RECS 2005](https://github.com/lkkinetic/RECS-LASSO/blob/main/recs_rates_2005.dta), 3 May 2021
- [Data: RECS 2009](https://github.com/lkkinetic/RECS-LASSO/blob/main/recs_rates_2009.dta), 3 May 2021
- [Data: RECS 2015](https://github.com/lkkinetic/RECS-LASSO/blob/main/recs_rates_2015.dta), 3 May 2021
- [Stata .do file: Generate variables and descriptive statistics](https://github.com/lkkinetic/RECS-LASSO/blob/main/var_gen.do), 3 May 2021
- [Stata .do file: OLS](https://github.com/lkkinetic/RECS-LASSO/blob/main/var_ols.do), 3 May 2021
- [Stata .do file: LASSO](https://github.com/lkkinetic/RECS-LASSO/blob/main/stat_learn_recs.do), 3 May 2021


