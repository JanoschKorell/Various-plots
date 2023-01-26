




	
	
clear

capture log close
cd $data/ESS
log using $lofi/Sankey, replace
set more off, perm
numlabel _all, add force


use ESS9,clear


sort cntbrthd

gen borncntry1 =.
tostring borncntry1, gen(borncntry)
drop borncntry1

keep cntry borncntry cntbrthd



replace cntbrthd = "DE" if cntbrthd == "1000"
replace cntbrthd = "PL" if cntbrthd == "2000" | cntbrthd == "3000" | cntbrthd == "3000" | cntbrthd == "4000" | cntbrthd == "6000"



levelsof cntry, local(lvls)

foreach x of local lvls {

replace borncntry = "`x'" if cntbrthd == "`x'"

}

encode borncntry, gen(borncntry1)
drop borncntry
ren borncntry1 borncntry
drop if borncntry == 1








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


drop borncntry
gen borncntry = .

replace borncntry = 0 if cntbrthd == "AT"
replace borncntry = 1 if cntbrthd == "BE"
replace borncntry = 2 if cntbrthd == "BG"
replace borncntry = 3 if cntbrthd == "CH"
replace borncntry = 4 if cntbrthd == "CY"
replace borncntry = 5 if cntbrthd == "CZ"
replace borncntry = 6 if cntbrthd == "DE"
replace borncntry = 7 if cntbrthd == "DK"
replace borncntry = 8 if cntbrthd == "EE"
replace borncntry = 9 if cntbrthd == "ES"
replace borncntry = 10 if cntbrthd == "FI"
replace borncntry = 11 if cntbrthd == "FR"
replace borncntry = 12 if cntbrthd == "GB"
replace borncntry = 13 if cntbrthd == "HR"
replace borncntry = 14 if cntbrthd == "HU"
replace borncntry = 15 if cntbrthd == "IE"
replace borncntry = 16 if cntbrthd == "IS"
replace borncntry = 17 if cntbrthd == "IT"
replace borncntry = 18 if cntbrthd == "LT"
replace borncntry = 19 if cntbrthd == "LV"
replace borncntry = 20 if cntbrthd == "ME"
replace borncntry = 21 if cntbrthd == "NL"
replace borncntry = 22 if cntbrthd == "NO"
replace borncntry = 23 if cntbrthd == "PL"
replace borncntry = 24 if cntbrthd == "PT"
replace borncntry = 25 if cntbrthd == "RS"
replace borncntry = 26 if cntbrthd == "SE"
replace borncntry = 27 if cntbrthd == "SI"
replace borncntry = 28 if cntbrthd == "SK"
lab de borncntry 0 "AT" 1 "BE" 2 "BG" 3 "CH" 4 "CY" 5 "CZ" 6 "DE" 7 "DK" 8 "EE" 9 "ES" 10 "FI" 11 "FR" 12 "GB" 13 "HR" 14 "HU" 15 "IE" 16 "IS" 17 "IT" 18 "LT" 19 "LV" 20 "ME" 21 "NL" 22 "NO" 23 "PL" 24 "PT" 25 "RS" 26 "SE" 27 "SI" 28 "SK"
lab val borncntry borncntry




gen WSHerkunft = .


replace WSHerkunft = 1 if borncntry == 15 | borncntry == 12
		// Liberaler WS Irland, GB
replace WSHerkunft = 2 if borncntry== 6	| borncntry == 11 | borncntry == 1 | borncntry == 21 | borncntry == 3 | borncntry == 0											
		// Bismarck/Konservativer WS Deutschland, Frankreich, Belgien, Niederlande, Luxemburg???, Schweiz, Austria
replace WSHerkunft = 3 if borncntry == 26 | borncntry == 7  | borncntry == 10 | borncntry == 22	| borncntry == 16 																	
		// Skandinavischer/Sozialdemokratischer WS Schweden, Dänemark, Finnland, Norwegen, Island (16)
replace WSHerkunft = 4 if borncntry == 17 | borncntry == 9	 | borncntry == 24 | borncntry == 4	
		// Mediterraner WS Griechenland???, Italien, Spanien, Portugal, Zypern
