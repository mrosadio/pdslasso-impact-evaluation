* ============================================================================
* PDS-LASSO ESTIMATION: Treatment effects of a youth employment program
* ============================================================================
*
* PURPOSE
*   Estimate effects of a "Ready to Work" (RtW) youth employment program on
*   labor market outcomes, using PDS-LASSO (Belloni, Chernozhukov & Hansen,
*   2014) for data-driven selection of control variables from a large set
*   of candidates.
*
* METHOD
*   For each outcome variable, PDS-LASSO selects controls separately for
*   the outcome and treatment equations, then estimates the treatment
*   effect using the union of selected controls ("post" estimation).
*   This avoids manual specification search while controlling for a rich
*   set of baseline characteristics.

* INPUTS
*   - $pds_controls: global defining the candidate control set (interactions
*     of categorical baseline characteristics + continuous controls),
*     defined in [globals file]
*   - $intermediary_outcomes, $labor_outcomes: outcome variable lists
*
* Each estimation stores additional diagnostics for reporting:
*   - no_control:    total candidate controls considered
*   - control_sel:   number of controls selected by PDS-LASSO
*   - mean_control:  control group mean (for interpreting effect sizes)
*
* OUTPUTS
*   $results/estimations_school_FE.ster
*   $results/estimations_school_courses_FE.ster
*   $results/estimations_school_courses_regions_FE.ster
*   (each contains stored estimates for all outcome x treatment x sample
*    combinations under that FE specification)
* ============================================================================


* LOOP STRUCTURE
*   For each of [N] outcome variables:
*     For each of 3 treatment definitions (rtw_pl, rtwtr, rtw_pl3):
*       For 2 samples (full sample; early graduates only):
*         Estimate PDS-LASSO under 3 sets of "always-included" controls
*         (school FE; school+course FE; school+course+region FE)
*
*   Results are stored via `eststo` and saved to .ster files by FE
*   specification, to be assembled into tables .

/*==============================================================================
			PART 1: Estimate robustness check with lambda = plugin
==============================================================================*/	

	foreach dep_var in $intermediary_outcomes $labor_outcomes {
		
		*For each outcome: reg for 3 treatment indicators
		foreach treatment of varlist rtw_pl rtwtr rtw_pl3 {
							
			*For each treatment indicator: reg for 2 subsamples
			forvalues sample = 1/2 {
				
				if `sample' == 1 { //All obs
					local keep_sample_obs "" 
				}
				
				if `sample' == 2 { //Early graduates 
					local keep_sample_obs "& inlist(school_type,2,3)" 
				}		
				
					
					preserve
					keep if `treatment' !=. `keep_sample_obs'
						
					* Estimations
					
					** PDS Lasso 
					*** amelioration set: school type FE
					cap qui {
						eststo `dep_var'_`treatment'_`sample'_s: 	///
						pdslasso `dep_var' `treatment' 				///
								($pds_controls) 					///
								, aset(i.school_type) 				///
								post(pds) robust 
						estadd scalar no_control 		= e(xhighdim_ct)
						estadd scalar control_sel 		= e(xselected_ct)
						summ `dep_var' if `treatment' 	== 0
						estadd scalar mean_control 		= r(mean)
						summ `dep_var' if `treatment' 	== 1 & `dep_var'> 0
						estadd scalar subobs			= r(N)
						
						est title: `dep_var'_`treatment'_`sample'_s
						est save "$results/estimations_school_FE.ster",append
					}
					
					if _rc !=0 {
						local oldrc = _rc
						exit `oldrc'
					}

					
					** PDS Lasso 
					*** amelioration set: school type and courses FE
					cap qui {
						eststo `dep_var'_`treatment'_`sample'_sc: 	///
						pdslasso `dep_var' `treatment' 				///
								($pds_controls) 					///
								, aset(i.school_type i.cat_courses) ///
								post(pds) robust 
						estadd scalar no_control 		= e(xhighdim_ct)
						estadd scalar control_sel 		= e(xselected_ct)
						summ `dep_var' if `treatment' 	== 0
						estadd scalar mean_control 		= r(mean)
						summ `dep_var' if `treatment' 	== 1 & `dep_var'> 0
						estadd scalar subobs			= r(N)
						
						est title: `dep_var'_`treatment'_`sample'_sc
						est save "$results/estimations_school_courses_FE.ster", append
					}
					
					if _rc !=0 {
						local oldrc = _rc
						exit `oldrc'
					}

	
					** PDS Lasso 
					*** amelioration set: school type, courses and regions FE
					cap qui {
						eststo `dep_var'_`treatment'_`sample'_scr: 	///
						pdslasso `dep_var' `treatment'		 		///
								($pds_controls) 					///
								, aset(i.school_type i.cat_courses 	///
									   i.region) 					///
								post(pds) robust 
						estadd scalar no_control 		= e(xhighdim_ct)
						estadd scalar control_sel 		= e(xselected_ct)
						summ `dep_var' if `treatment' 	== 0
						estadd scalar mean_control 		= r(mean)
						summ `dep_var' if `treatment' 	== 1 & `dep_var'> 0
						estadd scalar subobs			= r(N)
						
						est title: `dep_var'_`treatment'_`sample'_scr
						est save "$results/estimations_school_courses_regions_FE.ster", append
					}
					
					if _rc !=0 {
						local oldrc = _rc
						exit `oldrc'
					}
					
				*Restore
					restore
			}
		}
	}	

	
	
/*==============================================================================
			PART 2: Estimate robustness check with lambda increased by 50%
==============================================================================*/	

	
	
	foreach dep_var in $intermediary_outcomes $labor_outcomes {
		
		*For each outcome: reg for 3 treatment indicators
		foreach treatment of varlist rtw_pl rtwtr rtw_pl3 {
							
			*For each treatment indicator: 2 samples
			forvalues sample = 1/2 {
				
				if `sample' == 1 { //All obs
					local keep_sample_obs "" 
				}
				
				if `sample' == 2 { //Early graduates 
					local keep_sample_obs "& inlist(school_type,2,3)" 
				}		
				
					
					preserve
					keep if `treatment' !=. `keep_sample_obs'
						
					* Estimations
					
					** PDS Lasso 
					*** amelioration set: school type FE
					**** penalty parameter lambda increased by 50%
					cap qui {
						eststo `dep_var'_`treatment'_`sample'_s50: 			///
						pdslasso `dep_var' `treatment'						///
								($pds_controls) 							///
								, aset(i.school_type) post(pds) robust 		///
								lopt(c(1.65))
						estadd scalar no_control 		= e(xhighdim_ct)
						estadd scalar control_sel 		= e(xselected_ct)
						summ `dep_var' if `treatment' 	== 0
						estadd scalar mean_control 		= r(mean)
						summ `dep_var' if `treatment' 	== 1 & `dep_var'> 0
						estadd scalar subobs			= r(N)
						
						est title: `dep_var'_`treatment'_`sample'_s50
						est save "$results/robustness_check_school_FE.ster" ///
								, append
					}
					
					if _rc !=0 {
						local oldrc = _rc
						exit `oldrc'
					}

					restore
			}
		}
	}	
