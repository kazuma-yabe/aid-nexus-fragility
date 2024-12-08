*****************************************************************************************************
******************************************** SoF data ***********************************************
********************************** (State of Fragility; MODEL1) ************************************
*****************************************************************************************************


*********Humanitarian ODA / SoF data
clear all
set more off
cd "~/Desktop/aid_nexus_fragility"
use "data/merged/HMT_SoF_merged.dta"

*generating log variables
generate hmtlog=log(crs_hmt)
generate gdplog=log(gdp)
generate co2log=log(co2)
generate exportlog=log(export)
generate distcaplog=log(distcap)
generate poplog=log(population)
generate soflog=log(sof)
generate freedomlog=log(freedom)

*generating a square variable
gen gdplog2=gdplog^2

*dropping repeated time values
drop if year==year[_n-1]

*declaring it as a panel dataset and defining a time variable
xtset panelid2 year, yearly

*generate lag variables
gen gdplog_lag=l1.gdplog
gen sof_lag=l1.sof
 
*random effect tobit
cd "output"

*v1
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(SoF_HMT_DAC) nest replace

*v2
encode iso3c_d, gen(donor)
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(SoF_HMT_DAC_v2) nest replace

* NO CO2
xttobit hmtlog i.sof_lag L.exportlog distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)

	* REVIEW 2
	xttobit hmtlog i.sof_lag i.year, ll(0)
	xttobit hmtlog i.sof_lag i.year i.donor, ll(0)
	xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0)
	xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0)
	
	gen sof_exp = exportlog * sof
	gen sof_co2 = co2log * sof
	gen sof_dist = distcaplog * sof 
	gen sof_col = colony * sof 
	gen sof_gdp = gdplog * sof
	gen sof_gdp2 = gdplog2 * sof
	gen sof_pop = poplog * sof 
	gen sof_freed = freedom * sof 
	gen sof_agree = agree * sof

	xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed i.year, ll(0)
	*xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed L.sof_agree i.year i.donor, ll(0)

*by country
*1
set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0) tobit cnames(AUS) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_AABCDF) nest replace

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "AUT", ll(0) tobit cnames(AUT) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_AABCDF) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "BEL", ll(0) tobit cnames(BEL) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_AABCDF) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "CAN", ll(0) tobit cnames(CAN) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_AABCDF) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "DNK", ll(0) tobit cnames(DNK) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_AABCDF) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "FIN", ll(0) tobit cnames(FIN) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_AABCDF) nest 

*2
set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "FRA", ll(0) tobit cnames(FRA) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_FDIIJ) nest replace

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "DEU", ll(0) tobit cnames(DEU) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_FDIIJ) nest 

set more off
*asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0) tobit cnames(GRC) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_FDIIJ) nest (too few observations available to run the regression) 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "IRL", ll(0) tobit cnames(IRL) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_FDIIJ) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "ITA", ll(0) tobit cnames(ITA) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_FDIIJ) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "JPN", ll(0) tobit cnames(JPN) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_FDIIJ) nest 

*3
set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "KOR", ll(0) tobit cnames(KOR) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_KLNNN) nest replace

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "LUX", ll(0) tobit cnames(LUX) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_KLNNN) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "NLD", ll(0) tobit cnames(NLD) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_KLNNN) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "NZL", ll(0) tobit cnames(NZL) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_KLNNN) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "NOR", ll(0) tobit cnames(NOR) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_KLNNN) nest 

set more off
*asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0) tobit cnames(PRT) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_KLNNN) nest (too few observations available to run the regression) 

*4
set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "ESP", ll(0) tobit cnames(ESP) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_ESCGU) nest replace

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "SWE", ll(0) tobit cnames(SWE) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_ESCGU) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "CHE", ll(0) tobit cnames(CHE) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_ESCGU) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "GBR", ll(0) tobit cnames(GBR) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_ESCGU) nest 

set more off
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "USA", ll(0) tobit cnames(USA) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_HMT_ESCGU) nest 

***********Development ODA / SoF data
clear all
set more off
cd "~/Desktop/aid_nexus_fragility"
use "data/merged/DEV_SoF_merged.dta"

*generating log variables
generate devlog=log(crs_dev)
generate gdplog=log(gdp)
generate co2log=log(co2)
generate exportlog=log(export)
generate distcaplog=log(distcap)
generate poplog=log(population)
generate freedomlog=log(freedom)

*generating a square variable
gen gdplog2=gdplog^2

*dropping repeated time values
drop if year==year[_n-1]

*declaring it as a panel dataset and defining a time variable
xtset panelid2 year, yearly

*generate lag variables
gen gdplog_lag=l1.gdplog
gen sof_lag=l1.sof

*random effect tobit 

*v1
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(SoF_DEV_DAC) nest replace

*v2
encode iso3c_d, gen(donor)
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year i.donor, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(SoF_DEV_DAC_v2) nest replace

* NO CO2
xttobit devlog i.sof_lag L.exportlog distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)

	* REVIEW 2
	xttobit devlog i.sof_lag i.year, ll(0)
	xttobit devlog i.sof_lag i.year i.donor, ll(0)
	xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0)
	xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0)
	
	gen sof_exp = exportlog * sof
	gen sof_co2 = co2log * sof
	gen sof_dist = distcaplog * sof 
	gen sof_col = colony * sof 
	gen sof_gdp = gdplog * sof
	gen sof_gdp2 = gdplog2 * sof
	gen sof_pop = poplog * sof 
	gen sof_freed = freedom * sof 
	gen sof_agree = agree * sof

	xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed i.year, ll(0)
	*xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed L.sof_agree i.year i.donor, ll(0)
	
	
