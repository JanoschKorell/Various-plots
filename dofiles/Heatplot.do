




clear

capture log close
cd $data
log using $lofi/Heat, replace
set more off, perm
numlabel _all, add force



*https://www.imf.org/external/datamapper/NGDPDPC@WEO/OEMDC/ADVEC/WEOWORLD


import excel makros/gdpAllTS.xlsx, firstrow clear





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





cd $grafi/Heat


quietly: summarize year1
return list
local count = `r(max)' 

local xlab
forval i=1/`count'{
local xlab "`xlab' `=`i'+0' `" "`:lab (year1) `i''" "'"
}



quietly: summarize rankCAGR
return list
local count2 = `r(max)' 






#delimit;
heatplot wachstum i.rankCAGR i.year1,


ytitle("")                
xtitle("")

color("255 30 180*1" "255 30 120*.65" "189 30 36*.65" "189 30 36*.25" "189 30 36*.1" "189 30 36*.05" "255 255 255" "89 194 0*0.065" "89 194 0*0.125" "89 194 0*0.25" "89 194 0*0.375" "89 194 0*0.50" "89 194 0*0.625" "89 160 0*0.75" "89 140 0*0.875" "89 120 0*1" "0 0 0")

 
cuts(@min -50 -30 -20 -10 -5 -2.5 0 1 2.5 5 7.5 10 15 20 25 30 @max)
 
legend(subtitle("{bf}Growth rate in %", 
span 
size(1.3)
) 
pos(1) 
ring(1) 
rows(1) 
keygap(0.5) 
colgap(0) 
size(1) 
symysize(0.55) 
symxsize(3) 
order(1 "" 2 "-50" 3 "-30" 4 "-20" 5 "-10" 6 "-2.5" 7 "0" 8 "1" 9 "2.5" 10 "5" 11 "7.5" 12 "10" 13 "15" 14 "20" 15 "25" 16 "30" 17 "40+") 
stack
)
xlabel(`xlab', 
nogrid 
labsize(1.3) 
labcolor(gs5)
)

xscale(extend)


yscale(
	noline 
	alt 
	reverse
	) 

ylabel(, 
	angle(horizontal) 
	labgap(-145) 
	labsize(0.8) 
	noticks 
	labcolor(gs5) 
	nogrid
	)
	
graphregion(margin(l=22 r=2)) 
plotregion(margin(b=0 t=0))


p(
    lcolor(white) 
    lwidth(0.1) 
    lalign(center)
   )
   



title("{bf}GDP growth rates worldwide in US-Dollar per year", 
     pos(11) 
     size(2.25) 
     margin(l=-20 b=-10 t=2)
    ) 
	
subtitle("1991-2021 Ordered by CAGR", 
     pos(11) 
     size(2) 
     margin(l=-20 b=-10 t=5)
    )

note("Source: IMF. Countries with missing data were excluded",      
	pos(8)
	size(0.8) 
	margin(l=-20 b=-6 t=1)
	);

   
#delimit crs





/*






clear

capture log close
cd $data
log using $lofi/LogFileRidgePlot, replace
set more off, perm
numlabel _all, add force


clear



insheet using "https://raw.githubusercontent.com/TheEconomist/covid-19-excess-deaths-tracker/master/output-data/excess-deaths/all_monthly_excess_deaths.csv", clear


isid country region start_date

egen tag = tag(country region)

bysort country: egen count = total(tag)
generate ctr_reg = 1 if (country==region) & count>1

drop if count>1 & ctr_reg == .
drop country tag count ctr_reg

codebook region


encode region, gen(Region)


bysort Region: generate yrmth = _n

drop if yrmth > 17

list region yrmth in 1/20




#delimit ;
 label define yrmth 
      1 "Jan 2020"   2 "Feb" 
      3 "Mar"        4 "Apr" 
      5 "May"        6 "Jun" 
      7 "Jul"        8 "Aug" 
      9 "Sep"        10 "Oct" 
      11 "Nov"       12 "Dec" 
      13 "Jan 2021"  14 "Feb" 
      15 "Mar"       16 "Apr"
      17 "May"       18 "Jun"
      19 "Jul"       20 "Aug"
      21 "Sep"       22 "Oct"
      23 "Nov"       24 "Dec"
      25 "Jan 2022"  26 "Feb"
   , replace 
 ;
 #delimit cr


label values yrmth yrmth



replace excess_deaths_pct_change = round(excess_deaths_pct_change*100, 1)


keep  excess_deaths_pct_change Region yrmth
sort yrmth




quietly: summarize yrmth
return list
local count = `r(max)' + 1



 local xlab
    forval i=1/`count'{
        local xlab "`xlab' `=`i'-0.5' `" "`:lab (yrmth) `i''" "'"
    }

 
#delimit;
heatplot excess_deaths_pct_change i.Region i.yrmth, 
 
ytitle("")                
xtitle("")
 
cuts(@min 0 25 50 100 200 @max)
 
legend(subtitle("{bf}Deviation from expected deaths, %         ", 
span 
size(1.75)
) 
pos(1) 
ring(1) 
rows(1) 
keygap(0.5) 
colgap(0) 
size(1.5) 
symysize(0.85) 
symxsize(7) 
order(1 "" 2 "0" 3 "+25" 4 "+50" 5 "+100" 6 "+200") 
stack
)
xlabel(`xlab', 
nogrid 
labsize(1.75) 
labcolor(gs5)
)

xscale(extend)


yscale(
	noline 
	alt 
	reverse
	) 

ylabel(, 
	angle(horizontal) 
	labgap(-145) 
	labsize(1.8) 
	noticks 
	labcolor(gs5) 
	nogrid
	)
	
graphregion(margin(l=22 r=2)) 
plotregion(margin(b=0 t=0))


p(
    lcolor(white) 
    lwidth(0.1) 
    lalign(center)
   )
   
color("234 242 245" "254 239 216" "253 204 138" "252 140 89" "227 73 51" "179 0 1")



addplot(      
     scatter Region yrmth, 
     color(%0)
     xaxis(2)
     xtitle("", axis(2)) 
     xlabel(
       1/`count', 
       valuelabels 
       labsize(1.75) 
       labcolor(gs5) 
       nogrid 
       axis(2)
      )
    ) 
	
title("{bf}Excess deaths by country or city", 
     pos(11) 
     size(2.25) 
     margin(l=-20 b=-10 t=2)
    ) 
	
subtitle("Last updated on - `c(current_date)'", 
     pos(11) 
     size(2) 
     margin(l=-20 b=-10 t=5)
    );

#delimit crs
 
 

























 