replace WSHerkunft = 5 if borncntry == 5	| borncntry == 8	 | borncntry == 14 | borncntry == 19 | borncntry == 18 | borncntry == 23 | borncntry == 28 | borncntry == 27 | borncntry == 2 | borncntry == 13	| borncntry == 20 | borncntry == 25 | borncntry == 29
		// Osten Czech Republic, Estonia, Hungary, Latvia, Lithuania, Poland, Slovakia, Slovenia, Bulgarien (2), Kroatien (13), Montenegro (20), Serbien (25)


label values WSHerkunft WSHerkunft
label def WSHerkunft 1 "LibWS", modify
label def WSHerkunft 2 "BismarckWS", modify	
label def WSHerkunft 3 "SkandWS", modify	
label def WSHerkunft 4 "MedWS", modify	
label def WSHerkunft 5 "Osten", modify	




gen WSaktuell = .


replace WSaktuell = 1 if Land == 15 | Land == 12
		// Liberaler WS Irland, GB
replace WSaktuell = 2 if Land== 6	| Land == 11 | Land == 1 | Land == 21 | Land == 3 | Land == 0											
		// Bismarck/Konservativer WS Deutschland, Frankreich, Belgien, Niederlande, Luxemburg???, Schweiz, Austria
replace WSaktuell = 3 if Land == 26 | Land == 7  | Land == 10 | Land == 22	| Land == 16 																	
		// Skandinavischer/Sozialdemokratischer WS Schweden, Dänemark, Finnland, Norwegen, Island (16)
replace WSaktuell = 4 if Land == 17 | Land == 9	 | Land == 24 | Land == 4	
		// Mediterraner WS Griechenland???, Italien, Spanien, Portugal, Zypern
replace WSaktuell = 5 if Land == 5	| Land == 8	 | Land == 14 | Land == 19 | Land == 18 | Land == 23 | Land == 28 | Land == 27 | Land == 2 | Land == 13	| Land == 20 | Land == 25 | Land == 29
		// Osten Czech Republic, Estonia, Hungary, Latvia, Lithuania, Poland, Slovakia, Slovenia, Bulgarien (2), Kroatien (13), Montenegro (20), Serbien (25)


label values WSaktuell WSaktuell
label def WSaktuell 1 "Angelsachsen", modify
label def WSaktuell 2 "Mitteleuropa", modify	
label def WSaktuell 3 "Nordeuropa", modify	
label def WSaktuell 4 "Südeuropa", modify	
label def WSaktuell 5 "Osteuropa", modify	



gen same =.


levelsof WSaktuell, local(lvls)

foreach x of local lvls {

replace same = 1 if WSHerkunft == `x' & WSaktuell == `x'

}

drop if same == 1
drop   same cntry cntbrthd Land borncntry

gen check = 1

collapse (sum) check, by(WSaktuell WSHerkunft)

sort WSHerkunft



ren WSHerkunft      lab1
ren WSaktuell lab2
ren check value


gen id = _n
order id


reshape long lab, i(id) j(layer)

ren lab lab2

decode lab2, gen(lab)
order id layer lab lab2


sort lab layer value
bysort lab: gen order = _n






egen tag = tag(lab)


expand 2 if tag==1, gen(tag2)
replace value = 0 if tag2==1 // duplicate entries are zero
replace order = 0 if tag2==1
replace id    = 0 if tag2==1

sort lab layer order
drop tag tag2













*** generate cumulative values

cap drop valsum

sort lab layer order

bysort lab: gen valsum = sum(value) // lab-wise cumulative total
gen valsumtot = sum(value)          // overall cumulative total



*** add gaps between arcs
sort lab layer order
egen gap = group(lab)
gen valsumtotg = valsumtot + (gap * 300)  // 300 is arbitrary



*Generating the horizontal axis

cap drop x y

gen y = 0


sum valsumtotg
gen x = valsumtotg / `r(max)'





*** get the spikes in order


sort id layer x
cap drop x1 y1 x2 y2


gen x1 = .
gen y1 = .

gen x2 = .
gen y2 = .

egen tag = tag(lab)  


levelsof lab2, local(lvls)

foreach x of local lvls {

summ x if lab2==`x'
replace x1 = `r(min)' if lab2==`x' & tag==1
replace x2 = `r(max)' if lab2==`x' & tag==1

