* SECOND REVISIONS: Robustness checks 

cd "~/Desktop/aid_nexus_fragility"
use "data/merged/ALL-AID_FSI-SOF_merged_FINAL.dta"
tsfill, full
	* this is not necessary, it does not influence the results
	* there are empty rows for some pairs, for those recipients which ceased to be eligible for aid within the time period (Croatia, Barbados, Oman etc.)

	* by country check - NOTE: try with and without the GDP square variable
log using "output/log/99_countries_only-fragility_CHECK_GDP-no-sq.log", replace
foreach var of varlist  hmtlog devlog peclog {
	forvalues i = 1(1)11 {
		di `i' " DONOR"
		xttobit `var' L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == `i', ll(0) nolog
		}
	}
foreach var of varlist  hmtlog devlog peclog {
	forvalues i = 13(1)20 {
		di `i' " DONOR"
		xttobit `var' L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == `i', ll(0) nolog
		}
	}
foreach var of varlist  hmtlog devlog peclog {
	forvalues i = 22(1)23 {
		di `i' " DONOR"
		xttobit `var' L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == `i', ll(0) nolog
		}
	}
foreach var of varlist  hmtlog devlog peclog {
	forvalues i = 1(1)11 {
		di `i' " DONOR"
		xttobit `var' L.sof L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == `i', ll(0) nolog
		}
	}
foreach var of varlist  hmtlog devlog peclog {
	forvalues i = 13(1)20 {
		di `i' " DONOR"
		xttobit `var' L.sof L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == `i', ll(0) nolog
		}
	}
foreach var of varlist  hmtlog devlog peclog {
	forvalues i = 22(1)23 {
		di `i' " DONOR"
		xttobit `var' L.sof L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == `i', ll(0) nolog
		}
	}
log close

	* Attempts for Greece
	xttobit hmtlog L.sof L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 12, ll(0) /*needs lots of iterations, no square effect signif. */
	xttobit devlog L.sof L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 12, ll(0) /*inverted income effect, but I am not using the square variable */
	xttobit peclog L.sof L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 12, ll(0)
	xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 12, ll(0)
	xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 12, ll(0) /*inverted income effect, but I am not using the square variable */
		*xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 12, ll(0) /*doesn't converge at all */
	
	* Attempts for Portugal (no income effect)
	xttobit hmtlog L.sof L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 21, ll(0)
	xttobit devlog L.sof L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 21, ll(0)
	xttobit peclog L.sof L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 21, ll(0)
	xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 21, ll(0)
	xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 21, ll(0)
	xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year if donor == 21, ll(0)
	
