


*https://meteostat.net/de/place/de/wurzburg?t=2021-01-01/2021-12-31&s=69739

clear

capture log close
cd $data
log using $lofi/LogFileRidgePlot, replace
set more off, perm
numlabel _all, add force


clear

import delimited Meteostat/WueNieder21.csv


rename ïdate date
rename prcp niederschlag
keep date niederschlag

replace niederschlag = 0 if niederschlag == .

gen double timets = clock(date, "YMDhms")
format time %tcD_M_CY

gen year  = substr(date,1,4)
gen month = substr(date,6,2)
gen day   = substr(date,9,2)


destring year month day, replace

gen monat1 = month
gen Tag = day


gen time = mdy(month,day,year)
format time %tdDD-Mon-yyyy
drop year month day

gen monat = .
replace monat = 1 if monat1 == 12
replace monat = 2 if monat1 == 11
replace monat = 3 if monat1 == 10
replace monat = 4 if monat1 == 9
replace monat = 5 if monat1 == 8
replace monat = 6 if monat1 == 7
replace monat = 7 if monat1 == 6
replace monat = 8 if monat1 == 5
replace monat = 9 if monat1 == 4
replace monat = 10 if monat1 == 3
replace monat = 11 if monat1 == 2
replace monat = 12 if monat1 == 1

//lab de monat  1 "Januar" 2 "Februar" 3 "März" 4 "April" 5 "Mai" 6 "Juni" 7 "Juli" 8 "August" 9 "September" 10 "Oktober" 11 "November" 12 "Dezember"
lab de monat  12 "Januar" 11 "Februar" 10 "März" 9 "April" 8 "Mai" 7 "Juni" 6 "Juli" 5 "August" 4 "September" 3 "Oktober" 2 "November" 1 "Dezember"
lab val monat monat


*Niederschlag  pro Monat

egen NiederProM = total(niederschlag), by(monat)
egen rank = rank(-NiederProM) if Tag == 1, f

decode monat, gen(monatString)

levelsof monatString, local(lvls)
 
foreach x of local lvls {

 display "`x'"
 
 qui summ rank if monatString=="`x'"  // summarize the rank of country x
 cap replace rank = `r(max)' if monatString=="`x'" 
 
 }

sort rank
 
labmask rank, values(monatString)

rename rank rank1
rename monat monat0
rename rank monat
 
// 01 Normalisierung Niederschlag
 
 
gen Niedernorm = . 


summ niederschlag
replace Niedernorm = niederschlag/`r(max)'



 
 
save Meteostat/RidgfertigNiederschlag.dta, replace 
 
 
 
 
 
 
 
clear

cd $data/

use Meteostat/RidgfertigNiederschlag.dta

cd $grafi/Ridgeplots



// Graph 

gen ypoint=.

sort monat
egen tag = tag(monat)
summ Tag
gen xpoint = -1 if tag==1

summ time
levelsof monat, local(levels)
local items = `r(r)' + 6

gsort- monat Tag 

