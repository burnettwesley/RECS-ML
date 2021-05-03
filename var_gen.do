# delimit ;
set more off;

clear all;
use recs_rates_$year.dta;

* Log price of electricity--trim at 1st and 99th percentile;
gen lpriceel = ln(i_price_el);
sum lpriceel, detail;
keep if inrange(lpriceel, r(p1), r(p99));

* Log price of nat gas--trim at 1st and 99th percentile;
gen lpriceng = ln(i_price_ng); 
gen miss_ng = 1 if lpriceng == .; 
replace miss_ng = 0 if miss_ng == .;
sum lpriceng; local ngp = r(mean);
replace lpriceng = `ngp' if lpriceng == .;
sum lpriceng, detail;
keep if inrange(lpriceng, r(p1), r(p99));

* Log price of heating oil--trim at 1st and 99th percentile;
gen lpricefo = ln(i_price_fo); 
gen miss_fo = 1 if lpricefo == .;
replace miss_fo = 0 if miss_fo ==.;
sum lpricefo; local fop = r(mean);
replace lpricefo = `fop' if lpricefo == .;
sum lpricefo, detail;
keep if inrange(lpricefo, r(p1), r(p99));

* Log price of propane--trim at 1st and 99th percentile;
gen lpricelp = ln(i_price_lp); 
gen miss_lp = 1 if lpricelp ==.;
replace miss_lp = 0 if miss_lp ==.;
sum lpricelp; local lpp = r(mean);
replace lpricelp = `lpp' if lpricelp ==.;
sum lpricelp, detail;
keep if inrange(lpricelp, r(p1), r(p99));

* Log price of kerosene--trim at 1st and 99th percentile;
gen lpricekr = ln(i_price_kr); 
gen miss_kr = 1 if lpricekr == .;
replace miss_kr = 0 if miss_kr ==.;
sum lpricekr; local krp = r(mean);
replace lpricekr = `krp' if lpricekr == .;
sum lpricekr, detail;
keep if inrange(lpricekr, r(p1), r(p99));

* Log total energy consumption--trim at 1st and 99th percentile;
gen ltotalbtu = ln(totalbtu);
sum ltotalbtu, detail;
keep if inrange(ltotalbtu, r(p1), r(p99));

* Log of total square feet of house--trim at 1st and 99th percentile;
gen ltotsqft = ln(totsqft);
sum ltotsqft, detail;
keep if inrange(ltotsqft, r(p1), r(p99));

* Log of total energy consumption per person--trim at 1st and 99th percentile;
gen tbtu_mem = totalbtu/nhsldmem;
gen ltbtumem = ln(tbtu_mem);
sum ltbtumem, detail;
keep if inrange(ltbtumem, r(p1), r(p99));

gen linc = ln(inc);
gen ltotel = ln(btuel);
gen ltotng = ln(btung);

save final_vars_$year.dta, replace;