* REVIEW 2
		
		*** FSI ***
		
		*Humanitarian aid
		xttobit hmtlog L.fsi i.year, ll(0)
			*xttobit hmtlog L.fsi i.year i.donor, ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
			*xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donor, ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)

		*Development aid
		xttobit devlog L.fsi i.year, ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		
		*Peace aid - FSI
		xttobit peclog L.fsi i.year, ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		

		*** SoF ***
		
			/* interactions creation
			gen sof_exp = exportlog * sof
			gen sof_co2 = co2log * sof
			gen sof_dist = distcaplog * sof 
			gen sof_col = colony * sof 
			gen sof_gdp = gdplog * sof
			gen sof_gdp2 = gdplog2 * sof
			gen sof_pop = poplog * sof 
			gen sof_freed = freedom * sof 
			*gen sof_agree = agree * sof*/	
		
		*Humanitarian aid
		xttobit hmtlog i.sof_lag i.year, ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed i.year, ll(0)	
		
		*Development aid
		xttobit devlog i.sof_lag i.year, ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed i.year, ll(0)
		
		*Peace aid
		xttobit peclog i.sof_lag i.year, ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed i.year, ll(0)
		
	
	* more efficient way of doing some of them
		xttobit hmtlog L.fsi i.year, ll(0)
		xttobit devlog L.fsi i.year, ll(0)
		xttobit peclog L.fsi i.year, ll(0)
		xttobit hmtlog i.sof_lag i.year, ll(0)
		xttobit devlog i.sof_lag i.year, ll(0)
		xttobit peclog i.sof_lag i.year, ll(0)
						
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year, ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year, ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year, ll(0)
					
			* without the fragility variables, the models for FSI and SOF are the same
		
	* another robustness check with reduced FSI (all presented models with FSI are without the GDP-square)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year, ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year, ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom i.year, ll(0)
		
		* just to test
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year, ll(0)		
		
	* another robustness check with SOF-interactions
		gen sof_exp = exportlog * sof
		gen sof_co2 = co2log * sof
		gen sof_dist = distcaplog * sof 
		gen sof_col = colony * sof 
		gen sof_gdp = gdplog * sof
		gen sof_gdp2 = gdplog2 * sof
		gen sof_pop = poplog * sof 
		gen sof_freed = freedom * sof 
		xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed i.year, ll(0)	
		xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp /*L.sof_gdp2*/ L.sof_pop L.sof_freed i.year, ll(0)
		xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed i.year, ll(0)
		xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.sof_exp L.sof_co2 sof_dist sof_col L.sof_gdp L.sof_gdp2 L.sof_pop L.sof_freed i.year, ll(0)

	* robustness checks: final models with agree
		xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom L.agree i.year, ll(0)
		xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom L.agree i.year, ll(0)
		xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom L.agree i.year, ll(0)
		xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0) 
		xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom L.agree i.year, ll(0) 
		xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year, ll(0) 
		
		
	encode iso3c_d, gen(donors)
	encode iso3c_r, gen(recipients)
	log using "output/log/_____FE_agree.log", replace
	* robustness checks: original models with fixed effects
		xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year i.donors i.recipients, ll(0)
		xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year i.donors i.recipients, ll(0)
		xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year i.donors i.recipients, ll(0)
		xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom /*L.agree*/ i.year i.donors i.recipients, ll(0) 
		xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year i.donors i.recipients, ll(0) 
		xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom /*L.agree*/ i.year i.donors i.recipients, ll(0) 
		
		xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year i.donors i.recipients, ll(0) 
		xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom /*L.agree*/ i.year i.donors i.recipients, ll(0) 
		

	* robustness checks: agree in models with fixed effects
		xttobit hmtlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom L.agree i.year i.donors i.recipients, ll(0)
		xttobit devlog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom L.agree i.year i.donors i.recipients, ll(0)
		xttobit peclog L.fsi L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom L.agree i.year i.donors i.recipients, ll(0)
		xttobit hmtlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donors i.recipients, ll(0) 
		xttobit devlog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog /*L.gdplog2*/ L.poplog L.freedom L.agree i.year i.donors i.recipients, ll(0) 
		xttobit peclog i.sof_lag L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom L.agree i.year i.donors i.recipients, ll(0)
	log close	
	
	
	***********

		* by country - 138 regressions (23*6) * 2 (all only with fragility; then all without fragility) + 3*23 (all three with the reduced FSI)  = 345 regressions (which is also 15 regressions per a country)
		
		* NOT UPDATED FOR THE (NON)-SQUARE EFFECT!
		
		* Australia
		xttobit hmtlog L.fsi i.year if iso3c_d == "AUS", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "AUS", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "AUS", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "AUS", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "AUS", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "AUS", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		
		* Austria
		xttobit hmtlog L.fsi i.year if iso3c_d == "AUT", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "AUT", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "AUT", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "AUT", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "AUT", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "AUT", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUT", ll(0)
		
		* Belgium
		xttobit hmtlog L.fsi i.year if iso3c_d == "BEL", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "BEL", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "BEL", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "BEL", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "BEL", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "BEL", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "BEL", ll(0)
		
		* Canada
		xttobit hmtlog L.fsi i.year if iso3c_d == "CAN", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "CAN", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "CAN", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "CAN", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "CAN", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "CAN", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CAN", ll(0)
		
		* Denmark
		xttobit hmtlog L.fsi i.year if iso3c_d == "DNK", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "DNK", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "DNK", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "DNK", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "DNK", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "DNK", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DNK", ll(0)
		
		* Finland
		xttobit hmtlog L.fsi i.year if iso3c_d == "FIN", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "FIN", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "FIN", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "FIN", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "FIN", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "FIN", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "FIN", ll(0)
		
		* France
		xttobit hmtlog L.fsi i.year if iso3c_d == "AUS", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "AUS", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "AUS", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "AUS", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "AUS", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "AUS", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "AUS", ll(0)
		
		* Germany
		xttobit hmtlog L.fsi i.year if iso3c_d == "DEU", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "DEU", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "DEU", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "DEU", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "DEU", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "DEU", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "DEU", ll(0)
		
		* Greece
		xttobit hmtlog L.fsi i.year if iso3c_d == "GRC", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "GRC", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "GRC", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "GRC", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "GRC", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "GRC", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GRC", ll(0)
		
		* Ireland
		xttobit hmtlog L.fsi i.year if iso3c_d == "IRL", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "IRL", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "IRL", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "IRL", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "IRL", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "IRL", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "IRL", ll(0)
		
		* Italy
		xttobit hmtlog L.fsi i.year if iso3c_d == "ITA", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "ITA", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "ITA", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "ITA", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "ITA", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "ITA", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ITA", ll(0)
		
		* Japan
		xttobit hmtlog L.fsi i.year if iso3c_d == "JPN", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "JPN", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "JPN", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "JPN", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "JPN", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "JPN", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "JPN", ll(0)
		
		* Korea
		xttobit hmtlog L.fsi i.year if iso3c_d == "KOR", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "KOR", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "KOR", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "KOR", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "KOR", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "KOR", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "KOR", ll(0)
		
		* Luxembourg
		xttobit hmtlog L.fsi i.year if iso3c_d == "LUX", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "LUX", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "LUX", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "LUX", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "LUX", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "LUX", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "LUX", ll(0)
		
		* Netherlands
		xttobit hmtlog L.fsi i.year if iso3c_d == "NLD", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "NLD", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "NLD", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "NLD", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "NLD", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "NLD", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NLD", ll(0)
		
		* New Zealand
		xttobit hmtlog L.fsi i.year if iso3c_d == "NZL", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "NZL", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "NZL", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "NZL", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "NZL", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "NZL", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NZL", ll(0)
		
		* Norway
		xttobit hmtlog L.fsi i.year if iso3c_d == "NOR", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "NOR", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "NOR", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "NOR", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "NOR", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "NOR", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "NOR", ll(0)
		
		* Portugal
		xttobit hmtlog L.fsi i.year if iso3c_d == "PRT", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "PRT", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "PRT", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "PRT", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "PRT", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "PRT", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "PRT", ll(0)
		
		* Spain
		xttobit hmtlog L.fsi i.year if iso3c_d == "ESP", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "ESP", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "ESP", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "ESP", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "ESP", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "ESP", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "ESP", ll(0)
		
		* Sweden
		xttobit hmtlog L.fsi i.year if iso3c_d == "SWE", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "SWE", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "SWE", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "SWE", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "SWE", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "SWE", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "SWE", ll(0)
		
		* Switzerland
		xttobit hmtlog L.fsi i.year if iso3c_d == "CHE", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "CHE", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "CHE", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "CHE", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "CHE", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "CHE", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "CHE", ll(0)
		
		* United Kingdom
		xttobit hmtlog L.fsi i.year if iso3c_d == "GBR", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "GBR", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "GBR", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "GBR", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "GBR", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "GBR", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "GBR", ll(0)
		
		* United States
		xttobit hmtlog L.fsi i.year if iso3c_d == "USA", ll(0)
		xttobit hmtlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0)
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0)
		xttobit devlog L.fsi i.year if iso3c_d == "USA", ll(0)
		xttobit devlog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0)
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0)
		xttobit peclog L.fsi i.year if iso3c_d == "USA", ll(0)
		xttobit peclog /*L.fsi*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0)
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0)
		xttobit hmtlog i.sof_lag i.year if iso3c_d == "USA", ll(0)
		xttobit hmtlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0)
		xttobit devlog i.sof_lag i.year if iso3c_d == "USA", ll(0)
		xttobit devlog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0)
		xttobit peclog i.sof_lag i.year if iso3c_d == "USA", ll(0)
		xttobit peclog /*i.sof_lag*/ L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if iso3c_d == "USA", ll(0)

		
		
		* Countries robustness checks - more efficient ways of doing this
				log using "output/log/____countries_fragility-only.log", replace
		forvalues i = 1(1)11 {
		di `i' " HMT FSI"
		xttobit hmtlog L.fsi i.year if donor == `i', ll(0) nolog 
		di `i' " DEV FSI"
		xttobit devlog L.fsi i.year if donor == `i', ll(0) nolog 
		di `i' " PEC FSI"
		xttobit peclog L.fsi i.year if donor == `i', ll(0)  nolog
		di `i' " HMT SOF"
		xttobit hmtlog i.sof_lag i.year if donor == `i', ll(0) nolog
		di `i' " DEV SOF"
		xttobit devlog i.sof_lag i.year if donor == `i', ll(0)  nolog
		di `i' " PEC SOF"
		xttobit peclog i.sof_lag i.year if donor == `i', ll(0) nolog
		}
		forvalues i = 13(1)20 {
		di `i' " HMT FSI"
		xttobit hmtlog L.fsi i.year if donor == `i', ll(0)  nolog
		di `i' " DEV FSI"
		xttobit devlog L.fsi i.year if donor == `i', ll(0)  nolog
		di `i' " PEC FSI"
		xttobit peclog L.fsi i.year if donor == `i', ll(0)  nolog
		di `i' " HMT SOF"
		xttobit hmtlog i.sof_lag i.year if donor == `i', ll(0) nolog
		di `i' " DEV SOF"
		xttobit devlog i.sof_lag i.year if donor == `i', ll(0)  nolog
		di `i' " PEC SOF"
		xttobit peclog i.sof_lag i.year if donor == `i', ll(0) nolog
		}
		forvalues i = 22(1)23 {
		di `i' " HMT FSI"
		xttobit hmtlog L.fsi i.year if donor == `i', ll(0)  nolog
		di `i' " DEV FSI"
		xttobit devlog L.fsi i.year if donor == `i', ll(0)  nolog
		di `i' " PEC FSI"
		xttobit peclog L.fsi i.year if donor == `i', ll(0)  nolog
		di `i' " HMT SOF"
		xttobit hmtlog i.sof_lag i.year if donor == `i', ll(0) nolog
		di `i' " DEV SOF"
		xttobit devlog i.sof_lag i.year if donor == `i', ll(0)  nolog
		di `i' " PEC SOF"
		xttobit peclog i.sof_lag i.year if donor == `i', ll(0) nolog
		}
		log close
		
		
	* I will not be doing this now since we are not that much interested in the other-than-fragility variables
		/*log using "output/log/6_countries_without-fragility.log", replace
		forvalues i = 1(1)11 {
		xttobit hmtlog L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) 
		xttobit devlog L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) 
		xttobit peclog L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) 
		}
		forvalues i = 12(1)20 {
		xttobit hmtlog L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) 
		xttobit devlog L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) 
		xttobit peclog L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) 
		}
		forvalues i = 22(1)23 {
		xttobit hmtlog L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) 
		xttobit devlog L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) 
		xttobit peclog L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) 
		}
		log close
		*/
			* 3 models are enough: without the fragility variables, the models for FSI and SOF are the same
		
		
		
		
		log using "output/log/____countries_reduced-FSI.log", replace
		*
		forvalues i = 1(1)11 {
		di `i' " HMT FSI reduced"
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) nolog
		di `i' " DEV FSI reduced"
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) nolog 
		di `i' " PEC FSI reduced"
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) nolog 
		}
		forvalues i = 13(1)20 {
		di `i' " HMT FSI reduced"
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) nolog 
		di `i' " DEV FSI reduced"
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) nolog 
		di `i' " PEC FSI reduced"
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) nolog 
		}
		forvalues i = 22(1)23 {
		di `i' " HMT FSI reduced"
		xttobit hmtlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) nolog
		di `i' " DEV FSI reduced"
		xttobit devlog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) nolog
		di `i' " PEC FSI reduced"
		xttobit peclog L.fsi_red L.exportlog L.co2log distcaplog i.colony L.gdplog L.gdplog2 L.poplog L.freedom i.year if donor == `i', ll(0) nolog 
		}
		log close	
		
		
		pwcorr fsi exportlog co2log distcaplog colony gdplog gdplog2 poplog freedom /*variables from original regressions*/
		pwcorr fsi_red exportlog co2log distcaplog colony gdplog gdplog2 poplog freedom /*reduced FSI vs. original variables */
