# delimit ;
set more off;

clear all;
*set maxvar 20000;
global year = "2009";

cd "M:\CEB\WBurnett\RECS and Stat Learn\Stata code\\$year files";

capture log close;
log using ml_recs_$year.txt, replace text;

/* This do file creates the file final_vars_$year */
run var_gen.do;

/* Load data */
use final_vars_$year.dta;

run var_ols.do;


/*.......................................................*/
/* Standard Ryan and Plourde (2009) type of regression   */
/* ......................................................*/


reg ltotalbtu $evar $cvar $ivar $dvar, robust;

reg dollarel i.nhsldmem totsqft, robust;

margins, dydx(nhsldmem);
contrast a.nhsldmem, effects;
contrast g.nhsldmem, effects;

reg dollarng i.nhsldmem totsqft, robust;

margins, dydx(nhsldmem);
contrast a.nhsldmem, effects;
contrast g.nhsldmem, effects;

reg dollarfo i.nhsldmem totsqft, robust;

margins, dydx(nhsldmem);
contrast a.nhsldmem, effects;
contrast g.nhsldmem, effects;

reg dollarlp i.nhsldmem totsqft, robust;

margins, dydx(nhsldmem);
contrast a.nhsldmem, effects;
contrast g.nhsldmem, effects;

dsregress ltotalbtu $evar, controls($cvar $ivar $dvar) sel(plug) nolog;

dsregress ltotalbtu $evar, controls($cvar $ivar $dvar) sel(cv) nolog;

dsregress ltotalbtu $evar, controls($cvar $ivar $dvar) sel(adapt) nolog;


* Test the predictive abilities of the various models;

splitsample, generate(sample) split(0.75 0.25) rseed(12345);
label define slabel 1 "Training" 2 "Validation";
label values sample slabel;
tabulate sample;

quietly reg ltotalbtu $evar $cvar $ivvar $dvar if sample == 1;
estimates store pars_ols;

lasso linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, nolog rseed(12345);
estimates store pars_cv;

lasso linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, nolog sel(adapt) rseed(12345);
estimates store pars_adapt;

lasso linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, nolog sele(plug) rseed(12345);
estimates store pars_plug;

elasticnet linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, alpha(0.25 0.5 0.75) nolog rseed(12345);
estimates store pars_enet;

lassogof pars_ols pars_plug pars_cv pars_adapt pars_enet if sample == 2;
lassogof pars_ols pars_plug pars_cv pars_adapt pars_enet if sample == 2, postselection;


/* .......................................................*/
/* LASSO Method w/ all variables                          */
/* .......................................................*/


run var_lasso_all.do;

reg ltotalbtu $evar $cvar $ivar $dvar, robust;

dsregress ltotalbtu $evar, controls($cvar $ivar $dvar) sel(plug) nolog;

dsregress ltotalbtu $evar, controls($cvar $ivar $dvar) sel(cv) nolog;

dsregress ltotalbtu $evar, controls($cvar $ivar $dvar) sel(adapt) nolog;

* Test the predictive abilities of the various models;

splitsample, generate(sample) split(0.75 0.25) rseed(12345);
label define slabel 1 "Training" 2 "Validation";
label values sample slabel;
tabulate sample;

quietly reg ltotalbtu $evar $cvar $ivvar $dvar if sample == 1;
estimates store all_ols;

lasso linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, nolog rseed(12345);
estimates store all_cv;

lasso linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, nolog sel(adapt) rseed(12345);
estimates store all_adapt;

lasso linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, nolog sele(plug) rseed(12345);
estimates store all_plug;

elasticnet linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, alpha(0.25 0.5 0.75) nolog rseed(12345);
estimates store all_enet;

lassogof all_ols all_plug all_cv all_adapt all_enet if sample == 2;
lassogof all_ols all_plug all_cv all_adapt all_enet if sample == 2, postselection;


/* .............................................*/
/* LASSO Method w/ all of the common variables  */
/* .............................................*/


run var_lasso_common.do;

reg ltotalbtu $evar $cvar $ivar $dvar, robust;

dsregress ltotalbtu $cevar, controls($ccvar $civar $cdvar) sel(plug) nolog;

dsregress ltotalbtu $evar, controls($cvar $ivar $dvar) sel(cv) nolog;

dsregress ltotalbtu $evar, controls($cvar $ivar $dvar) sel(adapt) nolog;

* Test the predictive abilities of the various models;

splitsample, generate(sample) split(0.75 0.25) rseed(12345);
label define slabel 1 "Training" 2 "Validation";
label values sample slabel;
tabulate sample;

quietly reg ltotalbtu $evar $cvar $ivvar $dvar if sample == 1;
estimates store common_ols;

lasso linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, nolog rseed(12345);
estimates store common_cv;

lasso linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, nolog sel(adapt) rseed(12345);
estimates store common_adapt;

lasso linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, nolog sele(plug) rseed(12345);
estimates store common_plug;

elasticnet linear ltotalbtu $evar $cvar $ivar $dvar if sample == 1, alpha(0.25 0.5 0.75) nolog rseed(12345);
estimates store common_enet;

lassogof common_ols common_plug common_cv common_adapt common_enet if sample == 2;
lassogof common_ols common_plug common_cv common_adapt common_enet if sample == 2, postselection;

log close;
