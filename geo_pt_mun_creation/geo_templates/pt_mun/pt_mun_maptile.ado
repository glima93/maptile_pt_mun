*! 4december2019, Gonçalo Lima, goncalo.lima@novasbe.pt

program define _maptile_pt_mun 
	syntax , [  geofolder(string) ///
				mergedatabase ///
				map spmapvar(varname) var(varname) binvar(varname) clopt(string) legopt(string) min(string) clbreaks(string) max(string) mapcolors(string asis) ndfcolor(string) ///
					savegraph(string) replace resolution(string) map_restriction(string) spopt(string) ///
				 ]
	
	if ("`mergedatabase'"!="") {
				novarabbrev merge 1:m dico  ///
			using `"`geofolder'/pt_mun_database.dta"', nogen 
		exit
	}
	
	if ("`map'"!="") {
		spmap `spmapvar' using `"`geofolder'/pt_mun_coords.dta"' `map_restriction', id(_ID) /// 
			`clopt' ///
			`legopt' ///
			legend(pos(5) size(*1.8)) /// /*XX change the default placement and size of the legend as appropriate for your map*/
			fcolor(`mapcolors') ndfcolor(`ndfcolor') ///
			oc(black ...) ndo(black) ///
			os(vthin ...) nds(vthin) ///
			`spopt'

		* Save graph
		if (`"`savegraph'"'!="") __savegraph_maptile, savegraph(`savegraph') resolution(`resolution') `replace'
		
	}
	
end

* Save map to file
cap program drop __savegraph_maptile
program define __savegraph_maptile

	syntax, savegraph(string) resolution(string) [replace]
	
	* check file extension using a regular expression
	if regexm(`"`savegraph'"',"\.[a-zA-Z0-9]+$") local graphextension=regexs(0)
	
	* deal with different filetypes appropriately
	if inlist(`"`graphextension'"',".gph","") graph save `"`savegraph'"', `replace'
	else if inlist(`"`graphextension'"',".ps",".eps") graph export `"`savegraph'"', mag(`=round(100*`resolution')') `replace'
	else if (`"`graphextension'"'==".png") graph export `"`savegraph'"', width(`=round(3200*`resolution')') `replace'
	else if (`"`graphextension'"'==".tif") graph export `"`savegraph'"', width(`=round(1600*`resolution')') `replace'
	else graph export `"`savegraph'"', `replace'

end