summ y if lab2==`x'
replace y1 = `r(min)' if lab2==`x' & tag==1
replace y2 = `r(max)' if lab2==`x' & tag==1 

}


gen xmid = (x1 + x2) / 2
gen ymid = (y1 + y2) / 2










*Draw the arcs
  
sort lab layer order 
levelsof id if layer==1 & order!=0, local(lvls)
  
  
foreach x of local lvls {
  
gen boxx`x' = x if id==`x'
gen boxy`x' = y if id==`x'
  
  
// layer 1: starting points
display "ID = `x' layer 1" 
  
gen     seq`x' = 1 if id==`x' & layer==1
replace seq`x' = 2 if id==`x' & layer==2
  
qui summ lab2  if id==`x' & layer==1
local labcat1 = `r(mean)'
  
// start future block. these are used much later in the last step after reshape
  
gen from`x' = `r(mean)'  // from node
  
  
summ value if id==`x' & layer==1
gen fval`x' = `r(mean)'  // from value
  
qui summ order if id==`x' & layer==1
local prel1 = `r(mean)' - 1
  
// end future block here
  
display "`prel1'"
  
replace boxx`x' = x if lab2==`labcat1' & order==`prel1'
replace boxy`x' = y if lab2==`labcat1' & order==`prel1'
  
// one more item for the future. the mid point for labels on the from values
  
  
summ boxx`x' if layer==1
gen fmid`x' = `r(mean)'
  
// layer 2
display "ID = `x' layer 2"
  
qui summ lab2  if id==`x' & layer==2
local labcat2 = `r(mean)'
  
qui summ order if id==`x' & layer==2
local prel2 = `r(mean)' - 1
	
replace boxx`x' = x if lab2==`labcat2' & order==`prel2'
replace boxy`x' = y if lab2==`labcat2' & order==`prel2'
	
replace seq`x' = seq`x'[_n+1] if seq`x'[_n+1]!=.
	
}
	

	
	
	
	
	
	

expand 20  // I have used 40 for hi-res imgs for this article
	
	
levelsof id if layer==1 & order!=0, local(lvls)
	
foreach x of local lvls { 
	
//  calculate the mid point of each box based on outlayer min x of layer 0 and max x = layer 1
	
summ boxx`x' if seq`x'==2
local xout1 = `r(min)'
local  xin1 = `r(max)'
	
summ boxx`x' if seq`x'==1
local xout2 = `r(max)'
local  xin2 = `r(min)'
	
local midx = (`xout1' + `xout2')/2  
local midy = 0
	
local start = atan2(0 - `midy', `xout2' - `midx')
local end   = atan2(0 - `midy', `xout1' - `midx') 	
	
if `start' < `end' {
    gen t`x' = runiform(`start', `end')
 }

else {
    gen t`x' = runiform(`end', `start')
 }
	
gen radius`x'_in  = sqrt((`xin1'  - `midx')^2 + (0 - `midy')^2)        
gen radius`x'_out = sqrt((`xout1' - `midx')^2 + (0 - `midy')^2)
	
gen arcx_in`x'   = `midx' + radius`x'_in * cos(t`x')
gen arcy_in`x'   = `midy' + radius`x'_in * sin(t`x')
	
gen arcx_out`x'  = `midx' + radius`x'_out * cos(t`x')
gen arcy_out`x'  = `midy' + radius`x'_out * sin(t`x')
	
}	
	
	
	


	
keep id y1 x1 y2 x2 ymid xmid arc* from* layer value lab2 fval* fmid*
	
drop id
gen id = _n  // dummy for reshape

reshape long arcx_in arcy_in arcx_out arcy_out from fval fmid, i(id x1 y1 x2 y2 xmid ymid layer value lab2) j(num)
	
ren arcx_in arcx1
ren arcy_in arcy1
	
ren arcx_out arcx2
ren arcy_out arcy2
	
reshape long arcx arcy, i(id x1 y1 x2 y2 num lab2 layer value) j(level)













	
// control variables


egen tag = tag(num) 
gen y = 0 if tag==1
	
	
sort level num arcx
	
	
*** order the layers  
	
	
  
sort num level arcx
gen order = _n if level==1	
	
gsort level -arcx
gen temp = _n if level==2	
	
	
replace order = temp if level==2
drop temp	
	
cap drop tag2
egen tag2 = tag(num ymid xmid) // for the mid point of spikes	
	
sort num level order	
	
	


	
	
	

// Vorarbeit

replace fval = . if fval < 13 

	
	
	
	
	
*Last Steps


cd $grafi/ArcPlot



// loop for horizontal spikes
	
	
local spikes	
	
levelsof lab, local(lvls)
local items = `r(r)'	
	
foreach x of local lvls {
	
	
colorpalette HCL intense, n(`items') intensity(0.8) reverse nograph 
	
	
local spikes `spikes' (pcspike y1 x1 y2 x2 if num==1 & lab==`x', lc("`r(p`x')'") lwidth(1.5)) 

}
	
	
	