*by country
*1
set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "AUS", ll(0) tobit cnames(AUS) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_AABCDF) nest replace

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "AUT", ll(0) tobit cnames(AUT) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_AABCDF) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "BEL", ll(0) tobit cnames(BEL) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_AABCDF) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "CAN", ll(0) tobit cnames(CAN) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_AABCDF) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "DNK", ll(0) tobit cnames(DNK) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_AABCDF) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "FIN", ll(0) tobit cnames(FIN) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_AABCDF) nest 

*2
set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "FRA", ll(0) tobit cnames(FRA) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_FDGIIJ) nest replace

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "DEU", ll(0) tobit cnames(DEU) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_FDGIIJ) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "GRC", ll(0) tobit cnames(GRC) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_FDGIIJ) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "IRL", ll(0) tobit cnames(IRL) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_FDGIIJ) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "ITA", ll(0) tobit cnames(ITA) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_FDGIIJ) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "JPN", ll(0) tobit cnames(JPN) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_FDGIIJ) nest 

*3
set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "KOR", ll(0) tobit cnames(KOR) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_KLNNNP) nest replace

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "LUX", ll(0) tobit cnames(LUX) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_KLNNNP) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "NLD", ll(0) tobit cnames(NLD) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_KLNNNP) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "NZL", ll(0) tobit cnames(NZL) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_KLNNNP) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "NOR", ll(0) tobit cnames(NOR) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_KLNNNP) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "PRT", ll(0) tobit cnames(PRT) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_KLNNNP) nest  

*4
set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "ESP", ll(0) tobit cnames(ESP) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_ESCGU) nest replace

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "SWE", ll(0) tobit cnames(SWE) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_ESCGU) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "CHE", ll(0) tobit cnames(CHE) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_ESCGU) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "GBR", ll(0) tobit cnames(GBR) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_ESCGU) nest 

set more off
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "USA", ll(0) tobit cnames(USA) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_DEV_ESCGU) nest 

***********Peace ODA data

clear all
set more off
cd "~/Desktop/aid_nexus_fragility"
use "data/merged/PEC_SoF_merged.dta"

*generating log variables
generate peclog=log(crs_pec)
generate gdplog=log(gdp)
generate co2log=log(co2)
generate exportlog=log(export)
generate distcaplog=log(distcap)
generate poplog=log(population)
generate soflog=log(sof)
generate freedomlog=log(freedom)

*generating a square variable
gen gdplog2=gdplog^2

*dropping repeated time values
drop if year==year[_n-1]

*declaring it as a panel dataset and defining a time variable
xtset panelid2 year, yearly

*generate lag variables
gen gdplog_lag=l1.gdplog
gen sof_lag=l1.sof

*random effect tobit 

*v1
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(SoF_PEC_DAC) nest replace

*v2
encode iso3c_d, gen(donor)
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year i.donor, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(SoF_PEC_DAC_v2) nest replace

* NO CO2
xttobit peclog i.sof_lag L.exportlog distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)

	* REVIEW 2
	xttobit peclog i.sof_lag i.year, ll(0)
	xttobit peclog i.sof_lag i.year i.donor, ll(0)
	xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0)
	xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0)	
	
	gen sof_exp = exportlog * sof
	gen sof_co2 = co2log * sof
	gen sof_dist = distcaplog * sof 
	gen sof_col = colony * sof 
	gen sof_gdp = gdplog * sof
	gen sof_gdp2 = gdplog2 * sof
	gen sof_pop = poplog * sof 
	gen sof_freed = freedom * sof 
	gen sof_agree = agree * sof

	xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed i.year, ll(0)
	*xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed L.sof_agree i.year i.donor, ll(0)

	
*by country
*1
set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "AUS", ll(0) tobit cnames(AUS) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_AABCDF) nest replace

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "AUT", ll(0) tobit cnames(AUT) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_AABCDF) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "BEL", ll(0) tobit cnames(BEL) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_AABCDF) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "CAN", ll(0) tobit cnames(CAN) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_AABCDF) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "DNK", ll(0) tobit cnames(DNK) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_AABCDF) nest 
 
set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "FIN", ll(0) tobit cnames(FIN) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_AABCDF) nest 

*2
set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "FRA", ll(0) tobit cnames(FRA) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_FDIIJ) nest replace

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "DEU", ll(0) tobit cnames(DEU) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_FDIIJ) nest 

set more off
*asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom  i.year if iso3c_d == "GRC", ll(0) tobit cnames(GRC) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_FDIIJ) nest (too few observations available to run the regression) 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "IRL", ll(0) tobit cnames(IRL) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_FDIIJ) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "ITA", ll(0) tobit cnames(ITA) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_FDIIJ) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "JPN", ll(0) tobit cnames(JPN) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_FDIIJ) nest 

*3
set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "KOR", ll(0) tobit cnames(KOR) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_KLNNNP) nest replace

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "LUX", ll(0) tobit cnames(LUX) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_KLNNNP) nest  

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "NLD", ll(0) tobit cnames(NLD) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_KLNNNP) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "NZL", ll(0) tobit cnames(NZL) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_KLNNNP) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "NOR", ll(0) tobit cnames(NOR) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_KLNNNP) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "PRT", ll(0) tobit cnames(PRT) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_KLNNNP) nest 

