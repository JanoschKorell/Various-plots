


clear

capture log close
cd $data
log using $lofi/Heat, replace
set more off, perm
numlabel _all, add force


use ESS/ESS9.dta, clear



*Ländervariable

tab cntry
gen Land = .
replace Land = 0 if cntry == "AT"
replace Land = 1 if cntry == "BE"
replace Land = 2 if cntry == "BG"
replace Land = 3 if cntry == "CH"
replace Land = 4 if cntry == "CY"
replace Land = 5 if cntry == "CZ"
replace Land = 6 if cntry == "DE"
replace Land = 7 if cntry == "DK"
replace Land = 8 if cntry == "EE"
replace Land = 9 if cntry == "ES"
replace Land = 10 if cntry == "FI"
replace Land = 11 if cntry == "FR"
replace Land = 12 if cntry == "GB"
replace Land = 13 if cntry == "HR"
replace Land = 14 if cntry == "HU"
replace Land = 15 if cntry == "IE"
replace Land = 16 if cntry == "IS"
replace Land = 17 if cntry == "IT"
replace Land = 18 if cntry == "LT"
replace Land = 19 if cntry == "LV"
replace Land = 20 if cntry == "ME"
replace Land = 21 if cntry == "NL"
replace Land = 22 if cntry == "NO"
replace Land = 23 if cntry == "PL"
replace Land = 24 if cntry == "PT"
replace Land = 25 if cntry == "RS"
replace Land = 26 if cntry == "SE"
replace Land = 27 if cntry == "SI"
replace Land = 28 if cntry == "SK"
lab de Land 0 "AT" 1 "BE" 2 "BG" 3 "CH" 4 "CY" 5 "CZ" 6 "DE" 7 "DK" 8 "EE" 9 "ES" 10 "FI" 11 "FR" 12 "GB" 13 "HR" 14 "HU" 15 "IE" 16 "IS" 17 "IT" 18 "LT" 19 "LV" 20 "ME" 21 "NL" 22 "NO" 23 "PL" 24 "PT" 25 "RS" 26 "SE" 27 "SI" 28 "SK"
lab val Land Land





*AVs
*"Dont know" = Missing (Es wäre möglich "Dont know" als "Nein" zu definieren.)
*3.1 Gleichheit		
tab sofrdst, m
recode sofrdst (1 = 1) (2 = 1) (3 = 0) (4 = 0) (5 = 0), gen (DichAVGleichheit)
lab var DichAVGleichheit NeinJa
tab DichAVGleichheit, m			//48.386 Gültige Werte


******************************
*3.2 Leistung
tab sofrwrk, m
recode sofrwrk (1 = 1) (2 = 1) (3 = 0) (4 = 0) (5 = 0), gen (DichAVLeistung)
lab var DichAVLeistung NeinJa
tab DichAVLeistung, m			//48.606 Gültige Werte


******************************
*3.3 Bedarf
tab sofrpr, m
recode sofrpr (1 = 1) (2 = 1) (3 = 0) (4 = 0) (5 = 0), gen (DichAVBedarf)
lab var DichAVBedarf NeinJa
tab DichAVBedarf, m				//48.473 Gültige Werte


******************************
*3.4 Anrecht
tab sofrprv, m 
recode sofrprv (1 = 1) (2 = 1) (3 = 0) (4 = 0) (5 = 0), gen (DichAVAnrecht)
lab var DichAVAnrecht NeinJa
tab DichAVAnrecht, m			//47.703 Gültige Werte


keep DichAVGleichheit DichAVLeistung DichAVBedarf DichAVAnrecht Land 




gen Wohlfahrtsstaaten = .
replace Wohlfahrtsstaaten = 1 if Land == 15 | Land == 12
		// Liberaler WS Irland, GB
replace Wohlfahrtsstaaten = 2 if Land == 6	| Land == 11 | Land == 1 | Land == 21 | Land == 3 | Land == 0											
		// Bismarck/Konservativer WS Deutschland, Frankreich, Belgien, Niederlande, Luxemburg???, Schweiz, Austria