foreach x of local levels {

summ monat

local newx = `r(max)' + 1 - `x'   // reverse the sorting

lowess Niedernorm Tag if monat ==`newx', bwid(0.09) gen(y`newx') nograph
    
gen ybot`newx' =  `newx'/ 4     // squish the axis

gen ytop`newx' = y`newx' + ybot`newx'

colorpalette HCL Heat, n(`items') reverse nograph

local mygraph `mygraph' rarea  ytop`newx' ybot`newx' Tag, fc("`r(p`newx')'%75")  lc(white)  lw(thin) || 
  
replace ypoint= (ybot`newx' + 1/16) if xpoint!=. & monat ==`newx' 

}



summ Tag 
local x1 = `r(min)'
local x2 = `r(max)'


twoway  ///
`mygraph'  ///
(scatter ypoint xpoint, mcolor(white) msize(zero) msymbol(point) ///
mlabel(monat) mlabsize(*0.6) mlabcolor(black)) ///
, ///
xlabel(`x1'(1)`x2', nogrid labsize(tiny)) ///
ylabel(,nolabels noticks nogrid) yscale(noline)  ytitle("") xtitle("") ///
legend(off) ///
plotregion(margin(zero)) ///
title("Niederschlag in Würzburg 2021", size(small)) ///
subtitle("Geordnet nach Niederschlagsmenge pro Monat", size(tiny)) ///
note("Datasource: Meteostat", size(tiny)) 
graph export "Regenfall Würzburg 2021 nach Monat.jpg", replace as(png) width(4600)



 
 
 

 

 
 
 
 
 
 
 

 
 
 
 

/*
  
* COVID 19 - Fälle nach Bundesland * 




// Missings

clear
clear results
clear matrix
clear programs
clear all


cd $data
import delimited Data_COVID19/RKI_COVID19.csv



gen fälle = anzahlfall
replace fälle = . if inrange(anzahlfall,-1, -9)

gen tote = anzahltodesfall
replace tote = . if inrange(anzahltodesfall,0, -1)

 


//Zeitreihe 1 Tage

gen double timets = clock(meldedatum, "YMDhms")
format time %tcD_M_CY

gen year  = substr(meldedatum,1,4)
gen month = substr(meldedatum,6,2)
gen day   = substr(meldedatum,9,2)


destring year month day, replace


gen time = mdy(month,day,year)
format time %tdDD-Mon-yyyy
drop year month day


// Zeit begrenzen

gen time2 = time
drop if time2 > 22287 

// Collapse

collapse (sum)  fälle tote, by(time bundesland idbundesland)


// Enstringen


encode bundesland if idbundesland !=., gen(Bl)
labmask Bl, values(bundesland)



label def Bl 1  "Baden-Württemberg", modify
label def Bl 16 "Thüringen", modify

decode Bl, gen(bundesland2)

order time Bl fälle
sort  Bl time 



save RKI.dta, replace

**************************Rankblock Fälle**************************



clear

use RKI.dta



*-------------------------Rankfälle------------------------*

// Fälle auf 1pE kumuliert
 
sort  bundesland time
 
gen fällecum = .
 
levelsof Bl, local(levels) 

foreach x of local levels {

replace fällecum = sum(fälle) if Bl==`x'

}


gen Blp1fällecum = .
replace Blp1fällecum = fällecum * 1/110.7 if Bl == 1
replace Blp1fällecum = fällecum * 1/130.8 if Bl == 2
replace Blp1fällecum = fällecum * 1/36.69 if Bl == 3
replace Blp1fällecum = fällecum * 1/25.2 if Bl == 4
replace Blp1fällecum = fällecum * 1/5.47 if Bl == 5
replace Blp1fällecum = fällecum * 1/18.99 if Bl == 6
replace Blp1fällecum = fällecum * 1/62.66 if Bl == 7
replace Blp1fällecum = fällecum * 1/16.1 if Bl == 8
replace Blp1fällecum = fällecum * 1/79.82 if Bl == 9
replace Blp1fällecum = fällecum * 1/179.3 if Bl == 10
replace Blp1fällecum = fällecum * 1/40.85 if Bl == 11
replace Blp1fällecum = fällecum * 1/9.9  if Bl == 12
replace Blp1fällecum = fällecum * 1/40.78 if Bl == 13
replace Blp1fällecum = fällecum * 1/22.08 if Bl == 14
replace Blp1fällecum = fällecum * 1/28.9 if Bl == 15
replace Blp1fällecum = fällecum * 1/21.37 if Bl == 16

// Fälle auf 1pE einzeln

gen Blp1fälle = .
replace Blp1fälle = fälle * 1/110.7 if Bl == 1
replace Blp1fälle = fälle * 1/130.8 if Bl == 2
replace Blp1fälle = fälle * 1/36.69 if Bl == 3
replace Blp1fälle = fälle * 1/25.2 if Bl == 4
replace Blp1fälle = fälle * 1/5.47 if Bl == 5
replace Blp1fälle = fälle * 1/18.99 if Bl == 6
replace Blp1fälle = fälle * 1/62.66 if Bl == 7
replace Blp1fälle = fälle * 1/16.1 if Bl == 8
replace Blp1fälle = fälle * 1/79.82 if Bl == 9
replace Blp1fälle = fälle * 1/179.3 if Bl == 10
replace Blp1fälle = fälle * 1/40.85 if Bl == 11
replace Blp1fälle = fälle * 1/9.9  if Bl == 12
replace Blp1fälle = fälle * 1/40.78 if Bl == 13
replace Blp1fälle = fälle * 1/22.08 if Bl == 14
replace Blp1fälle = fälle * 1/28.9 if Bl == 15
replace Blp1fälle = fälle * 1/21.37 if Bl == 16



// Rank

summ time 
gen tick = 1 if time == `r(max)' 

sort  Blp1fällecum time
egen rank = rank(Blp1fällecum) if tick==1, f


// Rank in Verbindung mit Bundesland


//!!!!!!!Wichtig Bl wird mit Rank ersetzt!!!!!!!///

levelsof bundesland, local(lvls)
 
foreach x of local lvls {

 display "`x'"
 
 qui summ rank if bundesland=="`x'"  // summarize the rank of country x
 cap replace rank = `r(max)' if bundesland=="`x'" & rank==.
 
 }


// Rank2 mit Values von Bundesland

gen rank2 = rank

sort rank bundesland
labmask rank2, values(bundesland2)


**************************Rankblock Tote**************************



*-------------------------Ranktote------------------------*

// Fälle auf 100000 pro B
 
sort  bundesland time
 
gen totecum = .
 
levelsof Bl , local(levels)

foreach x of local levels {

replace totecum = sum(tote) if Bl==`x'

}


gen BlTop1 = .
replace BlTop1 = totecum * 1/110.7 if Bl == 1
replace BlTop1 = totecum * 1/130.8 if Bl == 2
replace BlTop1 = totecum * 1/36.69 if Bl == 3
replace BlTop1 = totecum * 1/25.2 if Bl == 4
replace BlTop1 = totecum * 1/5.47 if Bl == 5
replace BlTop1 = totecum * 1/18.99 if Bl == 6
replace BlTop1 = totecum * 1/62.66 if Bl == 7
replace BlTop1 = totecum * 1/16.1 if Bl == 8
replace BlTop1 = totecum * 1/79.82 if Bl == 9
replace BlTop1 = totecum * 1/179.3 if Bl == 10
replace BlTop1 = totecum * 1/40.85 if Bl == 11
replace BlTop1 = totecum * 1/9.9  if Bl == 12
replace BlTop1 = totecum * 1/40.78 if Bl == 13
replace BlTop1 = totecum * 1/22.08 if Bl == 14
replace BlTop1 = totecum * 1/28.9 if Bl == 15
replace BlTop1 = totecum * 1/21.37 if Bl == 16



// Rank


sort bundesland BlTop1


sort time
summ time
gen ticktot = 1 if time == `r(max)'

sort bundesland BlTop1
egen ranktot = rank(BlTop1) if ticktot==1, f


// Rank in Verbindung mit Bundesland


//!!!!!!!Wichtig Bl wird mit Rank ersetzt!!!!!!!///

levelsof bundesland, local(lvls)
 
foreach x of local lvls {

 display "`x'"
 
 qui summ ranktot if bundesland=="`x'"  // summarize the rank of country x
 cap replace ranktot = `r(max)' if bundesland=="`x'"
 
 }


// Rank2 mit Values von Bundesland


gen ranktot2 = ranktot

sort ranktot2 bundesland
labmask ranktot2, values(bundesland2)


// 01 Normalisierung Tote


replace fälle = 0 if fälle == .
replace tote = 0 if tote == .





  
 
gen totenorm = . 
 
levelsof Bl, local(levels)

foreach x of local levels {


summ tote if Bl==`x'
replace totenorm = tote / `r(max)' if Bl==`x'


 }
 
 
// 01 Normalisierung Fälle
 
 
gen fällenorm = . 

 
levelsof Bl, local(levels)

foreach x of local levels {

summ fälle if Bl==`x'
replace fällenorm = fälle / `r(max)' if Bl==`x'


}
 



save Ridgfertig.dta, replace 


*********************Hauptteil 2************************ (Fälle)

clear


cd $data/Data_COVID19

use Ridgfertig.dta

cd $grafi/Ridgeplots



// Graph Tote

gen ypoint=.

sort ranktot2
egen tag = tag(ranktot2)
summ time
gen xpoint = `r(min)' if tag==1

summ time
levelsof ranktot2, local(levels)
local items = `r(r)' + 6

sort  ranktot2 fällenorm

foreach x of local levels {

summ ranktot2

local newx = `r(max)' + 1 - `x'   // reverse the sorting

lowess fällenorm time if ranktot2 ==`newx', bwid(0.05) gen(y`newx') nograph
    
gen ybot`newx' =  `newx'/ 4     // squish the axis

gen ytop`newx' = y`newx' + ybot`newx'

colorpalette HCL Heat, n(`items') nograph

local mygraph `mygraph' rarea  ytop`newx' ybot`newx' time, fc("`r(p`newx')'%75")  lc(white)  lw(thin) || 
  
replace ypoint= (ybot`newx' + 1/16) if xpoint!=. & ranktot2 ==`newx' 

}

sort time 

summ time 
local x1 = `r(min)'
local x2 = `r(max)'


twoway  ///
`mygraph'  ///
(scatter ypoint xpoint, mcolor(white) msize(zero) msymbol(point) ///
mlabel(ranktot2) mlabsize(*0.6) mlabcolor(black)) ///
, ///
xlabel(`x1'(10)`x2', nogrid labsize(tiny) angle(vertical)) ///
ylabel(,nolabels noticks nogrid) yscale(noline)  ytitle("") xtitle("") ///
legend(off) ///
plotregion(margin(zero)) ///
title("Covid19-'Fälle' in Deutschland nach Bundesland", size(small)) 