*4
set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "ESP", ll(0) tobit cnames(ESP) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_ESCGU) nest replace

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "SWE", ll(0) tobit cnames(SWE) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_ESCGU) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "CHE", ll(0) tobit cnames(CHE) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_ESCGU) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "GBR", ll(0) tobit cnames(GBR) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_ESCGU) nest 

set more off
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree  i.year if iso3c_d == "USA", ll(0) tobit cnames(USA) drop(0b.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(SoF_PEC_ESCGU) nest 


*****************************************************************************************************
******************************************** FSI data ***********************************************
********************************** (Degree of fragility; MODEL2) ************************************
*****************************************************************************************************


*************** Humanitarian ODA / FSI data ***************
clear all
set more off
cd "~/Desktop/aid_nexus_fragility"
use "data/merged/HMT_FSI_merged.dta"

*generating log variables
generate hmtlog=log(crs_hmt)
generate gdplog=log(gdp)
generate co2log=log(co2)
generate exportlog=log(export)
generate distcaplog=log(distcap)
generate poplog=log(population)
generate fsilog=log(fsi)
generate freedomlog=log(freedom)

*generating a square variable
gen gdplog2=gdplog^2

*dropping repeated time values
drop if year==year[_n-1]

*declaring it as a panel dataset and defining a time variable
xtset panelid2 year, yearly

*generate lag variables
gen gdplog_lag=l1.gdplog
 

*random effect tobit 
cd "output"
	
*original, v1
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(FSI_HMT_DAC) nest replace

*with donor, v2
encode iso3c_d, gen(donor)
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(FSI_HMT_DAC_v2) nest replace

*no CO2
xttobit hmtlog L.fsi L.exportlog distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)

* REVIEW 2
xttobit hmtlog L.fsi i.year, ll(0)
xttobit hmtlog L.fsi i.year i.donor, ll(0)
xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0)
xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0)

	* with the reduced-FSI data
		replace countryname2 = "Congo-Brazzaville" if countryname2 == "Congo - Brazzaville"
		replace countryname2 = "Democratic Republic of Congo" if countryname2 == "Congo - Kinshasa"
		replace countryname2 = "Sao Tome & Principe" if countryname2 == "SÃ£o TomÃ© & PrÃ­ncipe"
		replace countryname2 = "Burma (Myanmar)" if countryname2 == "Myanmar (Burma)"
		
		*merge with iso3c_r
		sort iso3c_r year
		merge m:1 iso3c_r year using "~/Desktop/aid_nexus_fragility/data/FSI_reduced/fsi_reduced_all.dta"
		list countryname1 countryname2 if _merge == 2
			* it seems the missing countries are correct, because those are the ones that we don't have (or which we have only partially) on the recipients' side
		drop if _merge == 2
		drop _merge
		
		sort panelid2 year
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		*xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0)
		*xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0)
		
		
*by country
*1
set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "AUS", ll(0) tobit cnames(AUS) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_AABCDF) nest replace

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "AUT", ll(0) tobit cnames(AUT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_AABCDF) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "BEL", ll(0) tobit cnames(BEL) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_AABCDF) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "CAN", ll(0) tobit cnames(CAN) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_AABCDF) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "DNK", ll(0) tobit cnames(DNK) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_AABCDF) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "FIN", ll(0) tobit cnames(FIN) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_AABCDF) nest 

*2
set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "FRA", ll(0) tobit cnames(FRA) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_FDIIJ) nest replace

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "DEU", ll(0) tobit cnames(DEU) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_FDIIJ) nest 

set more off
*asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0) tobit cnames(GRC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_FDIIJ) nest (too few observations available to run the regression) 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "IRL", ll(0) tobit cnames(IRL) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_FDIIJ) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "ITA", ll(0) tobit cnames(ITA) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_FDIIJ) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "JPN", ll(0) tobit cnames(JPN) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_FDIIJ) nest 

*3
set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "KOR", ll(0) tobit cnames(KOR) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_KLNNN) nest replace

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "LUX", ll(0) tobit cnames(LUX) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_KLNNN)) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "NLD", ll(0) tobit cnames(NLD) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_KLNNN)) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "NZL", ll(0) tobit cnames(NZL) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_KLNNN)) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "NOR", ll(0) tobit cnames(NOR) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_KLNNN)) nest 

set more off
*asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0) tobit cnames(PRT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(h3) nest (too few observations available to run the regression) 

*4
set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "ESP", ll(0) tobit cnames(ESP) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_ESCGU)) nest replace

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "SWE", ll(0) tobit cnames(SWE) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_ESCGU) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "CHE", ll(0) tobit cnames(CHE) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_ESCGU) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "GBR", ll(0) tobit cnames(GBR) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_ESCGU) nest 

set more off
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "USA", ll(0) tobit cnames(USA) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_HMT_ESCGU) nest 

*************** Development ODA / FSI data ***************
clear all
set more off
cd "~/Desktop/aid_nexus_fragility"
use "data/merged/DEV_FSI_merged.dta"

*generating log variables
generate devlog=log(crs_dev)
generate gdplog=log(gdp)
generate co2log=log(co2)
generate exportlog=log(export)
generate distcaplog=log(distcap)
generate poplog=log(population)
generate fsilog=log(fsi)
generate freedomlog=log(freedom)

