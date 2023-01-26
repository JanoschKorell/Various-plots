

/*
keep v62 v1
rename v62 Gini
rename v1 cntry
drop if Gini == .
drop if Gini == 2017
*/

*https://worldpopulationreview.com/country-rankings/crime-rate-by-country

clear

capture log close
cd $data
log using $lofi/CircularBar, replace
set more off, perm
numlabel _all, add force


import delimited  Makros/gdp.csv,  clear

keep if year == 2020
encode code, gen(Code)
drop  if Code ==.
drop  if Code == 126
rename  gdppercapitapppconstant2017inter gdp
rename entity location
gsort gdp


save gdpdata.dta, replace



//Kontinente


clear

import delim using "https://covid.ourworldindata.org/data/owid-covid-data.csv", clear
gen date2 = date(date, "YMD")
format date2 %tdDD-Mon-yy
drop date
ren date2 date
gen date2 = date
order date date2
keep date continent location new_* total*

// clean up some 

drop if continent==""
replace location = "Bonaire Sint Eustatius" if location =="Bonaire Sint Eustatius and Saba"
replace location = "Bosnia & Herzeg." if location =="Bosnia and Herzegovina"
replace location = "Turks & Caicos Is." if location =="Turks and Caicos Islands"


encode location, gen(Location)
egen tag = tag(Location)
keep if tag == 1
keep continent location

compress  
save owidKonti.dta, replace




use owidKonti.dta, clear
merge m:m location using gdpdata
keep if _merge == 3
drop  _merge

encode continent, gen(Kontinent)

replace location  = "Grenadines" if location == "Saint Vincent and the Grenadines"
replace location  = "Kongo" if location == "Democratic Republic of Congo"
replace location  = "CAR" if location == "Central African Republic"
replace location  = "Sao Tome/Principe" if location == "Sao Tome and Principe"

sort Kontinent gdp

// points in the circle


cap drop angle
gen double angle = _n * 2 * _pi / _N 

summ gdp, d
global circ = `r(p99)'

//Kreis

gen double xcir = ($circ * cos(angle))
gen double ycir = ($circ * sin(angle))

// height of bars
gen double xval = ((gdp + $circ ) * cos(angle)) 
gen double yval = ((gdp + $circ ) * sin(angle))


//Anpassung

summ xval
local xmax = `r(max)'
local xmin = `r(min)'
  
summ yval
local ymax = `r(max)'
local ymin = `r(min)'
 
global edge = max(`xmax',`ymax', abs(`xmin'), abs(`ymin')) * 1.1


//Labels


cap drop xlab ylab

gen xlab = ((gdp + $circ * 1.3) * cos(angle)) 
gen ylab = ((gdp + $circ * 1.3) * sin(angle))


cap drop mylab
gen mylab = location + " (" + string(gdp, "%8.0f") + ")" 

//Labels vertikal

  
cap drop quad
gen quad = .  // quadrants
replace quad = 1 if xcir >= 0 & ycir >= 0 
replace quad = 2 if xcir <= 0 & ycir >= 0   
replace quad = 3 if xcir <= 0 & ycir <= 0
replace quad = 4 if xcir >= 0 & ycir <= 0
  
  
  
cap drop angle2 
gen double angle2 = .
replace angle2 = (angle  * (180 / _pi)) - 180 if angle >  _pi & !inlist(quad,2,4)
replace angle2 = (angle  * (180 / _pi))       if angle <= _pi & !inlist(quad,2,4)
replace angle2 = (angle  * (180 / _pi)) - 180 if angle <= _pi & quad==2
replace angle2 = (angle  * (180 / _pi))       if angle >  _pi & quad==4


// tag each continent value
  

cap drop tag
egen tag = tag(continent)
recode tag (0=.)
  
  
// generate the variables
 
 

cap drop *cont
gen double xcont     = .
gen double ycont     = .
gen double anglecont = .
 
 
// generate the angles
 
 
levelsof continent if tag==1, local(lvls)
 
foreach x of local lvls {
 
qui summ angle if continent== "`x'"
 
 
replace anglecont = (`r(max)' + `r(min)') / 2 if tag==1 & continent== "`x'"
 
replace xcont = ($circ * 0.9 * cos(anglecont)) if tag==1 & continent== "`x'"
 
replace ycont = ($circ * 0.9 * sin(anglecont)) if tag==1 & continent== "`x'"


}


replace anglecont = (anglecont  * (180 / _pi)) - 90  if tag==1





 
*************************
**     Final graph     **
*************************

cd $grafi/CircularBar



// spikes

local cont
local i
levelsof continent, local(lvls)  
local items = `r(r)'
local i = 1

foreach x of local lvls {

colorpalette w3, n("`items'") nograph
 
local cont `cont' (pcspike yval xval ycir xcir if continent=="`x'", lc("`r(p`i')'") lw(0.5)) ||  
 
local ++i
}

