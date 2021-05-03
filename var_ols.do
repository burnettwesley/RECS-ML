# delimit ;
set more off;

clear all;
use final_vars_$year.dta;
vl set;

/* ........................................................................ */
/* Ryan and Plourde (2009) types of reduced-form models)                    */
/* ........................................................................ */

* Elasticity variables from the RECS dataset;
vl create evar = (lpriceel lpriceng lpricefo lpricelp lpricekr);  

* Continuous variables from the RECS dataset;
vl create cvar = (nhsldmem hhage ltotsqft linc hdd65 cdd65 bedrooms ncombath nhafbath numfrig temphome 
 hhage nhafbath othrooms tempgone tempnite);
 
* Categorical variables from the RECS dataset;
vl substitute ivar = (i.division i.typehuq i.urbrur i.kownrent i.yearmade i.occupyy i.origin1);

* Indicator variables from the RECS dataset;
vl substitute dvar = (poor100 poor150 miss_ng miss_fo miss_lp miss_kr usesolar usewood);