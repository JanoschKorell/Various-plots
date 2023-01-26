


	
	
	
clear

capture log close
cd $data/ESS
log using $lofi/WafflePlots, replace
set more off, perm
numlabel _all, add force


use ESS9,clear


sort cntbrthd

gen borncntry1 =.
tostring borncntry1, gen(borncntry)
drop borncntry1
replace cntbrthd = "DE" if cntbrthd == "1000"



levelsof cntry, local(lvls)

foreach x of local lvls {

replace borncntry = "`x'" if cntbrthd == "`x'"

}

encode borncntry, gen(borncntry1)
drop borncntry
ren borncntry1 borncntry
drop if borncntry == 1




encode cntry, gen(Land)


gen check = .

levelsof cntry, local(lvls)

foreach x of local lvls {

replace check = 1  if cntbrthd != "`x'" & cntry == "`x'"
}

drop if check ==.

order borncntry Land check

collapse (sum) check, by(borncntry Land) 


gen from = 0
gen to = 1

decode borncntry, gen(borncntry1)
decode Land, gen(Land1)

drop Land
ren Land1 Land
drop borncntry
ren borncntry1 borncntry






ren from        x1
ren borncntry      lab1

ren to          x2
ren Land lab2


ren check  val1
gen val2 = val1


gen id = _n
order id

// Gruppierung

egen grp1 = group(x1 lab1)  // draw order
egen grp2 = group(x1 lab2)


//x und y

cap drop y1 
cap drop y2

sort x1 grp1 grp2
by x1 : gen y1 = sum(val1)


sort x2 grp2 grp1
by x2 : gen y2 = sum(val2)

sort lab1

  
  

// Long format wegen gleicher Farbe

sort x1 lab1 lab2
gen layer = x1 + 1

reshape long x val lab grp y , i(id layer) j(tt)

drop tt // just a dummy variable we don't need


order grp id lab x  
sort id x lab







//Modifikation für rareas (brauch eine "Breite")

cap drop y1 
cap drop y2

sort layer x y

by layer x: gen y1 = y[_n-1]
recode y1 (.=0)
gen y2 = y
drop y


order layer grp id lab x y1 y2 val










*** transform the groups to be at the mid points

//Ausgänge feststellen und zentrieren. Nur wichtig bei mehr als zwei Zeitpunkten

sort x id y1 y2

cap drop y1t
cap drop y2t

gen y1t = .
gen y2t = .

levelsof layer
local tlayers = `r(r)' - 1  // drop one layer


forval i = 1/`tlayers' {

local left  = `i' 
local right = `i' + 1

display "Layer: `i', Left x: `left', Right x = `right'"

levelsof lab if layer==`left', local(lleft)  
levelsof lab if layer==`right', local(lright) 