// loop for arcs  
local arcs  	
	
levelsof num, local(lvls)
foreach x of local lvls {


qui summ from if num==`x' // control the arc color here
local clr `r(mean)'
	
colorpalette HCL intense, n(`items') intensity(0.8) reverse nograph 


local arcs `arcs' (area arcy arcx if num==`x', fi(80) fc("`r(p`clr')'%70") lw(0.01) lc(black)) || 



}

// final figure

twoway ///
`arcs' ///
`spikes' ///
(scatter ymid xmid if num==1 & tag2==1, msize(vsmall) mcolor(none) mlabsize(1.8) mlab(lab2) mlabpos(6) mlabcolor(white))  ///
(scatter y fmid, msize(vsmall) mcolor(none) mlabsize(1.0) mlab(fval) mlabpos(12) mlabangle(90) mlabgap(1.8) mlabcolor(white)) ///
, legend(off) ///
ylabel(0(0.2)0.6, nogrid) xlabel(0(0.2)1, nogrid) aspect(0.6) ///
xscale(off) yscale(off) ///
title("Migration in Europa nach dem ESS9", size(small) color(white)) ///
note("Quelle: ESS9", size(tiny) color(white)) ///
subtitle("Areal der Geburt --> Areal zum Zeitpunkt der Befragung", color(white) size(vsmall)) ///
graphregion(fcolor(black) lc(black) lw(thick)) plotregion(fcolor(black) lc(black) lw(thick)) bgcolor(black)
graph export "Arc Plot - Migration in Europa nach dem ESS9.jpg", replace as(png) width(4600)

	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
