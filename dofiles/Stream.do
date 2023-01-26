





clear

capture log close
cd $data
log using $lofi/Stream, replace
set more off, perm
numlabel _all, add force




*https://www.imf.org/external/datamapper/NGDPDPC@WEO/OEMDC/ADVEC/WEOWORLD


import excel makros/gdpAllTS.xlsx, firstrow clear




*********************
*     Alle Länder   *
*********************




foreach var of varlist B-AV {

drop  if `var' == "no data"
}

gen id = _n
labmask id, val(GDPpercapitacurrentprices)
drop  GDPpercapitacurrentprices
drop if id > 134


foreach var of varlist B-AV {

  destring `var', gen(`var'De)
  drop `var'
}




foreach var of varlist BDe-AVDe{
    
		local current_lab: variable label `var'
		local new_current_lab = subinstr("`current_lab'", " ","_",.)
		local new_current_lab = subinstr("`new_current_lab'", ".","_",.)
		local new_current_lab = subinstr("`new_current_lab'", "(","_",.)
		local new_current_lab = subinstr("`new_current_lab'", ")","_",.)

		if strpos( "`new_current_lab'", "1") == 1  {
    
		dis "`new_current_lab'"
		rename `var' a_`new_current_lab'

		}
		
		if strpos( "`new_current_lab'", "2") == 1  {
    
		dis "`new_current_lab'"
		rename `var' a_`new_current_lab'

		}
}


foreach var of varlist a_1980-a_1989{

drop `var'

}




foreach var of varlist a_2022-a_2026{

drop `var'

}


reshape long a_, i(id) j(layer)

rename a_ Bip
rename layer Jahr







gen BipNorm = . 
 
levelsof id, local(levels)

foreach x of local levels {


summ Bip if id==`x'
replace BipNorm = Bip / `r(max)' if id==`x'


}
 



egen rank = rank(Bip) if Jahr == 2021

sort   id rank
carryforward rank, replace
sort rank

decode id, gen(cntry)
labmask rank, val(cntry)
drop cntry id

sort rank Jahr




gen Proz = .
egen JahrNum = rank(Jahr), by(rank)
replace JahrNum = 33 - JahrNum


gen Proz2 = .

replace Proz2 = Bip if JahrNum != 1



gen Proz3 = .

replace Proz3 = Proz2[_n-1]


gen CAGR3 = Bip if JahrNum == 32
gen CAGR2 = .
replace CAGR2 = Bip if JahrNum == 1
gen CAGR1 = .
replace CAGR1 = CAGR2[_n+31]
drop CAGR2
gen CAGR = .
replace CAGR = (((CAGR1/CAGR3)^(1/31))-1)*100
gsort rank -JahrNum
carryforward CAGR, replace


sort CAGR
egen rankCAGR = group(CAGR rank)
replace rankCAGR = 135-rankCAGR


decode rank, gen(cntry)
labmask rankCAGR, val(cntry)
drop cntry


drop if JahrNum == 32

gen wachstum = (((Bip/Proz3)-1))*100


tostring Jahr, gen(year)
encode year, gen(year1)




format Bip %9.0fc


xtset rank year1
tssmooth ma Bip_ma7  = Bip , w(6 1 0) 



******** new we stack these up



gen stack_Bip = .

sort year1 rank

levelsof year1, local(year1)


foreach y of local year1 {


  summ rank

*** cases


replace stack_Bip  = Bip_ma7 if year1==`y' &  rank==`r(min)' 
replace stack_Bip  = Bip_ma7  + stack_Bip[_n-1]  if  year1==`y' & rank!=`r(min)'  


}



  
// rename just to keep life easy  
ren stack_Bip cases

  
  
*** preserve the labels
  
levelsof rank, local(idlabels)      // store the id levels
  
  
  
foreach x of local idlabels {       
local idlab_`x' : label rank `x'  
 }
  

*** reshape the data

keep cases Bip year1 rank
  
reshape wide cases Bip  , i(year1) j(rank) 
order year1 cases* Bip* 
  
  
*** and apply the labels back
  
  
foreach x of local idlabels { 
  
 lab var     cases`x'  "`idlab_`x''" 
 lab var Bip`x'  "`idlab_`x''"   
    
}
 
 
 
gen cases0 = 0  

ds cases*
local items : word count `r(varlist)'
local items = `items' - 1
display `items'
 
 
 
gen meanval_cases  =  cases`items' / 2

 

foreach x of varlist cases* {
 gen `x'_norm  = `x' - meanval_cases
}
 