*generating a square variable
gen gdplog2=gdplog^2

*dropping repeated time values
drop if year==year[_n-1]

*declaring it as a panel dataset and defining a time variable
xtset panelid2 year, yearly

*generate lag variables
gen gdplog_lag=l1.gdplog

cd "output"

*v1
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(FSI_DEV_DAC) nest replace

*v2
encode iso3c_d, gen(donor)
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(FSI_DEV_DAC_v2) nest replace

* NO CO2
xttobit devlog L.fsi L.exportlog distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
	
	* REVIEW 2
	xttobit devlog L.fsi i.year, ll(0)
	xttobit devlog L.fsi i.year i.donor, ll(0)
	xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0)
	xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0)
	
	* with the reduced-FSI data
		replace countryname2 = "Congo-Brazzaville" if countryname2 == "Congo - Brazzaville"
		replace countryname2 = "Democratic Republic of Congo" if countryname2 == "Congo - Kinshasa"
		replace countryname2 = "Sao Tome & Principe" if countryname2 == "SÃ£o TomÃ© & PrÃ­ncipe"
		replace countryname2 = "Burma (Myanmar)" if countryname2 == "Myanmar (Burma)"
		
		*merge with iso3c_r
		sort iso3c_r year
		merge m:1 iso3c_r year using "~/Desktop/aid_nexus_fragility/data/FSI_reduced/fsi_reduced_all.dta"
		list countryname1 countryname2 if _merge == 2
			* it seems the missing countries are correct, because those are the ones that we don't have (or which we have only partially) on the recipients' side
		drop if _merge == 2
		drop _merge

		sort panelid2 year
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		*xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0)
		*xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0)
		
		
*by country
set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "AUS", ll(0) tobit cnames(AUS) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_AABCDF) nest replace

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "AUT", ll(0) tobit cnames(AUT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_AABCDF) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "BEL", ll(0) tobit cnames(BEL) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_AABCDF) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "CAN", ll(0) tobit cnames(CAN) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_AABCDF) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "DNK", ll(0) tobit cnames(DNK) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_AABCDF) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "FIN", ll(0) tobit cnames(FIN) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_AABCDF) nest 

*2
set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "FRA", ll(0) tobit cnames(FRA) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_FDGIIJ) nest replace

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "DEU", ll(0) tobit cnames(DEU) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_FDGIIJ) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "GRC", ll(0) tobit cnames(GRC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_FDGIIJ) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "IRL", ll(0) tobit cnames(IRL) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_FDGIIJ) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "ITA", ll(0) tobit cnames(ITA) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_FDGIIJ) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "JPN", ll(0) tobit cnames(JPN) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_FDGIIJ) nest 

*3
set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "KOR", ll(0) tobit cnames(KOR) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_KLNNNP) nest replace

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "LUX", ll(0) tobit cnames(LUX) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_KLNNNP) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "NLD", ll(0) tobit cnames(NLD) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_KLNNNP) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "NZL", ll(0) tobit cnames(NZL) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_KLNNNP) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "NOR", ll(0) tobit cnames(NOR) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_KLNNNP) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "PRT", ll(0) tobit cnames(PRT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_KLNNNP) nest 

*4
set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "ESP", ll(0) tobit cnames(ESP) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_ESCGU) nest replace

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "SWE", ll(0) tobit cnames(SWE) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_ESCGU) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "CHE", ll(0) tobit cnames(CHE) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_ESCGU) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "GBR", ll(0) tobit cnames(GBR) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_ESCGU) nest 

set more off
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "USA", ll(0) tobit cnames(USA) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_DEV_ESCGU) nest 

*************** Peace ODA / FSI data ***************
clear 
set more off
cd "~/Desktop/aid_nexus_fragility"
use "data/merged/PEC_FSI_merged.dta"

*generating log variables
generate peclog=log(crs_pec)
generate gdplog=log(gdp)
generate co2log=log(co2)
generate exportlog=log(export)
generate distcaplog=log(distcap)
generate poplog=log(population)
generate fsilog=log(fsi)
generate freedomlog=log(freedom)

*generating a square variable
gen gdplog2=gdplog^2

*dropping repeated time values
drop if year==year[_n-1]

*declaring it as a panel dataset and defining a time variable
xtset panelid2 year, yearly

*generate lag variables
gen gdplog_lag=l1.gdplog


cd "output"

*random effect tobit 
*v1
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(FSI_PEC_DAC) nest replace

*v2
encode iso3c_d, gen(donor)
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0) tobit add(Year Dummy, YES, Censored obs, x) save(FSI_PEC_DAC_v2) nest replace

* NO CO2
xttobit peclog L.fsi L.exportlog distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)

	* REVIEW 2
	xttobit peclog L.fsi i.year, ll(0)
	xttobit peclog L.fsi i.year i.donor, ll(0)
	xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0)
	xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0)

	* with the reduced-FSI data
		replace countryname2 = "Congo-Brazzaville" if countryname2 == "Congo - Brazzaville"
		replace countryname2 = "Democratic Republic of Congo" if countryname2 == "Congo - Kinshasa"
		replace countryname2 = "Sao Tome & Principe" if countryname2 == "SÃ£o TomÃ© & PrÃ­ncipe"
		replace countryname2 = "Burma (Myanmar)" if countryname2 == "Myanmar (Burma)"
		
		*merge with iso3C_r
		sort iso3c_r year
		merge m:1 iso3c_r year using "~/Desktop/aid_nexus_fragility/data/FSI_reduced/fsi_reduced_all.dta"
		list countryname1 countryname2 if _merge == 2
			* it seems the missing countries are correct, because those are the ones that we don't have (or which we have only partially) on the recipients' side
		drop if _merge == 2
		drop _merge

		sort panelid2 year
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		*xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0)
		*xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0)
	
