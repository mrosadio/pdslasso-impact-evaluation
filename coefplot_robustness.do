* ============================================================================
* ROBUSTNESS CHECK: PDS-LASSO coefficient plots under alternative lambda
* ============================================================================
*
* PURPOSE
*   Visualize treatment effect estimates from Part 8 (lambda = plugin value)
*   alongside the robustness check from Part 9 (lambda increased by 50%),
*   to assess sensitivity of results to the LASSO penalty parameter.
*
* RATIONALE
*   PDS-LASSO results depend on the choice of penalty parameter (lambda),
*   which determines how many controls are selected. Comparing point
*   estimates and confidence intervals under the plugin lambda vs. a 50%
*   larger lambda shows whether treatment effects are sensitive to this
*   choice — a standard robustness check for LASSO-based inference.
*
* STRUCTURE
*   Each figure compares two specifications side by side for each outcome:
*     - lambda = plugin (estimated in estimation_pdslasso.do)
*     - lambda = plugin x 1.5 (estimated in estimation_pdslasso.do)
*   across the 3 treatment definitions (Training+Placement, Training,
*   Placement), shown as separate panels via `bylabel`.
*
*   `relocate()` aligns equivalent coefficients across panels, since each
*   treatment definition produces differently-named stored estimates.
*   `groups()` adds outcome-level labels spanning each pair of bars.
*
* FIGURES
*   Figure 4: Intermediary outcomes (job search, interviews, confidence)
*   Figure 5-6: Labor market outcomes (employment, income, hours),
*               split into 4 parts and combined via `grc1leg`