foreach y of local lleft {     // left
  foreach x of local lright {  // right

	if "`x'" == "`y'" {  // check if the groups are equal

		display "`x'"   // just for checking


	** next part gets the ranges of the in and out layers


	// "in" data layer range 
		summ y1 if lab=="`x'" & layer==`left' & x==`left'  

		local y1max `r(max)'
		local y1min `r(min)'

		summ y2 if lab=="`x'" & layer==`left' & x==`left'  

		local y2max `r(max)'
		local y2min `r(min)' 
		
		local l1max = max(`y1max',`y2max')
		local l1min = min(`y1min',`y2min')
		
	// "out" data layer range  
		

		summ y1 if lab=="`x'" & layer==`right' & x==`left' 
		local y1max `r(max)'
		local y1min `r(min)'
		
		
		summ y2 if lab=="`x'" & layer==`right' & x==`left' 
		local y2max `r(max)'
		local y2min `r(min)' 
		

		
	// get the bounds
		
		
		local l2max = max(`y1max',`y2max') 
		local l2min = min(`y1min',`y2min')  
		
		
	// calculate the displacement 
		
		
		local displace = ((`l1max' - `l1min') - (`l2max' - `l2min')) / 2
		
		
	// displace the top and bottom parts
		
		replace y1t = y1 + `displace' + `l1min' - `l2min' if layer==`right' & lab=="`x'" & x==`left'  
		
		replace y2t = y2 + `displace' + `l1min' - `l2min' if layer==`right' & lab=="`x'" & x==`left' 
		
   }
  }
 } 
}




	
// the bottom layers are not displaced

replace y1t = y1 if y1t==.
replace y2t = y2 if y2t==.


drop y1 y2

ren y1t y1 
ren y2t y2





*** generate offset between categories

//Abstände zwischen Kategorien

sort x y1

cap drop tag*
encode lab, gen(order)

cap drop offset
bysort x: gen offset = (order - 1) * 200 // 200 is arbitrary

replace y1 = y1 + offset
replace y2 = y2 + offset

*cap drop tag 

cap drop offset




//S-Kurve


local newobs = 30 // higher the value, the smoother the curve
 
expand `newobs'

sort id x



local newobs = 30 
cap drop xtemp
bysort id: gen xtemp =  (_n / (`newobs' * 2))

cap drop ytemp
gen ytemp =  (1 / (1 + (xtemp / (1 - xtemp))^-3))


gen y1temp = .
gen y2temp = .








*** run the loop here

levelsof layer, local(cuts)
display `cuts'

levelsof id, local(lvls)

foreach x of local lvls {   // each id is looped over
foreach y of local cuts {

display "ID = `x', cut = `y'"


summ ytemp if id==`x' & layer==`y'
 if `r(N)' > 0 {
  local ymin = `r(min)' 
  local ymax = `r(max)'
  } 
  else {
   local ymin = 0
   local ymax = 0
   }

sum x if layer==`y'
 local x0 = `r(min)'
 local x1 = `r(max)'

// first part


display "Left side"


 summ y1 if id==`x' & x==`x0' & layer==`y'
 if `r(N)' > 0 {
  local y1min = `r(min)'
  }
  else {
   local y1min = 0
   }
   
 summ y1 if id==`x' & x==`x1' & layer==`y'
 if `r(N)' > 0 {
  local y1max = `r(max)'
  }
  else {
   local y1max = 0 
   }
 
 
 display "Left side values"
 replace y1temp = (`y1max' - `y1min') * (ytemp - `ymin') / (`ymax' - `ymin') + `y1min' if id==`x' & layer==`y'

	
// second part
	
	
display "Right side"
	

	
summ y2 if id==`x' & x==`x0' & layer==`y'
 if `r(N)' > 0 {
  local y2min = `r(min)'
  }
  else {
   local y2min = 0
   }
	
	
	

summ y2 if id==`x' & x==`x1' & layer==`y'
 if `r(N)' > 0 {
  local y2max = `r(max)'
  }
  else {
   local y2max = 0.00001 // to avoid division by zero
   }
	
	
	
 display "Right side values"
 replace y2temp = (`y2max' - `y2min') * (ytemp - `ymin') / (`ymax' - `ymin') + `y2min' if id==`x' & layer==`y'
	
	
	
}
}
	
	
replace xtemp = xtemp + layer - 1
	
	

	
// Labels and Values
	
//Mid point für labels
	
egen tag = tag(x order)
	
cap gen midy = .
	
	
	
levelsof x, local(lvls)

foreach x of local lvls {
	
levelsof order if x ==`x', local(odrs)
	
foreach y of local odrs {
	
	
 summ y1 if x==`x' & order==`y'
 local min = `r(min)'
	
 summ y2 if x==`x' & order==`y'
 local max = `r(max)'

 
 
 
 replace midy = (`min' + `max') / 2 if tag==1 & x==`x' & order==`y'
 
 }
}
	

	
	
	
//Mid point für values
	
	
egen tagp = tag(id) 

cap drop midp
cap gen midp = .
	
	
levelsof id, local(lvls)

foreach x of local lvls {
	
qui summ x if id==`x'
local xval = `r(min)'
	
qui summ y1 if id==`x' & x==`xval' 
local min = `r(min)'
	
qui summ y2 if id==`x'  & x==`xval' 
local max = `r(max)'
	
local test = (`min' + `max') / 2
replace midp = (`min' + `max') / 2 if id==`x' & tagp==1

	
}
	
	

	
	
sort layer grp x y1 y2

cap drop ymin ymax

*cap drop tag


bysort x order: egen ymin = min(y1)
bysort x order: egen ymax = max(y2)
   
egen wedge = group(x order)
	
	
// Automatisieren für die Farbe


egen tagw = tag(wedge)
	
local boxes
	
levelsof wedge, local(lvls)
local items = `r(r)'

foreach x of local lvls {
	
qui summ order if wedge==`x'
local clr = `r(mean)'
	
	
colorpalette HCL dark, n(`items') intensity(0.8) reverse nograph  // intensity adds white
	
	
local boxes `boxes' (rspike ymin ymax x if wedge==`x' & tagw==1, lcolor("`r(p`clr')'%100") lw(3.2)) ||
	
}