*by country
*1
set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "AUS", ll(0) tobit cnames(AUS) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_AABCDF) nest replace

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "AUT", ll(0) tobit cnames(AUT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_AABCDF) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "BEL", ll(0) tobit cnames(BEL) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_AABCDF) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "CAN", ll(0) tobit cnames(CAN) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_AABCDF) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "DNK", ll(0) tobit cnames(DNK) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_AABCDF) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "FIN", ll(0) tobit cnames(FIN) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_AABCDF) nest 

*2
set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "FRA", ll(0) tobit cnames(FRA) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_FDIIJ) nest replace

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "DEU", ll(0) tobit cnames(DEU) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_FDIIJ) nest 

set more off
*asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0) tobit cnames(GRC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_FDIIJ) nest (too few observations available to run the regression)

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "IRL", ll(0) tobit cnames(IRL) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_FDIIJ) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "ITA", ll(0) tobit cnames(ITA) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_FDIIJ) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "JPN", ll(0) tobit cnames(JPN) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_FDIIJ) nest 

*3
set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "KOR", ll(0) tobit cnames(KOR) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_KLNNNP) nest replace

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "LUX", ll(0) tobit cnames(LUX) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_KLNNNP) nest  


set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "NLD", ll(0) tobit cnames(NLD) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_KLNNNP) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "NZL", ll(0) tobit cnames(NZL) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_KLNNNP) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "NOR", ll(0) tobit cnames(NOR) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_KLNNNP) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "PRT", ll(0) tobit cnames(PRT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_KLNNNP) nest 

*4
set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "ESP", ll(0) tobit cnames(ESP) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_ESCGU) nest replace

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "SWE", ll(0) tobit cnames(SWE) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_ESCGU) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "CHE", ll(0) tobit cnames(CHE) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_ESCGU) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "GBR", ll(0) tobit cnames(GBR) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_ESCGU) nest 

set more off
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year if iso3c_d == "USA", ll(0) tobit cnames(USA) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Censored obs, x) save(FSI_PEC_ESCGU) nest 


**** ANOTHER REVIEW **** 
* merge all data into one dataset for simplifying the regression process

clear
cd "~/Desktop/aid_nexus_fragility"
use "data/merged/HMT_FSI_merged.dta"
merge 1:1 panelid year using "data/merged/DEV_FSI_merged.dta"
drop _merge
merge 1:1 panelid year using "data/merged/PEC_FSI_merged.dta"
drop _merge
merge 1:1 panelid year using "data/merged/HMT_SoF_merged.dta"
drop _merge
*merge 1:1 panelid year using "data/merged/DEV_SoF_merged.dta"
*merge 1:1 panelid year using "data/merged/PEC_SoF_merged.dta"
	* not necessary as they include the same extra variable - SoF (aid allocation values are the same as in the FSI regressions)
	
	order crs_dev crs_pec, after(crs_hmt)
	order sof, after(fsi)
	order countryname1, after(iso3c_d)
	label variable iso3c_d "DONOR country code"
	label variable countryname1 "DONOR country"
	label variable iso3c_r "RECIPIENT country code"
	order countryname2, after(iso3c_r)
	label variable countryname2 "RECIPIENT country"
	order panelid2, after(countryname1)
	label variable panelid2 "panel identificator DYADIC (numerical)"


* PROBLEM: AID is mil. USD, thus the log+tobit ll(0) treats every aid flow lower than 1 million as zero
	* to solve this, I need to multiply all aid by million (1 is already added)
	
	foreach var of varlist crs_hmt crs_dev crs_pec {
	replace `var' = `var'*1000000
	}
	
	sum crs_hmt crs_dev crs_pec, detail
		* crs_hmt - OK, from 1 to a high number
		* crs_dev has two values negative - one minus one, the other -1471
			list countryname1 countryname2 year crs_dev if crs_dev < 0
			replace crs_dev = . if crs_dev < 0
			
		* crs_pec has two values which are mathematically negative
			list countryname1 countryname2 year crs_pec if crs_pec < 1
			replace crs_pec = . if crs_pec < 1
	
* generating log variables
generate hmtlog=log(crs_hmt)
generate devlog=log(crs_dev)
generate peclog=log(crs_pec)
generate gdplog=log(gdp)
generate co2log=log(co2)
generate exportlog=log(export)
generate distcaplog=log(distcap)
generate poplog=log(population)
generate fsilog=log(fsi)
generate freedomlog=log(freedom)

*generating a square variable
gen gdplog2=gdplog^2

*dropping repeated time values
drop if year==year[_n-1]

*declaring it as a panel dataset and defining a time variable
xtset panelid2 year, yearly

*generate lag variables
gen gdplog_lag=l1.gdplog
gen sof_lag=l1.sof
encode iso3c_d, gen(donor)

/*random effect tobit 
cd "output"*/

	
	/* no CO2
	xttobit hmtlog L.fsi L.exportlog distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)*/

		