drop meanval*
 
 

 
*** this part is for the mid points
 
 
summ year1
gen last = 1 if year1==r(max)


ds cases*norm
local items : word count `r(varlist)'
local items = `items' - 2
display `items'


forval i = 0/`items' {
local i0 = `i'
local i1 = `i' + 1

gen ycases`i1'  = (cases`i0'_norm + cases`i1'_norm) / 2 if last==1

}



*** this part is for the shares

egen lastsum_cases  = rowtotal(Bip*)  if last==1



foreach x of varlist Bip* {

 gen `x'_share = (`x' / lastsum_cases) * 100
 
}


drop lastsum*



**** here we generate the labels


ds cases*norm
local items : word count `r(varlist)'
local items = `items' - 1




foreach x of numlist 1/`items' {

local t : var lab cases`x'


*** cases 
gen label`x'_cases  = "`t'"  + " (" + string( Bip`x', "%9.0f") + ", " + string( Bip`x'_share, "%9.0fc") + "%)" if last==1


}




cd $grafi/Stream

*** automate the areas, colors, labels

ds cases*norm
local items : word count `r(varlist)'
local items = `items' - 2
display `items'


forval x = 0/`items' {  



colorpalette HCL intense , n(134) nograph
 
local x0 =  `x'
local x1 =  `x' + 1




local areagraph `areagraph' rarea cases`x0'_norm cases`x1'_norm year1, fcolor("`r(p`x1')'") lcolor(black) lwidth(*0.15) || (scatter ycases`x1' year1  if last==1 & `x' > 106, ms(smcircle) msize(0.2) mlabel(label`x1'_cases) mcolor(black%20) mlabsize(1) mlabcolor(black)) ||


}

*** get the date ranges in order

summ year1 
local x1 = `r(min)'
local x2 = `r(max)' + 3
local x3 = `r(max)'



*** generate the graph


graph twoway ///
`areagraph' ///
, ///
legend(off) ///
ytitle("", size(small)) ///
ylabel(-300000(100000)300000) ///
yscale(noline) ///
ylabel(, nolabels noticks nogrid) ///
xscale(range(`x1'(1)`x2')) ///
xscale(noline) ///
xtitle("") ///
xlabel(`x1'(1)`x3',  valuelabel labsize(*0.4) angle(vertical) glwidth(vvthin) glpattern(solid)) ///
title("BIP - Jährliche Entwicklung und Anteil der Länder am Gesamt-Bip 2021 weltweit") ///
note("Datasource: IMF. Countries with missing data were excluded", size(tiny))
graph export "BIP - Jährliche Entwicklung und Anteil der Länder am Gesamt-Bip weltweit.jpg", replace as(png) width(4600)

  
  
  
  
  
  
  
  
/*
  
  

*********************
*    Regionen       *
*********************







clear

capture log close
cd $data
log using $lofi/Stream, replace
set more off, perm
numlabel _all, add force




*https://www.imf.org/external/datamapper/NGDPDPC@WEO/OEMDC/ADVEC/WEOWORLD


import excel makros/gdpAllTS.xlsx, firstrow clear


copy "https://github.com/asjadnaqvi/The-Stata-Guide/blob/master/data/country_codes.dta?raw=true" "country_codes.dta", replace






foreach var of varlist B-AV {

drop  if `var' == "no data"
}

gen id = _n
labmask id, val(GDPpercapitacurrentprices)
drop  GDPpercapitacurrentprices
drop if id > 134


foreach var of varlist B-AV {

  destring `var', gen(`var'De)
  drop `var'
}




foreach var of varlist BDe-AVDe{
    
		local current_lab: variable label `var'
		local new_current_lab = subinstr("`current_lab'", " ","_",.)
		local new_current_lab = subinstr("`new_current_lab'", ".","_",.)
		local new_current_lab = subinstr("`new_current_lab'", "(","_",.)
		local new_current_lab = subinstr("`new_current_lab'", ")","_",.)

		if strpos( "`new_current_lab'", "1") == 1  {
    
		dis "`new_current_lab'"
		rename `var' a_`new_current_lab'

		}
		
		if strpos( "`new_current_lab'", "2") == 1  {
    
		dis "`new_current_lab'"
		rename `var' a_`new_current_lab'

		}
}


foreach var of varlist a_1980-a_1989{

drop `var'

}




foreach var of varlist a_2022-a_2026{

drop `var'

}


reshape long a_, i(id) j(layer)

rename a_ Bip
rename layer Jahr

















tab cntry
gen Land = .
replace Land = 0 if cntry == "Austria"
replace Land = 1 if cntry == "Belgium"
replace Land = 2 if cntry == "Bulgaria"
replace Land = 3 if cntry == "Suisse"
replace Land = 4 if cntry == "Cyprus"
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

































collapse (sum) Bip , by(year1 region)




gen check = 1 if year == 31
sort check Bip  region 
egen rank = rank(Bip) if check == 1
*gen rankinv = 13-rank
gen rankinv = rank
sort  region rankinv
carryforward rankinv, replace
sort rankinv
decode region, gen(region1)
labmask rankinv, val(region1)

drop region1 region
ren rankinv region

sort rank


format Bip %9.0fc


xtset region year1
tssmooth ma Bip_ma7  = Bip , w(6 1 0) 











******** new we stack these up



gen stack_Bip = .

sort year1 region

levelsof year1, local(year1)


foreach y of local year1 {


  summ region

*** cases


replace stack_Bip  = Bip_ma7 if year1==`y' &  region==`r(min)' 
replace stack_Bip  = Bip_ma7  + stack_Bip[_n-1]  if  year1==`y' & region!=`r(min)'  


}



  
// rename just to keep life easy  
ren stack_Bip cases

  
  
*** preserve the labels
  
levelsof region, local(idlabels)      // store the id levels
  
  
  
foreach x of local idlabels {       
local idlab_`x' : label region `x'  
 }
  

*** reshape the data

keep cases Bip year1 region
  
reshape wide cases Bip  , i(year1) j(region) 
order year1 cases* Bip* 
  
  
*** and apply the labels back
  
  
foreach x of local idlabels { 
  
 lab var cases`x'  "`idlab_`x''" 
 lab var Bip`x'  "`idlab_`x''"   
    
}
 
 
 
gen cases0 = 0  

ds cases*
local items : word count `r(varlist)'
local items = `items' - 1
display `items'
 
 
 
gen meanval_cases  =  cases`items' / 2

 

foreach x of varlist cases* {
 gen `x'_norm  = `x' - meanval_cases
}
 

drop meanval*
 
 

 
*** this part is for the mid points
 
 
summ year1
gen last = 1 if year1==r(max)


ds cases*norm
local items : word count `r(varlist)'
local items = `items' - 2
display `items'


forval i = 0/`items' {
local i0 = `i'
local i1 = `i' + 1

gen ycases`i1'  = (cases`i0'_norm + cases`i1'_norm) / 2 if last==1

}



*** this part is for the shares

egen lastsum_cases  = rowtotal(Bip*)  if last==1



foreach x of varlist Bip* {

 gen `x'_share = (`x' / lastsum_cases) * 100
 
}


drop lastsum*



**** here we generate the labels


ds cases*norm
local items : word count `r(varlist)'
local items = `items' - 1




foreach x of numlist 1/`items' {

local t : var lab cases`x'


*** cases 
gen label`x'_cases  = "`t'"  + " (" + string( Bip`x', "%9.0f") + ", " + string( Bip`x'_share, "%9.0fc") + "%)" if last==1


}






*** automate the areas, colors, labels

ds cases*norm
local items : word count `r(varlist)'
local items = `items' - 2
display `items'


forval x = 0/`items' {  



colorpalette HCL intense , n(134) nograph
 
local x0 =  `x'
local x1 =  `x' + 1




local areagraph `areagraph' rarea cases`x0'_norm cases`x1'_norm year1, fcolor("`r(p`x1')'") lcolor(black) lwidth(*0.15) || (scatter ycases`x1' year1  if last==1, ms(smcircle) msize(0.2) mlabel(label`x1'_cases) mcolor(black%20) mlabsize(1) mlabcolor(black)) ||


}

*** get the date ranges in order

summ year1 
local x1 = `r(min)'
local x2 = `r(max)' + 3
local x3 = `r(max)'



*** generate the graph


graph twoway ///
`areagraph' ///
 , ///
  legend(off) ///
  ytitle("", size(small)) ///
  ylabel(-300000(100000)300000) ///
  yscale(noline) ///
  ylabel(, nolabels noticks nogrid) ///
  xscale(range(`x1'(1)`x2')) ///
  xscale(noline) ///
  xtitle("") ///
  xlabel(`x1'(1)`x3',  valuelabel labsize(*0.4) angle(vertical) glwidth(vvthin) glpattern(solid)) ///
  title("BIP - Jährliche Entwicklung und Anteil der Länder am Gesamt-Bip weltweit") ///
  note("Datasource: IMF. Countries with missing data were excluded", size(tiny))