/// Vorarbeit

gen xLab = x
gen xVal = x

replace xLab = x - 0.06 if x == 0
replace xLab = x + 0.06 if x == 1

replace xVal = x - 0.05 if x == 0
replace xVal = . if x == 1


sort midp val

egen midp2 = total(val) if midp !=., by(order)





// Plot



cd $grafi/Sankey



local boxes
	
levelsof wedge, local(lvls)
local items = `r(r)'
	
foreach x of local lvls {
	
qui summ order if wedge==`x'
local clr = `r(mean)'
	
colorpalette HCL intense, n(`items') intensity(0.8) reverse nograph 
	
local boxes `boxes' (rspike ymin ymax x if wedge==`x' & tagw==1, lcolor("`r(p`clr')'%100") lw(3.2)) ||
	
}	



sort layer x order xtemp y1temp y2temp

levelsof wedge
local groups = `r(r)' 

local shapes

levelsof id, local(lvls)

foreach x of local lvls {

qui sum x if id==`x' 
qui summ order if id==`x' & x == `r(min)'

if `r(N)' > 0 {
local clr = `r(mean)'
colorpalette HCL intense, n(`groups') reverse nograph


local shapes `shapes' (rarea y1temp y2temp xtemp if id==`x', lc(white) lw(none) fi(100) fcolor("`r(p`clr')'%75"))  ||
	
	
 }
} 
  