replace Wohlfahrtsstaaten = 3 if Land == 26 | Land == 7  | Land == 10 | Land == 22	| Land == 16 																	
		// Skandinavischer/Sozialdemokratischer WS Schweden, Dänemark, Finnland, Norwegen, Island (16)
replace Wohlfahrtsstaaten = 4 if Land == 17 | Land == 9	 | Land == 24 | Land == 4	
		// Mediterraner WS Griechenland???, Italien, Spanien, Portugal, Zypern
replace Wohlfahrtsstaaten = 5 if Land == 5	| Land == 8	 | Land == 14 | Land == 19 | Land == 18 | Land == 23 | Land == 28 | Land == 27 | Land == 2 | Land == 13	| Land == 20 | Land == 25 | Land == 29
		// Osten Czech Republic, Estonia, Hungary, Latvia, Lithuania, Poland, Slovakia, Slovenia, Bulgarien (2), Kroatien (13), Montenegro (20), Serbien (25)


label values Wohlfahrtsstaaten Wohlfahrtsstaaten
label def Wohlfahrtsstaaten 1 "Liberaler WS", modify
label def Wohlfahrtsstaaten 2 "Konservativer WS", modify	
label def Wohlfahrtsstaaten 3 "Sozialdemokratischer WS", modify	
label def Wohlfahrtsstaaten 4 "Mediterraner WS", modify	
label def Wohlfahrtsstaaten 5 "Osteuropa", modify	







collapse (mean) DichAV*, by(Wohlfahrtsstaaten)



gen DichAVGleichheitPro = DichAVGleichheit * 100
gen DichAVLeistungPro = DichAVLeistung * 100
gen DichAVBedarfPro = DichAVBedarf * 100
gen DichAVAnrechtPro = DichAVAnrecht * 100
drop DichAVGleichheit DichAVAnrecht DichAVBedarf DichAVLeistung






save PerzGernachWS.dta, replace





use PerzGernachWS, clear


ren DichAVGleichheitPro index_DichAVGleichheitPro
ren DichAVLeistungPro index_DichAVLeistungPro
ren DichAVBedarfPro index_DichAVBedarfPro
ren DichAVAnrechtPro index_DichAVAnrechtPro

collapse (mean) index*, by(Wohlfahrtsstaaten )
order Wohlfahrtsstaaten 

reshape long index_, i(Wohlfahrtsstaaten) j(Perzeption) string
ren index_ index

reshape wide index, i(Perzeption) j(Wohlfahrtsstaaten)





replace Perzeption = "Anrecht"    		if Perzeption=="DichAVAnrechtPro"
replace Perzeption = "Bedarf"  			if Perzeption=="DichAVBedarfPro"
replace Perzeption = "Gleichheit"       if Perzeption=="DichAVGleichheitPro"
replace Perzeption = "Leistung"         if Perzeption=="DichAVLeistungPro"


ren index1 index_LiberalerWS
ren index2 index_KonservativerWS
ren index3 index_SozialdemokratischerWS
ren index4 index_MediterranerWS
ren index5 index_Osteuropa




levelsof Perzeption
gen angle = _n * 2 * _pi / `r(r)'

foreach x of varlist index_* {
 gen x_`x' = `x' * cos(angle) 
 gen y_`x' = `x' * sin(angle) 
}


gen markerx   = 115 * cos(angle)
gen markery   = 115 * sin(angle)


****

gen xvar = .
gen yvar = .


local i = 1

forval x = 25(25)100 {
replace xvar = `x' in `i' 
replace yvar = 0 in `i' 

local i = `i' + 1 
}








*** here we generate spikes



levelsof Perzeption

 
gen spikes = _n in 1/`r(r)'

local circle  // reset the locals
local spike



cd $grafi/Spider



**Plot***



levelsof Perzeption

forval x = 0(25)100 {
 
 local circle `circle' (function sqrt(`x'^2 - x^2), lc(gs14%80) lw(thin) lp(solid) range(-`x' `x')) || (function -sqrt(`x'^2 - x^2), lc(gs14%80) lw(thin) lp(solid) range(-`x' `x')) ||
}




