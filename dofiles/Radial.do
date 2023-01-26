


clear

capture log close
cd $data
log using $lofi/Radial, replace
set more off, perm
numlabel _all, add force

/*

clear

import delimited Meteostat/MünchenNieder1321.csv, clear



ren ïdate date2
rename prcp niederschlag
keep date2 niederschlag


gen  datex = .
tostring datex, gen(date)
drop datex

levelsof date2, local(lvls)

foreach x of local lvls {

replace date = ustrregexs(2) + "-" + ustrregexs(3) + "-" + ustrregexs(1)  if ustrregexm("`x'", "(\d\d\d\d)-(\d\d)-(\d\d)") & date2 == "`x'"

}

gen yearx = .
tostring yearx, gen(year)
drop yearx

levelsof date2, local(lvls)

foreach x of local lvls {

replace year =  ustrregexs(1)  if ustrregexm("`x'", "(\d\d\d\d)-(\d\d)-(\d\d)") & date2 == "`x'"

}

encode year,  gen(yearnum)


//converting string to the date format

gen int daily_date = date(date , "MDY")
format daily_date %td

gen byte weekday = dow(daily_date)



forval i=1/7 {

label def weekday `=`i'-1' `"`: word `i' of `c(Weekdays)''"', modify
}


label values weekday weekday


gen week_num = week(daily_date)



collapse (sum) niederschlag, by(yearnum week_num)

ren week_num week
ren yearnum year1



decode year1, gen(year)
destring year, replace
drop year1
ren niederschlag nie


save niederschlag1321.dta, replace

*/




use  niederschlag1321.dta, clear


// fix the angles of data points



sort year week


levelsof year, local(lvls)


foreach x of local lvls {


gen obs_`x' = _n if year==`x'


local year1 = `x' - 1
cap replace obs_`x' = _n if year==`year1' & week==52

gen angle_`x' = obs_`x' * -2 * _pi / 52

gen xnie`x' = nie * cos(angle_`x')
gen ynie`x' = nie * sin(angle_`x')


}




drop obs* angle*







****** spike markers here


gen obs = _n in 1/26
gen theta = -obs * _pi / 26


summ nie
local cmin = max(0, round(`r(min)', 2) - 2)
local cmax = round(`r(max)', 2) + 2


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

summ nie
local cmin = max(0, round(`r(min)', 2) - 2)
local cmax = round(`r(max)', 2) + 2

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



summ nie
local cmin = max(0, round(`r(min)', 2) - 2)
local cmax = round(`r(max)', 2) + 2

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
(line ynie2013 xnie2013, lc("`r(p1)'")  lp(solid) lw(vthin)) ///
(line ynie2014 xnie2014, lc("`r(p2)'")  lp(solid) lw(vthin)) ///
(line ynie2015 xnie2015, lc("`r(p3)'")  lp(solid) lw(vthin)) ///
(line ynie2016 xnie2016, lc("`r(p4)'")  lp(solid) lw(vthin)) ///
(line ynie2017 xnie2017, lc("`r(p5)'")  lp(solid) lw(vthin)) ///
(line ynie2018 xnie2018, lc("`r(p6)'")  lp(solid) lw(vthin)) ///
(line ynie2019 xnie2019, lc("`r(p7)'")  lp(solid) lw(vthin)) ///
(line ynie2020 xnie2020, lc("`r(p15)'") lp(solid) lw(thin)) ///
(line ynie2021 xnie2021, lc("`r(p16)'") lp(solid) lw(thin)) ///
,    ///
aspect(1) legend(off)   ///
xscale(off) yscale(off) ///
xsize(1) ysize(1) ///
xlabel(, nogrid) ylabel(, nogrid) ///
title("{fontface Arial Bold: Excess deaths in Austria}") ///
subtitle("65 years and older", size(small)) ///
note("Source: Eurostat table demo_r_mweek3. Week spokes are labeled on the outer edge in a clockwise direction. The ring values, given as vertical numbers," "show the number of deaths. 2020 values plotted in bold red color, and 2015-2019 values plotted in light grey-red shades.", size(tiny))



























