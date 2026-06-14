* ============================================================================
* MAP: Geographic distribution of treatment and control schools (Uganda)
* ============================================================================
*
* PURPOSE
*   Visualize the geographic distribution of RtW program (treatment) and
*   control schools across Uganda's regions, alongside nearby cities.
*
* RATIONALE
*   Schools' geographic location determines access to local labor markets,
*   which may independently affect graduates' job search outcomes. This map
*   supports the decision to control for regional fixed effects in the
*   treatment effect estimations, and visually shows that treatment
*   and control schools are not geographically clustered in a way that
*   would confound the analysis.

* DATA SOURCES (not included — see Data Availability in README)
*   - Administrative boundaries (regions, counties): UBOS shapefiles
*   - Inland water bodies: DCW shapefile
*   - School and city coordinates: project-collected GPS data
*     ($maps_Raw/school_and_city_coordinates.dta)
*
* OUTPUTS
*   $maps_Out/UG_schools_distributions.png  (used in thesis, Figure 1)
*   $maps_Out/UG_schools_distributions_alternative.pdf
* ============================================================================


	shp2dta using "$maps_Border/ne_110m_admin_0_countries.shp"			 	///
					, database("$maps_OutDb/countries_all.dta") 			///
					coordinates("$maps_OutCo/countries_all_coord.dta") 		///
					genid(id) replace
				
	
	* Keep only African countries
	use "$maps_OutDb/countries_all.dta", clear
	keep if CONTINENT == "Africa" 
	keep NAME CONTINENT id
	
	* Save dataset with country names
	save "$maps_OutDb/countries_africa.dta", replace
	
	* Merge country labels with coordinates
	use 	"$maps_OutCo/countries_all_coord.dta", clear
	rename 	_ID id
	merge 	m:1 id using "$maps_OutDb/countries_africa.dta"
	keep if _merge == 3
	
	* Save dataset of coordinates
	gen 	_ID = _n // create unique ids
	drop _merge
	sort 	_ID
	save "$maps_OutCo/countries_africa_coord.dta", replace 
	
	
	* Draw map of Africa
	use "$maps_OutCo/countries_africa_coord.dta", clear
	
	spmap using "$maps_OutCo/countries_africa_coord.dta" 			///
			, id(_ID) fcolor(gs11) ocolor(gs16) osize(*0.4) 		///
			polygon(data("$maps_OutCo/countries_africa_coord.dta") 	///
					select(keep if NAME == "Uganda")				///
					fcolor("0 114 41*1.2") ocolor(gs16))
	
	graph export "$maps_Out/Africa_map.png", replace //not included in master thesis
	
	
	
// Figure 1: Location of treatment and control schools -------------------------	
	
	* Convert shp.files to data 
			
			* regions
			shp2dta using "$maps_RawReg/uga_admbnda_adm1_ubos_20200824.shp" ///
					, database("$maps_OutDb/ug_regions.dta") 				///
					coordinates("$maps_OutCo/ugcoord_regions.dta") 			///
					genid(id) replace
					
			*counties
			shp2dta using "$maps_RawCou/UGA_adm2.shp" 						///
					, database("$maps_OutDb/ug_counties.dta") 				///
					coordinates("$maps_OutCo/ugcoord_counties.dta") 		///
					genid(id) replace			
					
			* inland water
			shp2dta using "$maps_RawWat/UGA_water_areas_dcw.shp"		 	///
					, database("$maps_OutDb/ug_water_inland.dta") 			///
					coordinates("$maps_OutCo/ugcoord_water_inland.dta")		///
					genid(id) replace				
		
		/*
		preserve
		use "$maps_OutCo/ugcoord_water_inland.dta", clear
		gen id=_n
		save "$maps_OutCo/ugcoord_water_inland.dta", replace
		restore
		*/	
			
	* Create map		
	preserve
		
		
		use 	"$maps_OutDb/ug_regions.dta", clear
		spmap using "$maps_OutCo/ugcoord_regions.dta" 						///
				, id(id) ocolor(gs4) osize(0.35pt) 							///
				polygon(data("$maps_OutCo/ugcoord_water_inland.dta") 		///
						fcolor(eltblue*0.16) ocolor(eltblue*0.6) 			///
						osize(0.2pt)) 										///
				/*polygon(data("$maps_OutCo/countries_africa_coord.dta") 	///
						select(keep if inlist(NAME, "S. Sudan" 				///
								, "Dem. Rep. Congo", "Rwanda" 				///
								, "Tanzania", "Kenya")))*/ 					///
				point(data("$maps_Raw/school_and_city_coordinates.dta") 	///
					  x(_X) y(_Y) by(treatment) 							///
					  size(*0.25 *0.23) fc("220 36 31" "0 25 168") 			///
					  ocolor("220 36 31*1.5" "0 25 168*1.5") 				///
					  osize(0.25pt 0.25pt) shape(O O) 						///
					  legenda(on) legt(" ") legshow(1 2) legcount) 			///
				label(data("$maps_Raw/school_and_city_coordinates.dta") 	///
					  by(city_school) 										///
					  select(keep if inrange(school_type,4,9)) 				///
					  x(_X) y(_Y) label(city_school) 						///
					  size(6.75pt 5.5pt 5.5pt 8pt 6.75pt 6.75pt) 			///
					  pos(12 12 12 12 12 12) 								///
					  gap(0pt 0.5pt 0.5pt 0.1pt 0.15pt 1.1pt)) 				///
				title(" ") 													///
				text(1 	 32.25 	"CENTRAL" "REGION" 							///
					0.5	 30.6 	"WESTERN" "REGION" 							///
					2.85 32.8 	"NORTHERN" "REGION" 						///
					2 	 33.75 	"EASTERN" "REGION" 							///
					, size(8pt) color(gs11)) 								///
				text(0.26 32.5 	"Entebbe",size(4.75pt)) 					///
				text(-0.35 33.25 "{it:Lake}" "{it:Victoria}" 				///
					, size(7.5pt) color(eltblue*1.3)) 						///
				legend(cols(1) pos(4) bmargin(r=-4 b=+8.5) size(8pt)		///
					   rowgap(1.15pt) symxsize(4pt) symysize(4pt)			///
					   label(1 `"Control" "schools"' 						///
							 3 "RtW" "schools")) 							///	
				plotregion(margin(2 6 0 -5)) 								///
				graphregion(margin(4 4 0 0))
				
		graph export "$maps_Out/UG_schools_distributions_alternative.pdf", replace

	restore
		
	graph save 	"$maps_Out/UG_schools_distributions.gph", replace
		
	graph export "$maps_Out/UG_schools_distributions.png", replace