// markers  
  
local labs2
qui levelsof mylab , local(lvls)  //

foreach x of local lvls {

qui summ angle2 if mylab== "`x'" 
 
local labs2 `labs2' (scatter ylab xlab if mylab== "`x'"  , mc(none) mlabel(mylab) mlabangle(`r(mean)')  mlabpos(0) mlabcolor() mlabsize(1))  
}  

// continentslocal labcont

levelsof continent if tag==1, local(lvls)

foreach x of local lvls {

qui summ anglecont if continent== "`x'" & tag==1, meanonly
 
local labcont `labcont' (scatter ycont xcont if continent== "`x'" & tag==1, mc(none) mlabel(continent) mlabangle(`r(mean)')  mlabpos(0) mlabcolor(black) mlabsize(1.2))  ||
 
}  
  


 
// graph

twoway ///
`cont' ///
`labs2' ///
`labcont' ///
, ///
xlabel(-$edge $edge, nogrid) ///
ylabel(-$edge $edge, nogrid) ///
legend(off) ///
aspect(1) xsize(1) ysize(1) ///
yscale(off) xscale(off) ///
text(15 0 "GDP per capita", size(2.5) box just(center) margin(t+2 b+2) fcolor(none) lw(none) color()) ///
text(-10 0 "All over the world", size(1.5) box just(center) margin(t+10 b+2) fcolor(none) lw(none) color()) ///
note("Source: Worldpopulationreview (Not all countries are represented)", size(1.2))
graph export "CircularBar - GDP per capita.jpg", replace as(png) width(4600)



















  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  












/*



clear

import delim using "https://covid.ourworldindata.org/data/owid-covid-data.csv", clear
gen date2 = date(date, "YMD")
format date2 %tdDD-Mon-yy
drop date
ren date2 date
gen date2 = date
order date date2
keep date continent location new_* total*

// clean up some 

drop if continent==""
replace location = "Bonaire Sint Eustatius" if location =="Bonaire Sint Eustatius and Saba"
replace location = "Bosnia & Herzeg." if location =="Bosnia and Herzegovina"
replace location = "Turks & Caicos Is." if location =="Turks and Caicos Islands"



compress  
save owid.dta, replace




use owid.dta, clear

sort continent location date

by continent location: gen double newcases  = total_cases  - total_cases[_n-7]
by continent location: gen double newdeaths = total_deaths - total_deaths[_n-7]
by continent location: gen double newcases_100k  = total_cases_per_million  - total_cases_per_million[_n-7]
by continent location: gen double newdeaths_100k = total_deaths_per_million - total_deaths_per_million[_n-7]




// keep only what we need

summ date
keep if date == `r(max)' - 1 
keep date continent location newcases* newdeaths*


drop if newdeaths_100k < 1
sort continent newdeaths_100k
cap drop angle
gen double angle = _n * 2 * _pi / _N 

summ newdeaths_100k, d
global circ = `r(p99)'



// points in the circle

gen double xcir = ($circ * cos(angle))
gen double ycir = ($circ * sin(angle))

// height of bars
gen double xval = ((newdeaths_100k + $circ ) * cos(angle)) 
gen double yval = ((newdeaths_100k + $circ ) * sin(angle))




twoway ///
 (scatter yval xval) ///
 (scatter ycir xcir) ///
  , aspect(1) legend(off)



twoway ///
 (pcspike yval xval ycir xcir, lw(0.6)) ///  
  , aspect(1) legend(off)


summ xval
 local xmax = `r(max)'
 local xmin = `r(min)'
  
summ yval
 local ymax = `r(max)'
 local ymin = `r(min)'
 
 global edge = max(`xmax',`ymax', abs(`xmin'), abs(`ymin')) * 1.1


 
 twoway ///
 (pcspike yval xval ycir xcir, lw(0.5) ) ///  
  , ///
  xlabel(-$edge $edge) ///
  ylabel(-$edge $edge) ///
  aspect(1)


// add the colors by continents

local cont
local i

levelsof continent, local(lvls)  
local items = `r(r)'
local i = 1


foreach x of local lvls {

 colorpalette w3, n("`items'") nograph 
 
 local cont `cont' (pcspike yval xval ycir xcir if continent=="`x'", lc("`r(p`i')'") lw(0.5)) ||  
 local ++i 
 
}

