




clear

capture log close
cd $data
log using $lofi/Stream, replace
set more off, perm
numlabel _all, add force




copy "https://github.com/asjadnaqvi/The-Stata-Guide/blob/master/data/demo_r_mweek3_medium.dta?raw=true" "demo_r_mweek3_medium.dta", replace





use "demo_r_mweek3_medium.dta", clear


keep if geo=="AT"
drop unit




split year, p(W) destring   // extract year and weeks
drop year
ren year1 year
ren year2 week



drop if year>2020  // in case the data is updated to include 2021



gen date = yw(year,week) // not needed but given as date example
format date %tw



order geo date age
sort geo date age



*** keep the main age brackets
keep if  age == "Y_LT5"  | ///
   age == "Y5-9"  | /// 
   age == "Y10-14" | /// 
   age == "Y15-19" | /// 
   age == "Y20-24" | /// 
   age == "Y25-29" | /// 
   age == "Y30-34" | /// 
   age == "Y35-39" | /// 
   age == "Y40-44" | /// 
   age == "Y45-49" | /// 
   age == "Y50-54" | ///  
   age == "Y55-59" | ///  
   age == "Y60-64" | /// 
   age == "Y65-69" | /// 
   age == "Y70-74" | /// 
   age == "Y75-79" | /// 
   age == "Y80-84" | ///
   age == "Y85-89" | ///
   age == "Y_GE90" | /// 
   age == "TOTAL"




*** keep information for total population
keep if sex=="T"  
drop sex



*** replace hyphens with underscores
replace age = subinstr(age, "-", "_", .) 



ren y tot_
reshape wide tot_, i(geo date year week) j(age) string


sort geo date


ren tot_* *



recode Y* (.=0)
drop if date==.


encode geo, gen(geo2)
order geo2 date


drop TOTAL


*** clean up names
ren Y5_9   Y05_09
ren Y_LT5  Y00_04 
ren Y_GE90 Y90_100


order Y*, alpha last    // notice the order options here


*** aggregate the data
egen Y00_64 = rowtotal(Y00_04 - Y60_64)
egen Y65_99 = rowtotal(Y65_69 - Y90_100)



drop Y00_04 - Y90_100
order geo geo2 date year week


// fix the angles of data points


sort year week


levelsof year, local(lvls)


foreach x of local lvls {


gen obs_`x' = _n if year==`x'


local year1 = `x' - 1
cap replace obs_`x' = _n if year==`year1' & week==52

gen angle_`x' = obs_`x' * -2 * _pi / 52

gen x65_`x' = Y65_99 * cos(angle_`x')
gen y65_`x' = Y65_99 * sin(angle_`x')


}



drop obs* angle*





****** spike markers here


gen obs = _n in 1/26
gen theta = -obs * _pi / 26


summ Y65_99
local cmin = max(0, round(`r(min)', 20) - 50)
local cmax = round(`r(max)', 20) + 50


display `cmin'
display `cmax'


local diff = round((`cmax' -  `cmin') / 6) // divisions


gen px1 =  abs((`cmax' * 1.05) * cos(theta))   
gen px2 = -abs((`cmax' * 1.05) * cos(theta))


gen py1 = tan(theta)*px1
gen py2 = tan(theta)*px2



gen marker1 = obs
gen marker2 = obs


replace marker1 = marker1 + 26 if py1 > -1e-02
replace marker2 = marker2 + 26 if py2 >  1e-02


****** spike markers here

summ Y65_99
local cmin = max(0, round(`r(min)', 20) - 50)
local cmax = round(`r(max)', 20) + 50

local diff = round((`cmax' -  `cmin') / 6)


cap gen xvar = .
cap gen yvar = .


local i = 1


forval x = `cmin'(`diff')`cmax' {


replace xvar = `x' in `i' 
replace yvar = 0 in `i'
local i = `i' + 1

}


local circle  // reset the local



summ Y65_99
local cmin = max(0, round(`r(min)', 20) - 100)
local cmax = round(`r(max)', 20) + 100

local diff = round((`cmax' -  `cmin') / 6)










*** circles

colorpalette gs12 gs14, n(12) reverse nograph


local i = 1


forval x = `cmin'(`diff')`cmax' {


local width = `i' * 0.05

local circle `circle' (function sqrt(`x'^2 - x^2), lc("`r(p`i')'%70") lw(`width') lp(solid) range(-`x' `x')) || (function -sqrt(`x'^2 - x^2), lc("`r(p`i')'%70") lw(`width') lp(solid) range(-`x' `x')) ||

local i = `i' + 1


}


*** spikes


local spike


forval x = 1/26 {

local theta = (`x') * _pi / 26    
local liner = abs((`cmax' + 40) * cos(`theta'))    
local spike `spike' (function (tan(`theta'))*x, n(2) range(-`liner' `liner') lw(vvthin) lc(gs8) lp(solid)) ||

}

***** final graph here

colorpalette inferno, n(15) reverse nograph



twoway ///
`circle' ///
`spike'  ///
(scatter py1 px1, mc(none) ms(point) mlab(marker1) mlabpos(0) mlabc(gs6) mlabsize(*0.5)) ///
(scatter py2 px2, mc(none) ms(point) mlab(marker2) mlabpos(0) mlabc(gs6) mlabsize(*0.5)) ///
(scatter yvar xvar, mc(none) ms(point) mlab(xvar) mlabpos(9) mlabc(gs6) mlabangle(vertical) mlabsize(*0.4))  ///
(line y65_2015 x65_2015, lc("`r(p3)'")  lp(solid) lw(vthin)) ///
(line y65_2016 x65_2016, lc("`r(p4)'")  lp(solid) lw(vthin)) ///
(line y65_2017 x65_2017, lc("`r(p5)'")  lp(solid) lw(vthin)) ///
(line y65_2018 x65_2018, lc("`r(p6)'")  lp(solid) lw(vthin)) ///
(line y65_2019 x65_2019, lc("`r(p7)'")  lp(solid) lw(vthin)) ///
(line y65_2020 x65_2020, lc("`r(p15)'") lp(solid) lw(thin)) ///
,    ///
aspect(1) legend(off)   ///
xscale(off) yscale(off) ///
xsize(1) ysize(1) ///
xlabel(, nogrid) ylabel(, nogrid) ///
title("{fontface Arial Bold: Excess deaths in Austria}") ///
subtitle("65 years and older", size(small)) ///
note("Source: Eurostat table demo_r_mweek3. Week spokes are labeled on the outer edge in a clockwise direction. The ring values, given as vertical numbers," "show the number of deaths. 2020 values plotted in bold red color, and 2015-2019 values plotted in light grey-red shades.", size(tiny))


