* OUTPUTS
*   $graphs/figure_robustness_lambda_intermediary_outcomes.png  (Figure 4)
*   $graphs/figure_robustness_lambda_labor_outcomes_part1.gph   (Figure 5)
*   $graphs/figure_robustness_lambda_labor_outcomes_part2.gph   (Figure 6)
	
	
// Figure 4: Robustness check for PDS LASSO - Intermediary outcomes ------------

 	coefplot (search_month_rtw_pl_1_s, keep(rtw_pl) 						///
			 label("{&lambda} plugin")  $coef_modelopts1)			 		///
			 (search_month_rtw_pl_1_s50, keep(rtw_pl) 						///
			 label("{&lambda} 50% increase") `$coef_modelopts2') 			///
			 (interv_inv_rtw_pl_1_s, keep(rtw_pl) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (interv_inv_rtw_pl_1_s50, keep(rtw_pl) 						///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (nrinterv_rtw_pl_1_s, keep(rtw_pl) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (nrinterv_rtw_pl_1_s50, keep(rtw_pl) 							///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (inter_grad_rtw_pl_1_s, keep(rtw_pl) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (inter_grad_rtw_pl_1_s50, keep(rtw_pl) 						///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (asp_sh_rtw_pl_1_s, keep(rtw_pl) 								///
				label("{&lambda} plugin")  $coef_modelopts1) 				///
			 (asp_sh_rtw_pl_1_s50, keep(rtw_pl) 							///
				label("{&lambda} 50% increase") `$coef_modelopts2') 		///
			 (asp_ln_rtw_pl_1_s, keep(rtw_pl) 								///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (asp_ln_rtw_pl_1_s50, keep(rtw_pl) 							///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Training + Placement") subtitle(, size(medium)) 	///
			 || 															///
			 (search_month_rtwtr_1_s, keep(rtwtr) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (search_month_rtwtr_1_s50, keep(rtwtr) 						///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (interv_inv_rtwtr_1_s, keep(rtwtr) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (interv_inv_rtwtr_1_s50, keep(rtwtr) 							///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (nrinterv_rtwtr_1_s, keep(rtwtr) 								///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (nrinterv_rtwtr_1_s50, keep(rtwtr) 							///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (inter_grad_rtwtr_1_s, keep(rtwtr) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (inter_grad_rtwtr_1_s50, keep(rtwtr) 							///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (asp_sh_rtwtr_1_s, keep(rtwtr) 								///
				label("{&lambda} plugin") $coef_modelopts1)					///
			 (asp_sh_rtwtr_1_s50, keep(rtwtr) 								///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (asp_ln_rtwtr_1_s, keep(rtwtr) 								///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (asp_ln_rtwtr_1_s50, keep(rtwtr) 								///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Training") subtitle(, size(medium)) 				///
			 || 															///
			 (search_month_rtw_pl3_1_s, keep(rtw_pl3) 						///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (search_month_rtw_pl3_1_s50, keep(rtw_pl3) 					///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (interv_inv_rtw_pl3_1_s, keep(rtw_pl3) 						///
				label("{&lambda} plugin") $coef_modelopts1)		 			///
			 (interv_inv_rtw_pl3_1_s50, keep(rtw_pl3) 						///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (nrinterv_rtw_pl3_1_s, keep(rtw_pl3) 							///
				label("{&lambda} plugin")  $coef_modelopts1) 				///
			 (nrinterv_rtw_pl3_1_s50, keep(rtw_pl3) 						///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (inter_grad_rtw_pl3_1_s, keep(rtw_pl3) 						///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (inter_grad_rtw_pl3_1_s50, keep(rtw_pl3) 						///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (asp_sh_rtw_pl3_1_s, keep(rtw_pl3) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (asp_sh_rtw_pl3_1_s50, keep(rtw_pl3) 							///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 (asp_ln_rtw_pl3_1_s, keep(rtw_pl3) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
			 (asp_ln_rtw_pl3_1_s50, keep(rtw_pl3) 							///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Placement") subtitle(, size(medium)) 				///
			 aseq swapnames grid(within) msize(medium) 						///
			 legend(order(2 "{&lambda} plugin" 4 "{&lambda} 50% increase") 	///
					pos(4) /*rows(1)*/) 									///
			 xline(0 , lcolor(gs8) lwidth(thin) lpattern(dash))				///
			 relocate(search_month_rtwtr_1_s = 1 							///
					search_month_rtwtr_1_s50 = 2 							///
					interv_inv_rtwtr_1_s = 3 								///
					interv_inv_rtwtr_1_s50 = 4 								///
					nrinterv_rtwtr_1_s = 5 									///
					nrinterv_rtwtr_1_s50 = 6 								///
					inter_grad_rtwtr_1_s = 7 								///
					inter_grad_rtwtr_1_s50 = 8 								///
					asp_sh_rtwtr_1_s = 9 									///
					asp_sh_rtwtr_1_s50 = 10 								///
					asp_ln_rtwtr_1_s = 11 									///
					asp_ln_rtwtr_1_s50 = 12 								///
					search_month_rtw_pl3_1_s = 1 							///
					search_month_rtw_pl3_1_s50 = 2 							///
					interv_inv_rtw_pl3_1_s = 3 								///
					interv_inv_rtw_pl3_1_s50 = 4 							///
					nrinterv_rtw_pl3_1_s = 5 								///
					nrinterv_rtw_pl3_1_s50 = 6 								///
					inter_grad_rtw_pl3_1_s = 7 								///
					inter_grad_rtw_pl3_1_s50 = 8 							///
					asp_sh_rtw_pl3_1_s = 9 									///
					asp_sh_rtw_pl3_1_s50 = 10 								///
					asp_ln_rtw_pl3_1_s = 11 								///
					asp_ln_rtw_pl3_1_s50 = 12) 								///
			groups(search_month_* = "Duration of job search" 				///
					interv_inv_* = "Invited to an interview" 				///
					nrinterv_* = "No. invited interviews" 					///
					inter_grad_* = "Internship after graduation" 			///
					asp_sh_* = "Confidence (short term)" 					///
					asp_ln_* = "Confidence (long term)" 					///
					, labsize(medium)) 										///
			coeflabels(search_month_* = " " interv_inv_* = " " 				///
						nrinterv_*= " " inter_grad_* = " " 					///
						asp_sh_* = " " asp_ln_* = " ", notick)  			///
			xlab(-0.5(0.25)0.5,labsize(medium)) legend(size(medium) rows(1)) ///
			byopts(cols(3))
	graph save "$graphs/figure_robustness_lambda_intermediary_outcomes.gph", replace
	graph export "$graphs/figure_robustness_lambda_intermediary_outcomes.png", replace


	
// Figure 5: Robustness check for PDS LASSO - Labor market outcomes ------------
	
 	* Binary variables
	coefplot 	(empl_rtw_pl_1_s, keep(rtw_pl) 								///
				label("{&lambda} plugin")  $coef_modelopts1) 				///
				(empl_rtw_pl_1_s50, keep(rtw_pl) 							///
				label("{&lambda} 50% increase") `$coef_modelopts2') 		///
				(contract_rtw_pl_1_s, keep(rtw_pl) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
				(contract_rtw_pl_1_s50, keep(rtw_pl) 						///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
				(jobformal_rtw_pl_1_s, keep(rtw_pl) 						///
				label("{&lambda} plugin") $coef_modelopts1) 				///
				(jobformal_rtw_pl_1_s50, keep(rtw_pl) 						///
				label("{&lambda} 50% increase") $coef_modelopts2)			///
			 , bylabel("Training + Placement") subtitle(, size(medium)) 	///
			 || 															///
				(empl_rtwtr_1_s, keep(rtwtr) 								///
				label("{&lambda} plugin") $coef_modelopts1) 				///
				(empl_rtwtr_1_s50, keep(rtwtr) 								///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
				(contract_rtwtr_1_s, keep(rtwtr) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
				(contract_rtwtr_1_s50, keep(rtwtr) 							///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
				(jobformal_rtwtr_1_s, keep(rtwtr) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
				(jobformal_rtwtr_1_s50, keep(rtwtr) 						///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Training") subtitle(, size(medium)) 				///
			 || 															///
				(empl_rtw_pl3_1_s, keep(rtw_pl3) 							///
				label("{&lambda} plugin") $coef_modelopts1) 				///
				(empl_rtw_pl3_1_s50, keep(rtw_pl3) 							///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
				(contract_rtw_pl3_1_s, keep(rtw_pl3) 						///
				label("{&lambda} plugin") $coef_modelopts1) 				///
				(contract_rtw_pl3_1_s50, keep(rtw_pl3) 						///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
				(jobformal_rtw_pl3_1_s, keep(rtw_pl3) 						///
				label("{&lambda} plugin")  $coef_modelopts1) 				///
				(jobformal_rtw_pl3_1_s50, keep(rtw_pl3) 					///
				label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Placement") subtitle(, size(medium)) 				///
			 relocate(empl_rtwtr_1_s = 1 									///
					empl_rtwtr_1_s50 = 2 									///
					contract_rtwtr_1_s = 3 									///
					contract_rtwtr_1_s50 = 4 								///
					jobformal_rtwtr_1_s = 5 								///
					jobformal_rtwtr_1_s50 = 6 								///
					empl_rtw_pl3_1_s = 1 									///
					empl_rtw_pl3_1_s50 = 2 									///
					contract_rtw_pl3_1_s = 3 								///
					contract_rtw_pl3_1_s50 = 4 								///
					jobformal_rtw_pl3_1_s = 5 								///
					jobformal_rtw_pl3_1_s50 = 6) 							///
			groups(empl_* = "    Employment    " 							///
					contract_* = `" "Job with    "  "contract    " "' 		///
					jobformal_* = `" "Formal    " "employment    "  "' 		///
					, labsize(medium) wrap(16)) 							///
			coeflabels(empl_* = " " contract_* = " "						///
						jobformal_*= " ", notick)  							///
			 aseq swapnames grid(within) msize(medium) 						///
			 legend(order(2 "{&lambda} plugin" 4 "{&lambda} 50% increase") 	///
					pos(4)) 												///
			 xline(0 , lcolor(gs8) lwidth(thin) lpattern(dash)) 			///
			 xlab(,labsize(medium)) legend(size(medium) rows(1)) 			///
			 byopts(cols(3) imargin(3 3 0 0))
	
	graph save "$graphs/figure_robustness_lambda_part1.gph", replace
	
	
	* Monthly income
	
	mylabels -200(100)200, myscale(@*1000) local(xlabel) 

		coefplot (income_tot_rtw_pl_1_s, keep(rtw_pl) 						///
				 label("{&lambda} plugin")  $coef_modelopts1) 				///
				 (income_tot_rtw_pl_1_s50, keep(rtw_pl) 					///
				 label("{&lambda} 50% increase") `$coef_modelopts2') 		///
				 (inctot_emp_rtw_pl_1_s, keep(rtw_pl) 						///
				 label("{&lambda} plugin")  $coef_modelopts1) 				///
				 (inctot_emp_rtw_pl_1_s50, keep(rtw_pl) 					///
				 label("{&lambda} 50% increase") `$coef_modelopts2') 		///
			 , bylabel("Training + Placement") subtitle(, size(medium)) 	///
			 || 															///
				 (income_tot_rtwtr_1_s, keep(rtwtr) 						///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (income_tot_rtwtr_1_s50, keep(rtwtr) 						///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
				 (inctot_emp_rtwtr_1_s, keep(rtwtr) 						///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (inctot_emp_rtwtr_1_s50, keep(rtwtr) 						///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Training") subtitle(, size(medium)) 				///
			 || 															///
				 (income_tot_rtw_pl3_1_s, keep(rtw_pl3) 					///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (income_tot_rtw_pl3_1_s50, keep(rtw_pl3) 					///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
				 (inctot_emp_rtw_pl3_1_s, keep(rtw_pl3) 					///
				 label("{&lambda} plugin") $coef_modelopts1)				///
				 (inctot_emp_rtw_pl3_1_s50, keep(rtw_pl3) 					///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Placement") subtitle(, size(medium)) 				///
			 aseq swapnames grid(within) msize(medium) 						///
			 legend(order(2 "{&lambda} plugin" 4 "{&lambda} 50% increase") 	///
					pos(4) /*rows(1)*/) 									///
			 xline(0 , lcolor(gs8) lwidth(thin) lpattern(dash)) 			///
			 relocate(income_tot_rtwtr_1_s = 1 								///
					income_tot_rtwtr_1_s50 = 2 								///
					inctot_emp_rtwtr_1_s = 3 								///
					inctot_emp_rtwtr_1_s50 = 4 								///
					income_tot_rtw_pl3_1_s = 1 								///
					income_tot_rtw_pl3_1_s50 = 2 							///
					inctot_emp_rtw_pl3_1_s = 3 								///
					inctot_emp_rtw_pl3_1_s50 = 4) 							///
			groups(income_tot_* = "Monthly income" 							///
				 inctot_emp_* = 											///
				 "Monthly income (conditional on employment)" 				///
				, labsize(medium) wrap(16)) 								///
			coeflabels(income_tot_* = " " inctot_emp_* = " ", notick)  		///
			xlab(`xlabel',labsize(medium)) legend(size(medium) rows(1)) 	///
			byopts(cols(3) imargin(3 3 0 0))
			
		graph save "$graphs/figure_robustness_lambda_part2.gph", replace
		
	

// Figure 6: Robustness check for PDS LASSO - Labor market outcomes ------------
	
	coefplot 	(inc_pr_hr_rtw_pl_1_s, keep(rtw_pl) 						///
				 label("{&lambda} plugin")  $coef_modelopts1) 				///
				 (inc_pr_hr_rtw_pl_1_s50, keep(rtw_pl) 						///
				 label("{&lambda} 50% increase") `$coef_modelopts2') 		///
				 (inc_hr_emp_rtw_pl_1_s, keep(rtw_pl) 						///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (inc_hr_emp_rtw_pl_1_s50, keep(rtw_pl) 					///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Training + Placement") subtitle(, size(medium)) 	///
			 || 															///
				 (inc_pr_hr_rtwtr_1_s, keep(rtwtr) 							///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (inc_pr_hr_rtwtr_1_s50, keep(rtwtr) 						///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
				 (inc_hr_emp_rtwtr_1_s, keep(rtwtr) 						///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (inc_hr_emp_rtwtr_1_s50, keep(rtwtr) 						///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Training") subtitle(, size(medium)) 				///
			 || 															///
				 (inc_pr_hr_rtw_pl3_1_s, keep(rtw_pl3) 						///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (inc_pr_hr_rtw_pl3_1_s50, keep(rtw_pl3) 					///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
				 (inc_hr_emp_rtw_pl3_1_s, keep(rtw_pl3) 					///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (inc_hr_emp_rtw_pl3_1_s50, keep(rtw_pl3) 					///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Placement") subtitle(, size(medium)) 				///
			 aseq swapnames grid(within) msize(medium) 						///
			 legend(order(2 "{&lambda} plugin" 4 "{&lambda} 50% increase") 	///
					pos(4)) 												///
			 xline(0 , lcolor(gs8) lwidth(thin) lpattern(dash)) 			///
			 relocate(inc_pr_hr_rtwtr_1_s = 1 								///
					inc_pr_hr_rtwtr_1_s50 = 2 								///
					inc_hr_emp_rtwtr_1_s = 3 								///
					inc_hr_emp_rtwtr_1_s50 = 4 								///
					inc_pr_hr_rtw_pl3_1_s = 1 								///
					inc_pr_hr_rtw_pl3_1_s50 = 2 							///
					inc_hr_emp_rtw_pl3_1_s = 3 								///
					inc_hr_emp_rtw_pl3_1_s50 = 4) 							///
			groups(inc_pr_hr_* = "Hourly wage  " 							///
					inc_hr_emp_* = 											///
		`" "Hourly wage    " "(conditional on    " "employment)    "  "' 	///
					, labsize(medium) wrap(16)) 							///
			coeflabels(inc_pr_hr_* = " " inc_hr_emp_* = " ", notick)  		///
			xlab(-500(250)500,labsize(medium)) legend(size(medium) rows(1)) ///
			byopts(cols(3) imargin(3 3 0 0))
			
		graph save "$graphs/figure_robustness_lambda_part3.gph", replace
			
	
	* Monthly working hours, monthly working hours among employed
	coefplot 	(hrs_month_rtw_pl_1_s, keep(rtw_pl) 						///
				label("{&lambda} plugin") $coef_modelopts1) 				///
				 (hrs_month_rtw_pl_1_s50, keep(rtw_pl) 						///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
				 (hs_emp_rtw_pl_1_s, keep(rtw_pl) 							///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (hs_emp_rtw_pl_1_s50, keep(rtw_pl) 						///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Training + Placement") subtitle(, size(medium)) 	///
			 || 															///
				 (hrs_month_rtwtr_1_s, keep(rtwtr) 							///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (hrs_month_rtwtr_1_s50, keep(rtwtr) 						///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
				 (hs_emp_rtwtr_1_s, keep(rtwtr) 							///
				 label("{&lambda} plugin") $coef_modelopts1) 				///
				 (hs_emp_rtwtr_1_s50, keep(rtwtr) 							///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Training") subtitle(, size(medium)) 				///
			 || 															///
				 (hrs_month_rtw_pl3_1_s, keep(rtw_pl3) 						///
				 label("{&lambda} plugin")  $coef_modelopts1) 				///
				 (hrs_month_rtw_pl3_1_s50, keep(rtw_pl3) 					///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
				 (hs_emp_rtw_pl3_1_s, keep(rtw_pl3) 						///
				 label("{&lambda} plugin")  $coef_modelopts1) 				///
				 (hs_emp_rtw_pl3_1_s50, keep(rtw_pl3) 						///
				 label("{&lambda} 50% increase") $coef_modelopts2) 			///
			 , bylabel("Placement") subtitle(, size(medium)) 				///
			 aseq swapnames grid(within) msize(medium) 						///
			 legend(order(2 "{&lambda} plugin" 4 "{&lambda} 50% increase") 	///
					pos(4)) 												///
			 xline(0 , lcolor(gs8) lwidth(thin) lpattern(dash)) 			///
			 relocate(hrs_month_rtwtr_1_s = 1 								///
					hrs_month_rtwtr_1_s50 = 2 								///
					hs_emp_rtwtr_1_s = 3 									///
					hs_emp_rtwtr_1_s50 = 4 									///
					hrs_month_rtw_pl3_1_s = 1 								///
					hrs_month_rtw_pl3_1_s50 = 2 							///
					hs_emp_rtw_pl3_1_s = 3 									///
					hs_emp_rtw_pl3_1_s50 = 4) 								///
			groups(hrs_month_* = "Monthly working hours" 					///
					hs_emp_* = 												///
					"Monthly working hours (conditional on employment)" 	///
					, labsize(medium) wrap(19)) 							///
			coeflabels(hrs_month_*= " " hs_emp_* = " " , notick)  			///
			xlab(,labsize(medium)) legend(size(medium) rows(1)) 			///
			byopts(cols(3) imargin(3 3 0 0))
	graph save "$graphs/figure_robustness_lambda_part4.gph", replace
			
			
	* Combine graphs
	grc1leg "$graphs/figure_robustness_lambda_part1.gph" ///
			"$graphs/figure_robustness_lambda_part2.gph" ///
			, cols(1) ysize(12) xsize(10) imargin(0 0 0 0)
			
	graph save "$graphs/figure_robustness_lambda_labor_outcomes_part1.gph" ///
				, replace
			
	grc1leg "$graphs/figure_robustness_lambda_part3.gph" ///
			"$graphs/figure_robustness_lambda_part4.gph" ///
			, cols(1) ysize(12) xsize(10) imargin(0 0 0 0)
	
	graph save "$graphs/figure_robustness_lambda_labor_outcomes_part2.gph" ///
				, replace