twoway ///
`cont' ///  
, ///
xlabel(-$edge $edge) ///
ylabel(-$edge $edge) ///
aspect(1) legend(off)



cap drop xlab ylab

gen xlab = ((newdeaths_100k + $circ * 1.3) * cos(angle)) 
gen ylab = ((newdeaths_100k + $circ * 1.3) * sin(angle))


cap drop mylab
gen mylab = location + " (" + string(newdeaths_100k, "%8.0f") + ")" if newdeaths_100k >= 10



twoway ///
 (pcspike yval xval ycir xcir, lw(0.5) ) ///  
 (scatter ylab xlab, mlab(mylab) mlabsize(1) mlabpos(0) ms(none)) ///
  , ///
  xlabel(-$edge $edge) ///
  ylabel(-$edge $edge) ///
  aspect(1) legend(off)

  
  
  
cap drop quad
gen quad = .  // quadrants
 replace quad = 1 if xcir >= 0 & ycir >= 0 
 replace quad = 2 if xcir <= 0 & ycir >= 0   
 replace quad = 3 if xcir <= 0 & ycir <= 0
 replace quad = 4 if xcir >= 0 & ycir <= 0
  
  
  
  
cap drop angle2 
gen double angle2 = .
 replace angle2 = (angle  * (180 / _pi)) - 180 if angle >  _pi & !inlist(quad,2,4)
 replace angle2 = (angle  * (180 / _pi))       if angle <= _pi & !inlist(quad,2,4)
 replace angle2 = (angle  * (180 / _pi)) - 180 if angle <= _pi & quad==2
 replace angle2 = (angle  * (180 / _pi))       if angle >  _pi & quad==4
  
  
local labs2
qui levelsof mylab , local(lvls)  //
  
foreach x of local lvls {
 
 qui summ angle2 if mylab== "`x'" 
 
 local labs2 `labs2' (scatter ylab xlab if mylab== "`x'"  , mc(none) ///
 mlabel(mylab) mlabangle(`r(mean)')  mlabpos(0) mlabcolor() ///
 mlabsize(1))  
} 
  
twoway ///
 (pcspike yval xval ycir xcir, lw(0.5) ) ///  
 `labs2' ///
  , ///
  xlabel(-$edge $edge) ///
  ylabel(-$edge $edge) ///
  aspect(1) legend(off)
  
  


  
// labels 
local labs2
  
qui levelsof mylab , local(lvls)  //
  
foreach x of local lvls {
  
qui summ angle2 if mylab== "`x'" 
  
local labs2 `labs2' (scatter ylab xlab if mylab== "`x'"  , mc(none) ///
mlabel(mylab) mlabangle(`r(mean)')  mlabpos(0) mlabcolor() mlabsize(1))  
}
  
 // continent colors
  
local cont
local i 
  
levelsof continent, local(lvls)  
local items = `r(r)'
local i = 1
  
foreach x of local lvls {
  
colorpalette w3, n("`items'") nograph 

local cont `cont' (pcspike yval xval ycir xcir if continent=="`x'",  lc("`r(p`i')'") lw(0.5)) || 

local ++i
}
  
  
// plot the graph
  
  
twoway ///
`cont' ///  
`labs2' ///
, ///
xlabel(-$edge $edge) ///
ylabel(-$edge $edge) ///
aspect(1) legend(off)
  
 
 
// tag each continent value
  

cap drop tag
egen tag = tag(continent)
recode tag (0=.)
  
  
// generate the variables
 
 

cap drop *cont
gen double xcont     = .
gen double ycont     = .
gen double anglecont = .
 
 
// generate the angles
 
 
levelsof continent if tag==1, local(lvls)
 
foreach x of local lvls {
 
qui summ angle if continent== "`x'"
 
 
replace anglecont = (`r(max)' + `r(min)') / 2 if tag==1 & continent== "`x'"
 
replace xcont = ($circ * 0.9 * cos(anglecont)) if tag==1 & continent== "`x'"
 
replace ycont = ($circ * 0.9 * sin(anglecont)) if tag==1 & continent== "`x'"


}



replace anglecont = (anglecont  * (180 / _pi)) - 90  if tag==1


local labcont

levelsof continent if tag==1, local(lvls)


foreach x of local lvls {

summ anglecont if continent== "`x'" & tag==1, meanonly


local labcont `labcont' (scatter ycont xcont if continent== "`x'" & tag==1, mc(none) mlabel(continent) mlabangle(`r(mean)')  mlabpos(0) mlabcolor(black) mlabsize(1.8))  ||


} 



twoway ///
  (pcspike yval xval ycir xcir, lw(0.5) ) ///  
 `labcont' ///
  , ///
  xlabel(-$edge $edge) ///
  ylabel(-$edge $edge) ///
  aspect(1)  legend(off)

  
  
// spikes
  
  
local cont
local i
  

levelsof continent, local(lvls)  
local items = `r(r)'
local i = 1
  
  
foreach x of local lvls {
 colorpalette w3, n("`items'") nograph
 local cont `cont' (pcspike yval xval ycir xcir if continent=="`x'", lc("`r(p`i')'") lw(0.5)) ||  
 local ++i
}
  
  
 // markers  
  
  