forval x = 1/`r(r)' {

 local theta = `x' * 2 * _pi / `r(r)'   
 local liner = (105) * cos(`theta')
 local spike `spike' (function (tan(`theta'))*x, n(2) range(0 `liner') lw(*0.8) lc(gs6) lp(solid)) ||

}




colorpalette tableau, n(5) nograph

twoway ///
`circle' ///
`spike'  ///
(area y_index_LiberalerWS x_index_LiberalerWS, nodropbase fcolor("`r(p1)'%15")  lc("`r(p1)'") lw(vthin)) ///
(area y_index_KonservativerWS  x_index_KonservativerWS, nodropbase fcolor("`r(p2)'%15")  lc("`r(p2)'") lw(vthin)) ///
(area y_index_SozialdemokratischerWS x_index_SozialdemokratischerWS, nodropbase fcolor("`r(p3)'%15")  lc("`r(p3)'") lw(vthin)) ///
(area y_index_MediterranerWS x_index_MediterranerWS, nodropbase fcolor("`r(p4)'%15")  lc("`r(p4)'") lw(vthin)) ///
(area y_index_Osteuropa x_index_Osteuropa, nodropbase fcolor("`r(p5)'%15")  lc("`r(p5)'") lw(vthin)) ///
(scatter markery markerx, mc(none) ms(point) mlab(Perzeption) mlabpos(0) mlabc(black) mlabsize(*0.55)) ///
(scatter yvar xvar, mc(none) ms(point) mlab(xvar) mlabpos(10) mlabc(black) mlabsize(*0.4))  ///
,    ///
aspect(1)  ///
xscale(off) yscale(off) ///
xlabel(-5(1)5) ylabel(-5(1)5) ///
xsize(1) ysize(1) ///
xlabel(, nogrid) ylabel(, nogrid) ///
title("Zustimmung zu Gerechtigkeitsarten in Europa in %", size(small)) ///
note("Data source: Oxford COVID-19 Government Response Tracker.", size(tiny)) ///
legend(order(15 "Angelsachsen" 16 "Mitteleuropa" 17 "Nordeuropa" 18 "Südeuropa" 19 "Osteuropa") size(*0.5) pos(6) rows(1)) ///
note("Datenquelle: ESS9", size(tiny)) 
graph export "Spider - Zustimmung zu Gerechtigkeitsarten in Europa in %.jpg", replace as(png) width(4600)









































/*


clear

capture log close
cd $data
log using $lofi/Spider, replace
set more off, perm
numlabel _all, add force





copy "https://github.com/asjadnaqvi/The-Stata-Guide/blob/master/data/country_codes.dta?raw=true" "country_codes.dta", replace



**** actual data 
insheet using "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv", clear





drop if regionname!=""
keep countryname date h6_facialcoverings stringencyindexfordisplay governmentresponseindexfordispla containmenthealthindexfordisplay economicsupportindexfordisplay


ren h6_facialcoverings               index_masks
ren stringencyindexfordisplay        index_strin
ren governmentresponseindexfordispla index_gov
ren containmenthealthindexfordisplay index_cont
ren economicsupportindexfordisplay   index_econ



ren countryname country

tostring date, gen(date2)    // string the date variable
drop date
gen date = date(date2,"YMD")
drop if date < 21915    // 1st January 2020
format date %tdDD-Mon-yy
drop date2





order country date
sort country date


summ date
drop if date > `r(max)' - 5  // just to avoid missing obs



compress
save COVID_policies3.dta, replace



use COVID_policies3, clear



sum index_masks
replace index_masks = ((index_masks - `r(min)') / (`r(max)'-`r(min)')) * 100



replace country="Cabo Verde"         if country=="Cape Verde"
replace country="West Bank and Gaza" if country=="Palestine" 


merge m:1 country using "country_codes.dta"
drop if _m!=3
drop _m



gen id = .
replace id = 1 if group10==1  // European Union (EU) 
replace id = 2 if group35==1  // South Asia (SA)
replace id = 3 if group37==1  // Sub-saharan Africa (SSA) 
replace id = 4 if group20==1  // Latin America & Carribean (LAC)
replace id = 5 if group29==1  // North America (NA) (for exercise)

drop group*
drop if id==.


collapse (mean) index*, by(id date)
order id date

reshape long index_, i(id date) j(policy) string
ren index_ index


reshape wide index, i(policy date) j(id)



replace policy = "Containment"    if policy=="cont"
replace policy = "Govt. support"  if policy=="gov"
replace policy = "Overall"        if policy=="strin"
replace policy = "Masks"          if policy=="masks"
replace policy = "Econ. support"  if policy=="econ"



ren index1 index_EU
ren index2 index_SA
ren index3 index_SSA
ren index4 index_LAC
ren index5 index_NA




summ date
local last = `r(max)'
drop if date != `last'





levelsof policy
gen angle = _n * 2 * _pi / `r(r)'

foreach x of varlist index_* {
 gen x_`x' = `x' * cos(angle) 
 gen y_`x' = `x' * sin(angle) 
}


gen markerx   = 115 * cos(angle)
gen markery   = 115 * sin(angle)


****

gen xvar = .
gen yvar = .


local i = 1

forval x = 20(20)100 {
replace xvar = `x' in `i' 
replace yvar = 0 in `i' 

local i = `i' + 1 
}







sort policy date  x_index_EU y_index_EU


**Plot***



*** here we generate spikes



levelsof policy

 
gen spikes = _n in 1/`r(r)'

local circle  // reset the locals
local spike



sort  policy y_index_EU x_index_EU


levelsof policy

forval x = 0(20)100 {
 
 local circle `circle' (function sqrt(`x'^2 - x^2), lc(gs14%80) lw(thin) lp(solid) range(-`x' `x')) || (function -sqrt(`x'^2 - x^2), lc(gs14%80) lw(thin) lp(solid) range(-`x' `x')) ||
}





forval x = 1/`r(r)' {

 local theta = `x' * 2 * _pi / `r(r)'   
 local liner = (105) * cos(`theta')
 local spike `spike' (function (tan(`theta'))*x, n(2) range(0 `liner') lw(*0.8) lc(gs6) lp(solid)) ||


}





colorpalette tableau, n(5) nograph

twoway ///
`circle' ///
`spike'  ///
(area y_index_EU  x_index_EU , nodropbase fcolor("`r(p1)'%15")  lc("`r(p1)'") lw(vthin)) ///
(area y_index_SA  x_index_SA, nodropbase fcolor("`r(p2)'%15")  lc("`r(p2)'") lw(vthin)) ///
(area y_index_SSA x_index_SSA, nodropbase fcolor("`r(p3)'%15")  lc("`r(p3)'") lw(vthin)) ///
(area y_index_LAC x_index_LAC, nodropbase fcolor("`r(p4)'%15")  lc("`r(p4)'") lw(vthin)) ///
(scatter markery markerx, mc(none) ms(point) mlab(policy) mlabpos(0) mlabc(black) mlabsize(*0.55)) ///
(scatter yvar xvar, mc(none) ms(point) mlab(xvar) mlabpos(10) mlabc(black) mlabsize(*0.4))  ///
,    ///
aspect(1)  ///
xlabel(-5(1)5) ylabel(-5(1)5) ///
xscale(off) yscale(off) ///
xsize(1) ysize(1) ///
xlabel(, nogrid) ylabel(, nogrid) ///
title("{fontface Arial Bold: COVID-19 Policy stringency (`date')}") ///
note("Data source: Oxford COVID-19 Government Response Tracker.", size(tiny)) ///
legend(order(18 "EU" 19 "South Asia" 20 "Sub-Saharan Africa" 21 "Latin America & Caribbean") size(*0.5) pos(6) rows(1))