/*












clear

capture log close
cd $data
log using $lofi/ArcPlot, replace
set more off, perm
numlabel _all, add force


use network/network_data.dta, clear



drop from to
ren source      lab1
ren destination lab2
collapse (sum) value, by(lab1 lab2)



gen id = _n
order id


reshape long lab, i(id) j(layer)


encode lab, gen(lab2)
order id layer lab lab2


sort lab layer value
bysort lab: gen order = _n




egen tag = tag(lab)


expand 2 if tag==1, gen(tag2)
replace value = 0 if tag2==1 // duplicate entries are zero
replace order = 0 if tag2==1
replace id    = 0 if tag2==1

sort lab layer order
drop tag tag2



*** generate cumulative values

cap drop valsum

sort lab layer order

bysort lab: gen valsum = sum(value) // lab-wise cumulative total
gen valsumtot = sum(value)          // overall cumulative total



*** add gaps between arcs
sort lab layer order
egen gap = group(lab)
gen valsumtotg = valsumtot + (gap * 300)  // 300 is arbitrary



*Generating the horizontal axis

cap drop x y

gen y = 0


sum valsumtotg
gen x = valsumtotg / `r(max)'


*** get the spikes in order


sort id layer x
cap drop x1 y1 x2 y2


gen x1 = .
gen y1 = .

gen x2 = .
gen y2 = .

egen tag = tag(lab)  

levelsof lab2, local(lvls)

foreach x of local lvls {

summ x if lab2==`x'
replace x1 = `r(min)' if lab2==`x' & tag==1
replace x2 = `r(max)' if lab2==`x' & tag==1

summ y if lab2==`x'
replace y1 = `r(min)' if lab2==`x' & tag==1
replace y2 = `r(max)' if lab2==`x' & tag==1 

}


gen xmid = (x1 + x2) / 2
gen ymid = (y1 + y2) / 2




*Draw the arcs
  
sort lab layer order 
levelsof id if layer==1 & order!=0, local(lvls)
  
  
foreach x of local lvls {
  
gen boxx`x' = x if id==`x'
gen boxy`x' = y if id==`x'
  
  
// layer 1: starting points
display "ID = `x' layer 1" 
  
gen     seq`x' = 1 if id==`x' & layer==1
replace seq`x' = 2 if id==`x' & layer==2
  
qui summ lab2  if id==`x' & layer==1
local labcat1 = `r(mean)'
  
// start future block. these are used much later in the last step after reshape
  
gen from`x' = `r(mean)'  // from node
  
  
summ value if id==`x' & layer==1
gen fval`x' = `r(mean)'  // from value
  
qui summ order if id==`x' & layer==1
local prel1 = `r(mean)' - 1
  
// end future block here
  
display "`prel1'"
  
replace boxx`x' = x if lab2==`labcat1' & order==`prel1'
replace boxy`x' = y if lab2==`labcat1' & order==`prel1'
  
// one more item for the future. the mid point for labels on the from values
  
  
summ boxx`x' if layer==1
gen fmid`x' = `r(mean)'
  
// layer 2
display "ID = `x' layer 2"
  
qui summ lab2  if id==`x' & layer==2
local labcat2 = `r(mean)'
  
qui summ order if id==`x' & layer==2
local prel2 = `r(mean)' - 1
	
replace boxx`x' = x if lab2==`labcat2' & order==`prel2'
replace boxy`x' = y if lab2==`labcat2' & order==`prel2'
	
replace seq`x' = seq`x'[_n+1] if seq`x'[_n+1]!=.
	
}
	
	
expand 20  // I have used 40 for hi-res imgs for this article
	
	
levelsof id if layer==1 & order!=0, local(lvls)
	
foreach x of local lvls { 
	
//  calculate the mid point of each box based on outlayer min x of layer 0 and max x = layer 1
	
summ boxx`x' if seq`x'==2
local xout1 = `r(min)'
local  xin1 = `r(max)'
	
summ boxx`x' if seq`x'==1
local xout2 = `r(max)'
local  xin2 = `r(min)'
	
local midx = (`xout1' + `xout2')/2  
local midy = 0
	
local start = atan2(0 - `midy', `xout2' - `midx')
local end   = atan2(0 - `midy', `xout1' - `midx') 	
	
if `start' < `end' {
    gen t`x' = runiform(`start', `end')
 }

else {
    gen t`x' = runiform(`end', `start')
 }
	
gen radius`x'_in  = sqrt((`xin1'  - `midx')^2 + (0 - `midy')^2)        
gen radius`x'_out = sqrt((`xout1' - `midx')^2 + (0 - `midy')^2)
	
gen arcx_in`x'   = `midx' + radius`x'_in * cos(t`x')
gen arcy_in`x'   = `midy' + radius`x'_in * sin(t`x')
	
gen arcx_out`x'  = `midx' + radius`x'_out * cos(t`x')
gen arcy_out`x'  = `midy' + radius`x'_out * sin(t`x')
	
}	
	
	
	

	
	
keep id y1 x1 y2 x2 ymid xmid arc* from* layer value lab2 fval* fmid*
	
drop id
gen id = _n  // dummy for reshape

reshape long arcx_in arcy_in arcx_out arcy_out from fval fmid, i(id x1 y1 x2 y2 xmid ymid layer value lab2) j(num)
	
ren arcx_in arcx1
ren arcy_in arcy1
	
ren arcx_out arcx2
ren arcy_out arcy2
	
reshape long arcx arcy, i(id x1 y1 x2 y2 num lab2 layer value) j(level)
	
	
	
	
	
	
// control variables


egen tag = tag(num) 
gen y = 0 if tag==1
	
	
sort level num arcx
	
	
*** order the layers  
	
	
  
sort num level arcx
gen order = _n if level==1	
	
gsort level -arcx
gen temp = _n if level==2	
	
	
replace order = temp if level==2
drop temp	
	
cap drop tag2
egen tag2 = tag(num ymid xmid) // for the mid point of spikes	
	
sort num level order	
	
	

	

	
	
	
	
	
*Last Steps



// loop for horizontal spikes
	
	
local spikes	
	
levelsof lab, local(lvls)
local items = `r(r)'	
	
foreach x of local lvls {
	
	
colorpalette HCL intense, n(`items') intensity(0.8) reverse nograph 
	
	
local spikes `spikes' (pcspike y1 x1 y2 x2 if num==1 & lab==`x', lc("`r(p`x')'") lwidth(1.5)) 

}
	
	
	
// loop for arcs  
local arcs  	
	
levelsof num, local(lvls)
foreach x of local lvls {


qui summ from if num==`x' // control the arc color here
local clr `r(mean)'
	
colorpalette HCL intense, n(`items') intensity(0.8) reverse nograph 


local arcs `arcs' (area arcy arcx if num==`x', fi(80) fc("`r(p`clr')'%70") lw(0.01) lc(black)) || 



}

// final figure

twoway ///
`arcs' ///
`spikes' ///
(scatter ymid xmid if num==1 & tag2==1, msize(vsmall) mcolor(none) mlabsize(1.8) mlab(lab2) mlabpos(6) mlabcolor(white)  )  ///
(scatter y fmid, msize(vsmall) mcolor(none) mlabsize(1.0) mlab(fval) mlabpos(12) mlabangle(90) mlabgap(1.8) mlabcolor(white) ) ///
, legend(off) ///
ylabel(0(0.2)0.6, nogrid) xlabel(0(0.2)1, nogrid) aspect(0.6) ///
xscale(off) yscale(off) ///
graphregion(fcolor(black) lc(black) lw(thick)) plotregion(fcolor(black) lc(black) lw(thick)) bgcolor(black)





	
	


































































	
	
clear

capture log close
cd $data/ESS
log using $lofi/Sankey, replace
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


decode borncntry, gen(borncntryStr)
decode Land, gen(LandStr)

ren LandStr cntry


drop Land
label drop Land
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


drop borncntry
gen borncntry = .

replace borncntry = 0 if borncntryStr == "AT"
replace borncntry = 1 if borncntryStr == "BE"
replace borncntry = 2 if borncntryStr == "BG"
replace borncntry = 3 if borncntryStr == "CH"
replace borncntry = 4 if borncntryStr == "CY"
replace borncntry = 5 if borncntryStr == "CZ"
replace borncntry = 6 if borncntryStr == "DE"
replace borncntry = 7 if borncntryStr == "DK"
replace borncntry = 8 if borncntryStr == "EE"
replace borncntry = 9 if borncntryStr == "ES"
replace borncntry = 10 if borncntryStr == "FI"
replace borncntry = 11 if borncntryStr == "FR"
replace borncntry = 12 if borncntryStr == "GB"
replace borncntry = 13 if borncntryStr == "HR"
replace borncntry = 14 if borncntryStr == "HU"
replace borncntry = 15 if borncntryStr == "IE"
replace borncntry = 16 if borncntryStr == "IS"
replace borncntry = 17 if borncntryStr == "IT"
replace borncntry = 18 if borncntryStr == "LT"
replace borncntry = 19 if borncntryStr == "LV"
replace borncntry = 20 if borncntryStr == "ME"
replace borncntry = 21 if borncntryStr == "NL"
replace borncntry = 22 if borncntryStr == "NO"
replace borncntry = 23 if borncntryStr == "PL"
replace borncntry = 24 if borncntryStr == "PT"
replace borncntry = 25 if borncntryStr == "RS"
replace borncntry = 26 if borncntryStr == "SE"
replace borncntry = 27 if borncntryStr == "SI"
replace borncntry = 28 if borncntryStr == "SK"
lab de borncntry 0 "AT" 1 "BE" 2 "BG" 3 "CH" 4 "CY" 5 "CZ" 6 "DE" 7 "DK" 8 "EE" 9 "ES" 10 "FI" 11 "FR" 12 "GB" 13 "HR" 14 "HU" 15 "IE" 16 "IS" 17 "IT" 18 "LT" 19 "LV" 20 "ME" 21 "NL" 22 "NO" 23 "PL" 24 "PT" 25 "RS" 26 "SE" 27 "SI" 28 "SK"
lab val borncntry borncntry




gen WSHerkunft = .


replace WSHerkunft = 1 if borncntry == 15 | borncntry == 12
		// Liberaler WS Irland, GB
replace WSHerkunft = 2 if borncntry== 6	| borncntry == 11 | borncntry == 1 | borncntry == 21 | borncntry == 3 | borncntry == 0											
		// Bismarck/Konservativer WS Deutschland, Frankreich, Belgien, Niederlande, Luxemburg???, Schweiz, Austria
replace WSHerkunft = 3 if borncntry == 26 | borncntry == 7  | borncntry == 10 | borncntry == 22	| borncntry == 16 																	
		// Skandinavischer/Sozialdemokratischer WS Schweden, Dänemark, Finnland, Norwegen, Island (16)
replace WSHerkunft = 4 if borncntry == 17 | borncntry == 9	 | borncntry == 24 | borncntry == 4	
		// Mediterraner WS Griechenland???, Italien, Spanien, Portugal, Zypern
replace WSHerkunft = 5 if borncntry == 5	| borncntry == 8	 | borncntry == 14 | borncntry == 19 | borncntry == 18 | borncntry == 23 | borncntry == 28 | borncntry == 27 | borncntry == 2 | borncntry == 13	| borncntry == 20 | borncntry == 25 | borncntry == 29
		// Osten Czech Republic, Estonia, Hungary, Latvia, Lithuania, Poland, Slovakia, Slovenia, Bulgarien (2), Kroatien (13), Montenegro (20), Serbien (25)


label values WSHerkunft WSHerkunft
label def WSHerkunft 1 "Liberaler WS", modify
label def WSHerkunft 2 "Bismarck/Konservativer WS", modify	
label def WSHerkunft 3 "Skandinavischer/Sozialdemokratischer WS", modify	
label def WSHerkunft 4 "Mediterraner WS", modify	
label def WSHerkunft 5 "Osten", modify	





gen WSaktuell = .


replace WSaktuell = 1 if Land == 15 | Land == 12
		// Liberaler WS Irland, GB
replace WSaktuell = 2 if Land== 6	| Land == 11 | Land == 1 | Land == 21 | Land == 3 | Land == 0											
		// Bismarck/Konservativer WS Deutschland, Frankreich, Belgien, Niederlande, Luxemburg???, Schweiz, Austria
replace WSaktuell = 3 if Land == 26 | Land == 7  | Land == 10 | Land == 22	| Land == 16 																	
		// Skandinavischer/Sozialdemokratischer WS Schweden, Dänemark, Finnland, Norwegen, Island (16)
replace WSaktuell = 4 if Land == 17 | Land == 9	 | Land == 24 | Land == 4	
		// Mediterraner WS Griechenland???, Italien, Spanien, Portugal, Zypern
replace WSaktuell = 5 if Land == 5	| Land == 8	 | Land == 14 | Land == 19 | Land == 18 | Land == 23 | Land == 28 | Land == 27 | Land == 2 | Land == 13	| Land == 20 | Land == 25 | Land == 29
		// Osten Czech Republic, Estonia, Hungary, Latvia, Lithuania, Poland, Slovakia, Slovenia, Bulgarien (2), Kroatien (13), Montenegro (20), Serbien (25)


label values WSaktuell WSaktuell
label def WSaktuell 1 "Liberaler WS", modify
label def WSaktuell 2 "Bismarck/Konservativer WS", modify	
label def WSaktuell 3 "Skandinavischer/Sozialdemokratischer WS", modify	
label def WSaktuell 4 "Mediterraner WS", modify	
label def WSaktuell 5 "Osten", modify	



gen same =.


levelsof WSaktuell, local(lvls)

foreach x of local lvls {

replace same = 1 if WSHerkunft == `x' & WSaktuell == `x'

}

drop if same == 1
drop check  same


	
	
	
	
	
	
	
	
	
	
	
	
	
	


	