local labs2
qui levelsof mylab , local(lvls)  //
  
  
foreach x of local lvls {
 qui summ angle2 if mylab== "`x'" 
 local labs2 `labs2' (scatter ylab xlab if mylab== "`x'"  , mc(none) mlabel(mylab) mlabangle(`r(mean)')  mlabpos(0) mlabcolor() mlabsize(1))  
}  
  
  
// continents
  
  
local labcont
levelsof continent if tag==1, local(lvls)
  
  
foreach x of local lvls {
 qui summ anglecont if continent== "`x'" & tag==1, meanonly
 local labcont `labcont' (scatter ycont xcont if continent== "`x'" & tag==1, mc(none) mlabel(continent) mlabangle(`r(mean)')  mlabpos(0) mlabcolor(black) mlabsize(1.8))  ||
 
}
  
  
twoway ///
 `cont' ///
 `labs2' ///
 `labcont' ///
  , ///
  xlabel(-$edge $edge) ///
  ylabel(-$edge $edge) ///
  aspect(1) legend(off)
  
  
*************************
**     Final graph     **
*************************


// spikes

local cont
local i
levelsof continent, local(lvls)  
local items = `r(r)'
local i = 1

foreach x of local lvls {

colorpalette w3, n("`items'") nograph
 
local cont `cont' (pcspike yval xval ycir xcir if continent=="`x'", lc("`r(p`i')'") lw(0.5)) ||  
 
local ++i
}

// markers  
  
local labs2
qui levelsof mylab , local(lvls)  //

foreach x of local lvls {

qui summ angle2 if mylab== "`x'" 
 
local labs2 `labs2' (scatter ylab xlab if mylab== "`x'"  , mc(none) mlabel(mylab) mlabangle(`r(mean)')  mlabpos(0) mlabcolor() mlabsize(1))  
}  

// continentslocal labcont

levelsof continent if tag==1, local(lvls)

foreach x of local lvls {

qui summ anglecont if continent== "`x'" & tag==1, meanonly
 
local labcont `labcont' (scatter ycont xcont if continent== "`x'" & tag==1, mc(none) mlabel(continent) mlabangle(`r(mean)')  mlabpos(0) mlabcolor(black) mlabsize(1.2))  ||
 
}  
  
// date 
summ date
local date = r(max)
local date : di %tdDD_Mon_yy `date'
 
 
 
 
// graph

twoway ///
 `cont' ///
 `labs2' ///
 `labcont' ///
  , ///
  xlabel(-$edge $edge, nogrid) ///
  ylabel(-$edge $edge, nogrid) ///
  legend(off) ///
  aspect(1) xsize(1) ysize(1) ///
  yscale(off) xscale(off) ///
  text( 15 0 "{fontface Merriweather Bold:COVID-19}", size(2.5) box just(center) margin(t+2 b+2) fcolor(none) lw(none) color()) ///
  text(-10 0 "deaths per one million pop" "in the past 7 days", size(1.5) box just(center) margin(t+2 b+2) fcolor(none) lw(none) color()) ///
  text(-30 0 "(`date')", size(1.1) box just(center) margin(t+2 b+2) fcolor(none) lw(none) color()) ///
  note("Source: Our World in Data. Countries with no reported deaths are dropped from the graph. Only countries with over 10 deaths are labeled.", size(1.2))
  
*/
