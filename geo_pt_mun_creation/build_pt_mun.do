** AUTHOR: Gonçalo Lima
** CONTACT: goncalo.lima@novasbe.pt
* Based on Michael Stepner, stepner@mit.edu

** DESCRIPTION: Imports Portugal municipalities shapefile into Stata format.

/*******************************

** INPUT
- caop.zip
	Downloaded from: http://www.dgterritorio.pt/dados_abertos/caop/
*******************************/

***************************
* STEP 0 : HOUSEKEEPING
***************************
clear
version 13.1
set more off

** Check if run using -project-
return clear
capture project, doinfo
if (_rc==0 & !mi(r(pname))) global root `r(pdir)'  // run using -project-
else {  // running directly

	global root "/Users/Gonçalo/Documents/GitHub/maptile_pt_mun/geo_pt_mun_creation"

	* Disable project (since running do-files directly)
	cap program drop project
	program define project
		di "Project is disabled, skipping project command. (To re-enable, run -{stata program drop project}-)"
	end
	
}

* DIRECTORIES
global raw "$root/raw_data/pt_mun"
global out "$root/geo_templates/pt_mun"
global test "$root/tests/pt_mun"

* ADO PATH
adopath ++ "$root/util"

*****************************
* STEP 1 : UNZIP AND CONVERT
*****************************
project, relies_on("$raw/caop.zip")

cd "$raw"
unzipfile caop.zip, replace

shp2dta using "caop/caop_wfs", /// 
	data("$out/pt_mun_database_temp") coor("$out/pt_mun_coords") replace
	
*****************************
* STEP 2 : CLEAN DATA
*****************************
use "$out/pt_mun_database_temp", clear

destring DICO, gen(dico)
drop DICO
keep dico _ID
label var dico "Code Municipality (4-digit, DICO)"

save13 "$out/pt_mun_database.dta", replace
erase "$out/pt_mun_database_temp.dta"

********************************
* STEP 3 : REFERENCE OTHER FILES
********************************
project, relies_on("$root/readme.txt")
project, relies_on("$out/pt_mun_maptile.ado")
project, relies_on("$out/pt_mun_maptile.scml")

********************************
* STEP 4 : TESTING
********************************
use "$out/pt_mun_database.dta", clear
rename _ID test

maptile test, geo(pt_mun) geofolder($out) ///
	savegraph("$test/pt_mun_test.png") resolution(0.25) replace
project, creates("$test/pt_mun_test.png") preserve

** TESTING WITH REAL DATA
project, original("$raw/toy_dataset")
use "$raw/toy_dataset.dta", clear

maptile acdm_grads, geo(pt_mun) geofolder($out) ///
	savegraph("$test/pt_mun_test_real1.png") resolution(0.25) replace
project, creates("$test/pt_mun_test_real1.png") preserve

maptile per_acdm_col, geo(pt_mun) geofolder($out) ///
	savegraph("$test/pt_mun_test_real2.png") resolution(0.25) replace
project, creates("$test/pt_mun_test_real2.png") preserve

maptile per_vet_col, geo(pt_mun) geofolder($out) ///
	savegraph("$test/pt_mun_test_real3.png") resolution(0.25) replace
project, creates("$test/pt_mun_test_real3.png") preserve