// final graph here
	
	
twoway ///
`shapes' ///
`boxes' ///
(scatter midy xVal if tag==1, msymbol(none) mlabel(midp2) mlabgap(1.2) mlabsize(1.3) mlabpos(3) mlabcolor(white)) ///
(scatter midy xLab if tag==1, msymbol(none) mlabel(lab) mlabsize(1.6) mlabpos(0) mlabangle(vertical) mlabcolor(white)) ///
, ///
legend(off) ///
xlabel(, nogrid) ylabel(, nogrid)     ///
xscale(off) yscale(off)  ///
title("Migration in Europa nach dem ESS9", color(white)) ///
subtitle("Links: Land der Geburt / Rechts: Land zum Zeitpunkt der Befragung", color(white) size(vsmall)) ///
graphregion(fcolor(black) lc(black) lw(thick)) plotregion(fcolor(black) lc(black) lw(thick)) bgcolor(black)
graph export "Sankey - Migration in Europa nach dem ESS9.jpg", replace as(png) width(4600)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
/*




clear

capture log close
cd $data
log using $lofi/WafflePlots, replace
set more off, perm
numlabel _all, add force


use network/network_data.dta, clear



ren from        x1
ren source      lab1

ren to          x2
ren destination lab2


ren value  val1
gen val2 = val1


sort x1 lab1 lab2

gen id = _n
order id


egen grp1 = group(x1 lab1)  // draw order
egen grp2 = group(x1 lab2)


cap drop y1 
cap drop y2

sort x1 grp1 grp2
by x1 : gen y1 = sum(val1)


sort x2 grp2 grp1
by x2 : gen y2 = sum(val2)

sort lab1



twoway ///
 (pcspike y1 x1 y2 x2 if grp1==1) ///
 (pcspike y1 x1 y2 x2 if grp1==2) ///
 (pcspike y1 x1 y2 x2 if grp1==3) ///
 (pcspike y1 x1 y2 x2 if grp1==4) ///
 (pcspike y1 x1 y2 x2 if grp1==5) ///
 (pcspike y1 x1 y2 x2 if grp1==6) ///
  , legend(off)


  
  
local lines  
levelsof grp1, local(lvls)


foreach x of local lvls {
local lines `lines' (pcspike y1 x1 y2 x2 if grp1==`x') ||
 }

twoway ///
`lines' ///
(scatter y1 x1, mlab(lab1) mlabs(vsmall) mc(black) mlabpos(3)) ///
(scatter y2 x2, mlab(lab2) mlabs(vsmall) mc(black) mlabpos(9)) ///
, legend(off)








sort x1 lab1 lab2
gen layer = x1 + 1

reshape long x val lab grp y , i(id layer) j(tt)

drop tt // just a dummy variable we don't need


order grp id lab x  
sort id x lab






local lines  
levelsof grp, local(lvls)


foreach x of local lvls {
local lines `lines' (scatter y x if grp==`x', mlabel(lab) mlabpos(3)) ||
 }


twoway ///
`lines' ///
, legend(off)



cap drop y1 
cap drop y2

sort layer x y

by layer x: gen y1 = y[_n-1]
recode y1 (.=0)
gen y2 = y
drop y


order layer grp id lab x y1 y2 val








local areas

levelsof id, local(lvls)
foreach x of local lvls {
 local areas `areas' (rarea y1 y2 x if id==`x', fc(%20)) ||
}

twoway ///
`areas' ///
, ///
legend(off) ///
xline(  `r(levels)', lp(solid) lw(vthin)) ///
xlabel(, nogrid)    ///
xscale(off) yscale(off)


*** transform the groups to be at the mid points

sort x id y1 y2

cap drop y1t
cap drop y2t

gen y1t = .
gen y2t = .

levelsof layer
local tlayers = `r(r)' - 1  // drop one layer


forval i = 1/`tlayers' {

local left  = `i' 
local right = `i' + 1

display "Layer: `i', Left x: `left', Right x = `right'"

levelsof lab if layer==`left', local(lleft)  
levelsof lab if layer==`right', local(lright) 

foreach y of local lleft {     // left
  foreach x of local lright {  // right

if "`x'" == "`y'" {  // check if the groups are equal

	display "`x'"   // just for checking


** next part gets the ranges of the in and out layers


// "in" data layer range 
	summ y1 if lab=="`x'" & layer==`left' & x==`left'  

	local y1max `r(max)'
    local y1min `r(min)'

summ y2 if lab=="`x'" & layer==`left' & x==`left'  

    local y2max `r(max)'
    local y2min `r(min)' 
	
	local l1max = max(`y1max',`y2max')
    local l1min = min(`y1min',`y2min')
	
// "out" data layer range  
	

summ y1 if lab=="`x'" & layer==`right' & x==`left' 
    local y1max `r(max)'
    local y1min `r(min)'
	
	
summ y2 if lab=="`x'" & layer==`right' & x==`left' 
    local y2max `r(max)'
    local y2min `r(min)' 
	

	
// get the bounds
	
	
	local l2max = max(`y1max',`y2max') 
	local l2min = min(`y1min',`y2min')  
	
	
// calculate the displacement 
	
	
local displace = ((`l1max' - `l1min') - (`l2max' - `l2min')) / 2
	
	
// displace the top and bottom parts
	
replace y1t = y1 + `displace' + `l1min' - `l2min' if layer==`right' & lab=="`x'" & x==`left'  
	
replace y2t = y2 + `displace' + `l1min' - `l2min' if layer==`right' & lab=="`x'" & x==`left' 
	
   }
  }
 } 
}




	
// the bottom layers are not displaced

replace y1t = y1 if y1t==.
replace y2t = y2 if y2t==.


local areas

levelsof id, local(lvls)
foreach x of local lvls {
 local areas `areas' (rarea y1t y2t x if id==`x', fc(%20)) ||
}

levelsof x 

twoway ///
`areas' ///
(scatter y1 x, mlabel(lab) mlabpos(3) mlabcolor(black) mlabsize(vsmall)) ///
(scatter y2 x, mlabel(lab) mlabpos(3) mlabcolor(black) mlabsize(vsmall)) ///
, ///
legend(off) ///
xline(`r(levels)', lp(solid) lw(vthin)) ///
xlabel(, nogrid)    ///
xscale(off) yscale(off)



drop y1 y2

ren y1t y1 
ren y2t y2


*** generate offset between categories

sort x y1

cap drop tag*
encode lab, gen(order)

cap drop offset
bysort x: gen offset = (order - 1) * 200 // 200 is arbitrary

replace y1 = y1 + offset
replace y2 = y2 + offset

*cap drop tag 

cap drop offset





local areas 

levelsof id, local(lvls)
foreach x of local lvls {
 local areas `areas' (rarea y1 y2 x if id==`x', fc(%20)) ||
}


levelsof x 

twoway ///
`areas' ///
, ///
legend(off) ///
xline(`r(levels)', lp(solid) lw(vthin)) ///
xlabel(, nogrid)    ///
xscale(off) yscale(off)





local shapes


levelsof order
local groups = `r(r)'



summ x
local cuts = `r(max)' - 1
display `cuts'


levelsof id, local(lvls)

forval y = 0/`cuts' {
 foreach x of local lvls {


qui summ order if id==`x' & x==`y'


	if `r(N)' > 0  {

	display "Cut: `y', ID: `x', Value = `r(mean)'"

	local clr = `r(mean)'

	colorpalette tableau, n(`groups') nograph

local shapes `shapes' (rarea y1 y2 x if id==`x', lc(gs6) lw(0.06) fi(100) fcolor("`r(p`clr')'%40"))  ||


  }
 
 } 
}



levelsof x 
 
twoway ///
`shapes' ///
, ///
legend(off) ///
xline(`r(levels)', lp(solid) lw(vthin)) ///
xlabel(, nogrid)    ///
xscale(off) yscale(off)



local newobs = 30 // higher the value, the smoother the curve
 
expand `newobs'

sort id x



local newobs = 30 
cap drop xtemp
bysort id: gen xtemp =  (_n / (`newobs' * 2))

cap drop ytemp
gen ytemp =  (1 / (1 + (xtemp / (1 - xtemp))^-3))









gen y1temp = .
gen y2temp = .



*** run the loop here

levelsof layer, local(cuts)
display `cuts'

levelsof id, local(lvls)

foreach x of local lvls {   // each id is looped over
foreach y of local cuts {

display "ID = `x', cut = `y'"


summ ytemp if id==`x' & layer==`y'
 if `r(N)' > 0 {
  local ymin = `r(min)' 
  local ymax = `r(max)'
  } 
  else {
   local ymin = 0
   local ymax = 0
   }

sum x if layer==`y'
 local x0 = `r(min)'
 local x1 = `r(max)'

// first part


display "Left side"


 summ y1 if id==`x' & x==`x0' & layer==`y'
 if `r(N)' > 0 {
  local y1min = `r(min)'
  }
  else {
   local y1min = 0
   }
   
 summ y1 if id==`x' & x==`x1' & layer==`y'
 if `r(N)' > 0 {
  local y1max = `r(max)'
  }
  else {
   local y1max = 0 
   }
 
 
 display "Left side values"
 replace y1temp = (`y1max' - `y1min') * (ytemp - `ymin') / (`ymax' - `ymin') + `y1min' if id==`x' & layer==`y'

	
// second part
	
	
display "Right side"
	

	
summ y2 if id==`x' & x==`x0' & layer==`y'
 if `r(N)' > 0 {
  local y2min = `r(min)'
  }
  else {
   local y2min = 0
   }
	
	
	

summ y2 if id==`x' & x==`x1' & layer==`y'
 if `r(N)' > 0 {
  local y2max = `r(max)'
  }
  else {
   local y2max = 0.00001 // to avoid division by zero
   }
	
	
	
 display "Right side values"
 replace y2temp = (`y2max' - `y2min') * (ytemp - `ymin') / (`ymax' - `ymin') + `y2min' if id==`x' & layer==`y'
	
	
	
}
}
	
	
replace xtemp = xtemp + layer - 1
	
	

	
	
	
	
	
levelsof order
local groups = `r(r)' 
	
local shapes 
	
levelsof id, local(lvls)
	
foreach x of local lvls {
	
qui summ grp if id==`x'
	
if `r(N)' > 0 {
	
local clr = `r(mean)'
	
 colorpalette tableau, n(`groups') nograph
 local shapes `shapes' (rarea y1temp y2temp xtemp if id==`x', lc(gs6) lw(0.06) fi(100) fcolor("`r(p`clr')'%40"))  ||
 }
}
	
	

	
levelsof x 
	
twoway ///
`shapes' ///
, ///
legend(off) ///
xline(`r(levels)', lp(solid) lw(vthin)) ///
xlabel(, nogrid)    ///
xscale(off) yscale(off)
	
	
	
egen tag = tag(x order)
	
cap gen midy = .
	
levelsof x, local(lvls)
foreach x of local lvls {
	
levelsof order if x ==`x', local(odrs)
	
foreach y of local odrs {
	
	
 summ y1 if x==`x' & order==`y'
 local min = `r(min)'
	
 summ y2 if x==`x' & order==`y'
 local max = `r(max)'

 
 
 
 replace midy = (`min' + `max') / 2 if tag==1 & x==`x' & order==`y'
 
 }
}
	

	
	
	
	
	
	
egen tagp = tag(id)
	

cap drop midp
cap gen midp = .
	
	
levelsof id, local(lvls)
foreach x of local lvls {
	
qui summ x if id==`x'
local xval = `r(min)'
	
qui summ y1 if id==`x' & x==`xval' 
local min = `r(min)'
	
qui summ y2 if id==`x'  & x==`xval' 
local max = `r(max)'
	
local test = (`min' + `max') / 2
replace midp = (`min' + `max') / 2 if id==`x' & tagp==1
	
}
	
	
//Value Check


twoway ///
(scatter midp x, mlabel(val) mlabsize(1.6) mlabpos(3))
	
	

	
	
levelsof order
local groups = `r(r)'
	
	
local shapes 	
	
levelsof id, local(lvls)
	
foreach x of local lvls {
	
	
qui sum x if id==`x'
	
qui summ order if id==`x' & x == `r(min)'
	
	
if `r(N)' > 0 {
	
local clr = `r(mean)'
	
	
colorpalette tableau, n(`groups') nograph
local shapes `shapes' (rarea y1temp y2temp xtemp if id==`x', lc(gs6) lw(0.06) fi(100) fcolor("`r(p`clr')'%40"))  ||
	
	
 }
}
	
	
levelsof x 
	
	
twoway ///
 `shapes' ///
  (rspike y1 y2 x, lcolor(gs14) lwidth(3)) ///
  (scatter midy x if tag==1, msymbol(none) mlabel(lab) mlabsize(1.6) mlabposition(0) mlabangle(vertical)) ///
  , ///
   legend(off) ///
   xline(`r(levels)', lp(solid) lw(vthin)) ///
    xlabel(, nogrid) ylabel(, nogrid)     ///
    xscale(off) yscale(off)	
	
	
	
summ y1 if grp==1 & x==0	
	
local g1min = `r(min)'
local g1max = `r(max)'
	
	
sort layer grp x y1 y2
cap drop ymin ymax
*cap drop tag
bysort x order: egen ymin = min(y1)
bysort x order: egen ymax = max(y2)
   
egen wedge = group(x order)
	
	
// control for the wedges


egen tagw = tag(wedge)
	
local boxes
	
levelsof wedge, local(lvls)
local items = `r(r)'

foreach x of local lvls {
	
qui summ order if wedge==`x'
local clr = `r(mean)'
	
	
colorpalette HCL dark, n(`items') intensity(0.8) reverse nograph  // intensity adds white
	
	
local boxes `boxes' (rspike ymin ymax x if wedge==`x' & tagw==1, lcolor("`r(p`clr')'%100") lw(3.2)) ||
	
	
	
}



local boxes
	
levelsof wedge, local(lvls)
local items = `r(r)'
	
foreach x of local lvls {
	
qui summ order if wedge==`x'
local clr = `r(mean)'
	
colorpalette HCL intense, n(`items') intensity(0.8) reverse nograph 
	
local boxes `boxes' (rspike ymin ymax x if wedge==`x' & tagw==1, lcolor("`r(p`clr')'%100") lw(3.2)) ||
	
}	




*** add the rest


sort layer x order xtemp y1temp y2temp

levelsof wedge
local groups = `r(r)' 

local shapes

levelsof id, local(lvls)

foreach x of local lvls {

qui sum x if id==`x' 
qui summ order if id==`x' & x == `r(min)'

if `r(N)' > 0 {
local clr = `r(mean)'
colorpalette HCL intense, n(`groups') reverse nograph


local shapes `shapes' (rarea y1temp y2temp xtemp if id==`x', lc(white) lw(none) fi(100) fcolor("`r(p`clr')'%75"))  ||
	
	
 }
} 
  
// final graph here
	
	
twoway ///
`shapes' ///
`boxes' ///
(scatter midy x if tag==1, msymbol(none) mlabel(lab) mlabsize(1.6) mlabpos(0) mlabangle(vertical) mlabcolor(black)) ///
(scatter midp x, msymbol(none) mlabel(val) mlabgap(1.2) mlabsize(1.3) mlabpos(3) mlabcolor(black)) ///
, ///
legend(off) ///
xlabel(, nogrid) ylabel(, nogrid)     ///
xscale(off) yscale(off)  ///
title("{fontface Merriweather Bold:A Sankey Diagram in Stata}", color(white)) ///
graphregion(fcolor(black) lc(black) lw(thick)) plotregion(fcolor(black)) bgcolor(black)
	
	
	