* merging with the reduced FSI dataset
		replace countryname2 = "Congo-Brazzaville" if countryname2 == "Congo - Brazzaville"
		replace countryname2 = "Democratic Republic of Congo" if countryname2 == "Congo - Kinshasa"
		replace countryname2 = "Sao Tome & Principe" if countryname2 == "SÃ£o TomÃ© & PrÃ­ncipe"
		replace countryname2 = "Burma (Myanmar)" if countryname2 == "Myanmar (Burma)"
		
		*merge with iso3c_r
		sort iso3c_r year
		merge m:1 iso3c_r year using "data/FSI_reduced/fsi_reduced_all.dta"
		list countryname1 countryname2 if _merge == 2
			* it seems the missing countries are correct, because those are the ones that we don't have (or which we have only partially) on the recipients' side
		drop if _merge == 2
		drop _merge

		sort panelid2 year
		order donor, after(countryname1)
		order country, after(countryname2)
		order fsi_red, after(fsi)
				
save "data/merged/ALL-AID_FSI-SOF_merged_FINAL.dta", replace
clear


**** ANALYSES
cd "~/Desktop/aid_nexus_fragility"
use "data/merged/ALL-AID_FSI-SOF_merged_FINAL.dta"
tsfill, full
	* this is not necessary, it does not influence the results
	* there are empty rows for some pairs, for those recipients which ceased to be eligible for aid within the time period (Croatia, Barbados, Oman etc.)

cd "output/DAC23"

*DAC23 regressions
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year, ll(0) save(FSI_DAC23) nest replace
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year, ll(0) save(FSI_DAC23) nest
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year, ll(0) save(FSI_DAC23) nest
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year, ll(0) save(SoF_DAC23) nest replace
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year, ll(0) save(SoF_DAC23) nest
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year, ll(0) save(SoF_DAC23) nest

* AFTER ANOTHER DISCUSSION, we decided to keep the GDP-square where appropriate for extra checks
* It is models 1.1 (HMT-SOF) and 1.3 (PEC-SOF)

asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom /*L.agree*/ i.year, ll(0) save(SoF_DAC23) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom /*L.agree*/ i.year, ll(0) save(SoF_DAC23) 
	
		
*** EXPORTING THE FINAL DATASET
clear
cd "~/Desktop/aid_nexus_fragility"
use "data/merged/ALL-AID_FSI-SOF_merged_FINAL.dta"

gen sof_exp = exportlog * sof
gen sof_co2 = co2log * sof
gen sof_dist = distcaplog * sof 
gen sof_col = colony * sof 
gen sof_gdp = gdplog * sof
gen sof_gdp2 = gdplog2 * sof
gen sof_pop = poplog * sof 
gen sof_freed = freedom * sof

ren country recipient
label variable recipient "RECIPIENT country"
label variable crs_hmt "humanitarian aid in USD (with 1 USD added to all observations)"
label variable crs_dev "development aid in USD (with 1 USD added to all observations)"
label variable crs_pec "peace aid in USD (with 1 USD added to all observations)"
label variable gdp "GDP per capita"
label variable co2 "CO2 emissions per capita"
label variable fsi "degree of fragility (Fragile States Index, FSI)"
label variable fsi_red "reduced Fragile States Index (excluding E1,P3,X1)"
label variable sof "state of fragility dummy"
label variable freedom "freedom score"
label variable export "donors' exports to recipient countries"
label variable distcap "distance between capitals"
label variable colony "former colony dummy"	
label variable agree "UN voting agreement score"
label variable hmtlog "ln of (crs_hmt + 1)"
label variable devlog "ln of (crs_dev + 1)"
label variable peclog "ln of (crs_pec + 1)"
label variable gdplog "ln of gdp"
label variable co2log "ln of co2"
label variable exportlog "ln of export"
label variable distcaplog "ln of distcap"
label variable poplog "ln of population"
label variable fsilog "ln of fsi"
label variable freedomlog "ln of freedom"
label variable gdplog2 "square of gdplog"
label variable gdplog_lag "gdplog lagged by one year"
label variable sof_lag "sof lagged by one year"
*drop spicountrycode*
label variable sof_exp "interaction of sof and exportlog"
label variable sof_co2 "interaction of sof and co2log"
label variable sof_dist "interaction of sof and distcaplog"
label variable sof_col "interaction of sof and colony"
label variable sof_gdp "interaction of sof and gdplog"
label variable sof_gdp2 "interaction of sof and gdplog2"
label variable sof_pop "interaction of sof and poplog"
label variable sof_freed "interaction of sof and freedom"
format %9.0g year

* go-back to zeros in aid allocations
label variable crs_hmt "humanitarian aid in USD"
label variable crs_dev "development aid in USD"
label variable crs_pec "peace aid in USD"
replace crs_hmt = crs_hmt - 1
replace crs_dev = crs_dev - 1
replace crs_pec = crs_pec - 1
save "data/final/dataset.dta", replace
export excel using "data/final/dataset.xlsx", replace firstrow(variable)
clear
		

*******
*******
 * INDIVIDUAL COUNTRIES RESULTS EXPORT
cd "~/Desktop/aid_nexus_fragility"
use "data/merged/ALL-AID_FSI-SOF_merged_FINAL.dta"
		
cd "output/individual_donors/"
* Australia
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0) tobit fs(9) title(Table 1. Regression results - Australia) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) save(individual_donor_tables) replace 
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0) tobit fs(9) title(Table 1. Regression results - Australia) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0) tobit fs(9) title(Table 1. Regression results - Australia) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0) tobit fs(9) title(Table 1. Regression results - Australia) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0) tobit fs(9) title(Table 1. Regression results - Australia) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0) tobit fs(9) title(Table 1. Regression results - Australia) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Austria
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0) tobit fs(9) title(Table 2. Regression results - Austria) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0) tobit fs(9) title(Table 2. Regression results - Austria) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0) tobit fs(9) title(Table 2. Regression results - Austria) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0) tobit fs(9) title(Table 2. Regression results - Austria) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0) tobit fs(9) title(Table 2. Regression results - Austria) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0) tobit fs(9) title(Table 2. Regression results - Austria) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 		

* Belgium
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0) tobit fs(9) title(Table 3. Regression results - Belgium) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0) tobit fs(9) title(Table 3. Regression results - Belgium) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0) tobit fs(9) title(Table 3. Regression results - Belgium) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0) tobit fs(9) title(Table 3. Regression results - Belgium) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0) tobit fs(9) title(Table 3. Regression results - Belgium) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0) tobit fs(9) title(Table 3. Regression results - Belgium) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Canada
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0) tobit fs(9) title(Table 4. Regression results - Canada) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0) tobit fs(9) title(Table 4. Regression results - Canada) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0) tobit fs(9) title(Table 4. Regression results - Canada) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0) tobit fs(9) title(Table 4. Regression results - Canada) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0) tobit fs(9) title(Table 4. Regression results - Canada) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0) tobit fs(9) title(Table 4. Regression results - Canada) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Switzerland
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0) tobit fs(9) title(Table 5. Regression results - Switzerland) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0) tobit fs(9) title(Table 5. Regression results - Switzerland) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0) tobit fs(9) title(Table 5. Regression results - Switzerland) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0) tobit fs(9) title(Table 5. Regression results - Switzerland) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0) tobit fs(9) title(Table 5. Regression results - Switzerland) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0) tobit fs(9) title(Table 5. Regression results - Switzerland) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Germany
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0) tobit fs(9) title(Table 6. Regression results - Germany) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0) tobit fs(9) title(Table 6. Regression results - Germany) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0) tobit fs(9) title(Table 6. Regression results - Germany) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0) tobit fs(9) title(Table 6. Regression results - Germany) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0) tobit fs(9) title(Table 6. Regression results - Germany) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0) tobit fs(9) title(Table 6. Regression results - Germany) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Denmark
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0) tobit fs(9) title(Table 7. Regression results - Denmark) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0) tobit fs(9) title(Table 7. Regression results - Denmark) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0) tobit fs(9) title(Table 7. Regression results - Denmark) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0) tobit fs(9) title(Table 7. Regression results - Denmark) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0) tobit fs(9) title(Table 7. Regression results - Denmark) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0) tobit fs(9) title(Table 7. Regression results - Denmark) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Spain
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0) tobit fs(9) title(Table 8. Regression results - Spain) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0) tobit fs(9) title(Table 8. Regression results - Spain) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0) tobit fs(9) title(Table 8. Regression results - Spain) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0) tobit fs(9) title(Table 8. Regression results - Spain) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0) tobit fs(9) title(Table 8. Regression results - Spain) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0) tobit fs(9) title(Table 8. Regression results - Spain) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Finland
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0) tobit fs(9) title(Table 9. Regression results - Finland) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0) tobit fs(9) title(Table 9. Regression results - Finland) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0) tobit fs(9) title(Table 9. Regression results - Finland) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0) tobit fs(9) title(Table 9. Regression results - Finland) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0) tobit fs(9) title(Table 9. Regression results - Finland) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0) tobit fs(9) title(Table 9. Regression results - Finland) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* France
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FRA", ll(0) tobit fs(9) title(Table 10. Regression results - France) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "FRA", ll(0) tobit fs(9) title(Table 10. Regression results - France) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "FRA", ll(0) tobit fs(9) title(Table 10. Regression results - France) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "FRA", ll(0) tobit fs(9) title(Table 10. Regression results - France) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "FRA", ll(0) tobit fs(9) title(Table 10. Regression results - France) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "FRA", ll(0) tobit fs(9) title(Table 10. Regression results - France) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* United Kingdom
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0) tobit fs(9) title(Table 11. Regression results - United Kingdom) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0) tobit fs(9) title(Table 11. Regression results - United Kingdom) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0) tobit fs(9) title(Table 11. Regression results - United Kingdom) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0) tobit fs(9) title(Table 11. Regression results - United Kingdom) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0) tobit fs(9) title(Table 11. Regression results - United Kingdom) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0) tobit fs(9) title(Table 11. Regression results - United Kingdom) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Greece
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0) tobit fs(9) title(Table 12. Regression results - Greece) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0) tobit fs(9) title(Table 12. Regression results - Greece) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0) tobit fs(9) title(Table 12. Regression results - Greece) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0) tobit fs(9) title(Table 12. Regression results - Greece) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0) tobit fs(9) title(Table 12. Regression results - Greece) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
*asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0) tobit fs(9) title(Table 12. Regression results - Greece) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Ireland
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0) tobit fs(9) title(Table 13. Regression results - Ireland) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0) tobit fs(9) title(Table 13. Regression results - Ireland) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0) tobit fs(9) title(Table 13. Regression results - Ireland) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0) tobit fs(9) title(Table 13. Regression results - Ireland) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0) tobit fs(9) title(Table 13. Regression results - Ireland) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0) tobit fs(9) title(Table 13. Regression results - Ireland) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Italy
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0) tobit fs(9) title(Table 14. Regression results - Italy) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0) tobit fs(9) title(Table 14. Regression results - Italy) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0) tobit fs(9) title(Table 14. Regression results - Italy) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0) tobit fs(9) title(Table 14. Regression results - Italy) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0) tobit fs(9) title(Table 14. Regression results - Italy) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0) tobit fs(9) title(Table 14. Regression results - Italy) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Japan
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0) tobit fs(9) title(Table 15. Regression results - Japan) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0) tobit fs(9) title(Table 15. Regression results - Japan) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0) tobit fs(9) title(Table 15. Regression results - Japan) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0) tobit fs(9) title(Table 15. Regression results - Japan) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0) tobit fs(9) title(Table 15. Regression results - Japan) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0) tobit fs(9) title(Table 15. Regression results - Japan) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Korea
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0) tobit fs(9) title(Table 16. Regression results - Korea) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0) tobit fs(9) title(Table 16. Regression results - Korea) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0) tobit fs(9) title(Table 16. Regression results - Korea) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0) tobit fs(9) title(Table 16. Regression results - Korea) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0) tobit fs(9) title(Table 16. Regression results - Korea) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0) tobit fs(9) title(Table 16. Regression results - Korea) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Luxembourg
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0) tobit fs(9) title(Table 17. Regression results - Luxembourg) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0) tobit fs(9) title(Table 17. Regression results - Luxembourg) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0) tobit fs(9) title(Table 17. Regression results - Luxembourg) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0) tobit fs(9) title(Table 17. Regression results - Luxembourg) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0) tobit fs(9) title(Table 17. Regression results - Luxembourg) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0) tobit fs(9) title(Table 17. Regression results - Luxembourg) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Netherlands
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0) tobit fs(9) title(Table 18. Regression results - Netherlands) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0) tobit fs(9) title(Table 18. Regression results - Netherlands) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0) tobit fs(9) title(Table 18. Regression results - Netherlands) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0) tobit fs(9) title(Table 18. Regression results - Netherlands) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0) tobit fs(9) title(Table 18. Regression results - Netherlands) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0) tobit fs(9) title(Table 18. Regression results - Netherlands) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Norway
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0) tobit fs(9) title(Table 19. Regression results - Norway) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0) tobit fs(9) title(Table 19. Regression results - Norway) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0) tobit fs(9) title(Table 19. Regression results - Norway) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0) tobit fs(9) title(Table 19. Regression results - Norway) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0) tobit fs(9) title(Table 19. Regression results - Norway) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0) tobit fs(9) title(Table 19. Regression results - Norway) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* New Zealand
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0) tobit fs(9) title(Table 20. Regression results - New Zealand) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0) tobit fs(9) title(Table 20. Regression results - New Zealand) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0) tobit fs(9) title(Table 20. Regression results - New Zealand) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0) tobit fs(9) title(Table 20. Regression results - New Zealand) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0) tobit fs(9) title(Table 20. Regression results - New Zealand) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0) tobit fs(9) title(Table 20. Regression results - New Zealand) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Portugal
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0) tobit fs(9) title(Table 21. Regression results - Portugal) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0) tobit fs(9) title(Table 21. Regression results - Portugal) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0) tobit fs(9) title(Table 21. Regression results - Portugal) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0) tobit fs(9) title(Table 21. Regression results - Portugal) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0) tobit fs(9) title(Table 21. Regression results - Portugal) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0) tobit fs(9) title(Table 21. Regression results - Portugal) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* Sweden
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0) tobit fs(9) title(Table 22. Regression results - Sweden) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0) tobit fs(9) title(Table 22. Regression results - Sweden) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0) tobit fs(9) title(Table 22. Regression results - Sweden) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0) tobit fs(9) title(Table 22. Regression results - Sweden) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0) tobit fs(9) title(Table 22. Regression results - Sweden) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0) tobit fs(9) title(Table 22. Regression results - Sweden) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 

* United States
asdoc xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "USA", ll(0) tobit fs(9) title(Table 23. Regression results - United States) cnames(SOF-HMT) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) reset
asdoc xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0) tobit fs(9) title(Table 23. Regression results - United States) cnames(SOF-DEV) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "USA", ll(0) tobit fs(9) title(Table 23. Regression results - United States) cnames(SOF-PEC) drop(0bn.sof_lag 0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "USA", ll(0) tobit fs(9) title(Table 23. Regression results - United States) cnames(FSI-HMT) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0) tobit fs(9) title(Table 23. Regression results - United States) cnames(FSI-DEV) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
asdoc xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if iso3c_d == "USA", ll(0) tobit fs(9) title(Table 23. Regression results - United States) cnames(FSI-PEC) drop(0o.colony 2009b.year 2010.year 2011.year 2012.year 2013.year 2014.year 2015.year 2016.year 2017.year 2018.year 2019.year) add(Year dummy, yes) stat(N_lc) nest notes(Notes: L1. indicates that the variable is lagged by one year, and ln_ indicates that the variable is log-transformed. SOF = State of fragility. FSI = Degree of fragility. HMT = Humanitarian aid. DEV = Development aid. PEC = Peace aid.) 
