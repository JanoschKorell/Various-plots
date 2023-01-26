



	
clear

capture log close
cd $data/
log using $lofi/RosePlots, replace
set more off, perm
numlabel _all, add force


use ESS/ESS9.dta

*https://de.exchange-rates.org 31.12.2018 

*2.5 Bildung				
*Highest level of Education ISCED
tab eisced			//49,245 Gültige Werte
					//Ausschluss von 167 Fällen, die "Other" angeben
gen BildungsstufeQuasimetr = eisced if eisced <= 7 //Missings
recode BildungsstufeQuasimetr (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6)
lab de BildungsstufeQuasimetr 0 " less than lowerSecondary" 1 "lowerSecondary" 2 "lower upper secondary" 3 "upper upper secondary" 4 "advanced vocational" 5 "lower tertiary" 6 "higher tertiary"
tab BildungsstufeQuasimetr, m		
			
*Dreiteilung nach Eurostat: https://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=edat_lfse_04&lang=en
	*0-2 *3-4 *5-6
recode BildungsstufeQuasimetr (0=1) (1=1) (2=1) (3=2) (4=2) (5=3) (6=3), gen (BildungsstufeDreiteilung)
label def BildungsstufeDreiteilung 1 "Bildung Niedrig" 2 "Bildung Mittel" 3 "Bildung Hoch"
label values BildungsstufeDreiteilung BildungsstufeDreiteilung
tab BildungsstufeDreiteilung, m








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
tab Land





tab infqbst			//42,340 gültige Werte
					//1 Weekly
					//2 Monthly
					//3 Annual

sum hinctnta		//39,865 Gültige Werte
sum grspnum			//18,271 Gültige Werte
sum netinum			//32,837 Gültige Werte
tab netinum, m		// Not applicable 4,695
sum netinum if infqbst == 1
sum netinum if infqbst == 2
sum netinum if infqbst == 3
gen Einkommen = .
replace Einkommen = netinum if infqbst == 2
replace Einkommen = netinum * 4 if infqbst == 1
replace Einkommen = netinum / 12 if infqbst == 3
tab Einkommen
sum Einkommen, d	//Muss nach Perzentilen pro Land programmiert werden!
					//Dezile
					tab agea if Einkommen == .
					//Missings können nicht auf das Alter zurückgeführt werden.


replace Einkommen = . if Einkommen == .a | Einkommen == .b | Einkommen == .c | Einkommen == .d


keep BildungsstufeDreiteilung  Land Einkommen
sort BildungsstufeDreiteilung Land Einkommen
drop if Einkommen == .

keep if BildungsstufeDreiteilung == 1 | BildungsstufeDreiteilung == 2 | BildungsstufeDreiteilung == 3


collapse (count) freq=Einkommen (p50) p50=Einkommen, by(BildungsstufeDreiteilung Land)
ren p50 Einkommen
drop freq

decode Land, gen(cntry)


gen euronicht = .
replace euronicht = 1 if cntry == "PL" | cntry == "BG" | cntry == "CZ" | cntry == "DK" | cntry == "CH" | cntry == "GB" | cntry == "SE"  ///
| cntry == "HR" | cntry == "NO" | cntry == "IS" | cntry == "HU" | cntry == "RS"

sort Land BildungsstufeDreiteilung  euronicht

gen check = 1
egen tag = total(check), by(Land)
keep if tag == 3
drop check  tag



gen umrechnung =.
replace umrechnung = 0.51129 	if cntry == "PL"
replace umrechnung = 0.23219 	if cntry == "BG"
replace umrechnung = 0.03879 	if cntry == "CZ"
replace umrechnung = 0.1339 	if cntry == "DK"
replace umrechnung = 0.8874 	if cntry == "CH"
replace umrechnung = 1.109 		if cntry == "GB"
replace umrechnung = 0.09728 	if cntry == "SE"
replace umrechnung = 0.13453 	if cntry == "HR"
replace umrechnung = 0.10012 	if cntry == "NO"
replace umrechnung = 0.00749 	if cntry == "IS"
replace umrechnung = 0.00311 	if cntry == "HU"
replace umrechnung = 0.00842 	if cntry == "RS"

replace Einkommen = Einkommen * umrechnung if euronicht == 1

drop umrechnung  euronicht



*4.2 BIP/Kopf
*In tausend
gen BipKopf2 = .
replace BipKopf2 = 35  if Land == 0
replace BipKopf2 = 34 if Land == 1
replace BipKopf2 = 6 if Land == 2
replace BipKopf2 = 61 if Land == 3
replace BipKopf2 = 24 if Land == 4
replace BipKopf2 = 17 if Land == 5
replace BipKopf2 = 34 if Land == 6
replace BipKopf2 = 48 if Land == 7
replace BipKopf2 = 15 if Land == 8
replace BipKopf2 = 22 if Land == 9
replace BipKopf2 = 36 if Land == 10
replace BipKopf2 = 31 if Land == 11
replace BipKopf2 = 33 if Land == 12
replace BipKopf2 = 12 if Land == 13
replace BipKopf2 = 13 if Land == 14
replace BipKopf2 = 63 if Land == 15
replace BipKopf2 = 36 if Land == 16
replace BipKopf2 = 25 if Land == 17
replace BipKopf2 = 14 if Land == 18
replace BipKopf2 = 12 if Land == 19
replace BipKopf2 = 5 if Land == 20
replace BipKopf2 = 40 if Land == 21
replace BipKopf2 = 69 if Land == 22
replace BipKopf2 = 13 if Land == 23
replace BipKopf2 = 17 if Land == 24
replace BipKopf2 = 5 if Land == 25
replace BipKopf2 = 43 if Land == 26
replace BipKopf2 = 20 if Land == 27
replace BipKopf2 = 15 if Land == 28
tab BipKopf2





sort BipKopf2 Land
egen rank = group(BipKopf2 Land)

gen LandRank = .
replace LandRank = rank
labmask LandRank , values(cntry)

drop Land rank cntry


ren LandRank order 
ren BildungsstufeDreiteilung w
ren Einkommen val
order order w val

sort order w


egen rank = rank(val), by(order)




gen check = .


// Übereinstimmung zweier Variablen

levelsof w, local(lvls)

foreach x of local lvls  { 

	replace check = 1 if rank == `x' & w == `x'

}


drop rank check BipKopf2






global r = 5  // define a radius (can be any number)




// generate the radius


gen height = sqrt(val * 29 / _pi)
drop val


summ height
gen radius = (height / r(max)) * $r   
drop height

// generate the angle


levelsof w
display _N / `r(r)'
gen theta = (1 / (_N / `r(r)')) * 2 * -_pi 

gen angle = .




sort  w order
sum order

forval i = 1/`r(max)' {

 by w: replace angle = sum(theta) if order <= `i'  
 
}

 
drop theta










// generate the end points of the pie in polar coordinates

sort order

gen x =  radius * cos(angle) 
gen y =  radius * sin(angle)


// rotation matrix


local ro = 210 * _pi / 180


replace angle = angle + `ro' 
gen xhat =  x * cos(`ro') - y * sin(`ro')
gen yhat =  x * sin(`ro') + y * cos(`ro')




**** lets keep the rotated values


drop x y

ren xhat x
ren yhat y


sort w order


local items = _N
display `items'

sum order
local maxval = `r(max)' + 1
display `maxval'

expand 2 if order==1
replace order = `maxval' if _n > `items'

gen id = 1



reshape wide x y  radius angle, i(id w) j(order)



save rose/abschnitt.dta, replace




use rose/abschnitt.dta, clear



expand 3
sort w
bysort w: gen serial = _n
order w serial


forval i = 1/29 { 


// add the intercept dummy for the pie
replace x`i' = 0 if serial==1  
replace y`i' = 0 if serial==1

// pick the ending point from the next arc


local j = `i' + 1
replace x`i' = x`j' * radius`i' / radius`j' if serial==3
replace y`i' = y`j' * radius`i' / radius`j' if serial==3

recode x`i' (.=0) if serial==3  // for division with zero
recode y`i' (.=0) if serial==3
 
 }







****** get the arc right


gen marker0 = 0 in 1 // identify the origin.

// expand the rows = 100 * categories



levelsof w
local obsnew = _N + 100 * `r(r)'
set obs  `obsnew'  // points for the arc


replace w = 1 in  10/109   // this is not automated
replace w = 2 in 110/209   // mostly due to laziness
replace w = 3 in 210/309

tab w


gen half = .

replace half = 1 in  10/60   // also not automated
replace half = 1 in 110/160  // same reason as above
replace half = 1 in 210/260

replace half = 2 if half==.


// extend the identifiers

order w serial half


sort w serial
carryforward radius*, replace




levelsof w, local(lvls)

foreach k of local lvls {

forval i = 1/29 {

cap drop x`i'_temp
cap drop y`i'_temp
*cap drop zone`i'_temp


qui gen x`i'_temp = .
qui gen y`i'_temp = .


display "Layer `k': Wedge `i'"
display "positive half top"

summ y`i' if y`i' != 0 & w==`k'


if `r(min)' >= 0 & `r(max)' >= 0 {  
  sum x`i' if x`i' != 0 & w==`k'
  replace x`i'_temp = runiform(`r(min)' , `r(max)')   if w==`k' 
  replace y`i'_temp =  sqrt((radius`i')^2 - (x`i'_temp)^2) if w==`k' 

  replace x`i' = x`i'_temp if x`i'==. & w==`k'
  replace y`i' = y`i'_temp if y`i'==. & w==`k'
  
  
 }
 
 display "negative half bottom"
 
 else if `r(min)' < 0 & `r(max)' < 0 {  
  sum x`i' if x`i' != 0  & w==`k'
  replace x`i'_temp = runiform(`r(min)' , `r(max)')   if w==`k' 
  replace y`i'_temp =  -sqrt((radius`i')^2 - (x`i'_temp)^2) if w==`k' 
  
  replace x`i' = x`i'_temp if x`i'==.  & w==`k'
  replace y`i' = y`i'_temp if y`i'==.  & w==`k'
  
  
  }
  
  
	display "positive to negative"
	else if `r(min)' < 0 & `r(max)' >= 0 { 
	
	sum x`i' if x`i' != 0 & y`i' >= 0 & w==`k'
  
    if `r(min)' < 0 {
    replace x`i'_temp = runiform(-1 * radius`i', `r(min)') if half==1 & w==`k'
    }
  
  
	else {
    replace x`i'_temp = runiform(`r(min)', radius`i')    if half==1 & w==`k'
    } 
  
	replace y`i'_temp =   sqrt((radius`i')^2 - (x`i'_temp)^2)   if half==1 & w==`k'
  
	sum x`i' if x`i' != 0 & y`i' < 0 & w==`k'
  
    if `r(min)' < 0 {
    replace x`i'_temp = runiform(-radius`i', `r(min)')    if half==2 & w==`k'
    }
  
	else {
    replace x`i'_temp = runiform(`r(min)', radius`i')     if half==2 & w==`k' 
    } 
  
  
	replace y`i'_temp =   -sqrt((radius`i')^2 - (x`i'_temp)^2)    if half==2 & w==`k' 
  
	replace x`i' = x`i'_temp if x`i'==. & w==`k'
	replace y`i' = y`i'_temp if y`i'==. & w==`k'
	
	
	  
 }
}    
}
	
drop half
drop *temp
	
	


	
	
	
	
	
	
	

	
	
	
	
	
	
	
// two things need to be done
// all pie slices need to be sorted in ascending order
// the sorting has to depend on the longest axis   
	
	
	
drop id 
drop marker0  
bysort w: gen id = _n
	
reshape long  x y angle radius, i(id w) j(arc)  // here j is a variable name we create  
	
	
gen marker0 = 1 if x==0    
drop id   
sort arc marker0
	
gen sortme = .
	
	
// sorting based on the rules
	
levelsof   w, local(ws)
levelsof arc, local(lvls)
	
	
	
foreach x of local lvls {
foreach y of local  ws { 
	
	summ x if arc==`x' & w==`y'
	
	
if `r(max)'> 0 & `r(min)' < 0 {
   replace sortme = x if arc==`x' & w==`y'
    }
  else {
   replace sortme = y if arc==`x' & w==`y'
	
	
   }
  }  
}   
  	
	
	
sort w arc marker0 sortme 
drop marker0  
	
	
by w arc: gen id = _n  // dont use bysort here
	
reshape wide x y sortme  angle radius serial, i(id w) j(arc)
	
	
	


// add pie labels


	
cap drop xlab* ylab*	
	
forval x = 1/29 {
	

	
	summ radius`x' 

	
	local labrad =  `r(max)' + 0.5 //  push out the labels 


	local y = `x' + 1


	gen xlab`x' =  `labrad' * cos((angle`x' + angle`y')/2) in 1
	gen ylab`x' =  `labrad' * sin((angle`x' + angle`y')/2) in 1  


}




// the last pie  
replace ylab29 = ylab29 * -1.2
replace xlab29 = xlab29 * -1.2

*replace ylab10 = ylab10 * 1.2
*replace xlab10 = xlab10 * 1.2

  
**** pie with labels
  
local areagraph1
local areagraph2
local areagraph3
local areagraph4
local labs
  
  
forval i = 1/29 {
 local areagraph1 `areagraph1' (area y`i' x`i' if w==1, nodropbase fc(pink%60) lc(black) lw(vvthin)) ||
 local areagraph2 `areagraph2' (area y`i' x`i' if w==2, nodropbase fc(gs10%60) lc(black) lw(vvthin)) ||
 local areagraph3 `areagraph3' (area y`i' x`i' if w==3, nodropbase fc(eltblue%60) lc(black) lw(vvthin)) || 
 local labs   `labs'   (scatter ylab`i' xlab`i') ||
  
  }
  
  
twoway ///
`areagraph3' ///
`areagraph2' ///
`areagraph1' ///
`labs'   ///
, aspect(1) legend(off)  ///
  xlabel(, nogrid) ylabel(, nogrid) ///
  xscale(off) yscale(off) ///
  title("{fontface Arial Bold: My first custom rose plot}")
  
  








  
  
  
  
 
cap drop lab*
  
forval i = 1/29 {
 gen lab`i' = `i' in 1
 lab val lab`i' marklab 
 }
  
  
gen px = .
gen py = .
gen pval = ""
  
replace px = 0 in 1   
replace py = 4 in 1

 

  
lab de marklab ///
1   "ME 5"  ///
2   "RS 5"   ///
3   "BG 6"   ///
4   "HR 12"   ///
5   "LV 12"   ///
6   "HU 13"  ///
7   "PL 13"  ///
8   "LT 14"  ///
9   "EE 15"  ///
10  "SK 15"  ///
11  "CZ 17"  ///
12  "PT 17"  ///
13  "SI 20" ///
14  "ES 22" ///
15  "CY 24" ///
16  "IT 25" ///
17  "FR 31" ///
18  "GB 33" ///
19  "BE 34" ///
20  "DE 34" ///
21  "AT 35" ///
22  "FI 36" ///
23  "IS 36" ///
24  "NL 40" ///
25  "SE 43" ///
26  "DK 48" ///
27  "CH 61" ///
28  "IE 63" ///
29  "NO 69", ///
replace
  
/*
  
lab de marklab ///
1   "CZ 2.2%"  ///
2   "IS 3.6%"   ///
3   "GB 4.4%"  ///
4   "SI 4.8%"  ///
5   "CH 4.9%"  ///
6   "AT 5.3%" ///
7   "PT 6.3%" ///
8   "HR 7.1%" ///
9   "FI 7.2%" ///
10  "SE 8%" ///
11  "ME 15.9", ///
replace
*/
  
  
cd $grafi/Rose
  
  
local areagraph1
local areagraph2
local areagraph3
local labs


forval i = 1/29 {


local areagraph1 `areagraph1' (area y`i' x`i' if w==1, nodropbase fi(100) fc("130 130 130%90") lc(white) lw(vthin)) ||
local areagraph2 `areagraph2' (area y`i' x`i' if w==2, nodropbase fi(100) fc("255 160 170%60") lc(white) lw(vthin)) ||
local areagraph3 `areagraph3' (area y`i' x`i' if w==3, nodropbase fi(100) fc("135 192 230%40") lc(white) lw(vthin)) ||



summ angle`i' 
local angle = (`r(mean)'  * (180 / _pi))  - 102
local labs `labs' (scatter ylab`i' xlab`i', mc(none) mlabel(lab`i') mlabangle(`angle')  mlabpos(0) mlabcolor(black) mlabsize(1.2))  
}
  
  
  
*** final graph here
  
  
twoway ///
`areagraph3'  ///
`areagraph2'  ///
`areagraph1'  ///
`labs'   ///
(scatter py px, mc(none) mlabel(pval) mlabpos(0) mlabcolor(black) mlabsize(2)) ///
, legend(order(1 "Bildung hoch" 30 "Bildung mittel" 59 "Bildung niedrig") pos(5) rows(1) ring(0)   size(1.5))  ///
xlabel(-5(1)5, nogrid) ylabel(-5(1)5, nogrid) ///
xscale(off) yscale(off) ///
xsize(1) ysize(1) aspect(1)  ///
title("MEDIANEINKOMMEN (EURO) NACH BILDUNG IN EUROPA", size(2.8)) ///
subtitle("GEORDNET NACH BIP PRO KOPF IN TAUSEND", size(2.2)) ///
note("Datenquelle: ESS9", size(tiny))
graph export "Roseplot - Medianeinkommen nach BIP in Europa.jpg", replace as(png) width(4600)
  
  
  
  
  
   
  
/*



replace iincsrc = . if iincsrc == .a | iincsrc == .b | iincsrc == .c | iincsrc == .d

******************************
*2.6 Hauptquelle des Einkommens: Sozialleistung
tab iincsrc, m		//37,709 Gültige Fälle
					//11,810 Missings
					//1-3 Lohn oder Selbstständig
					//7 Investments
					//8 Anderes
					//9 Kein Einkommen
					//4 Rente
					//5 Arbeitslosigkeitsunterstützung
					//6 Andere Sozialleistung
recode iincsrc (1 = 1) (2 = 2) (3 = 2) (4 = 3) (5 = 4) (6 = 4) (7 = 5) (8 = 6) (9 = 7) (. = 8), gen (Einkommensart)
lab de Einkommensart 1 "Lohn" 2 "Selbständig" 3 "Renten" 4 "Sozialeinkommen" 5 "Investitionen" 6 "Anderes" 7 "Kein Einkommen" 8 "Keine Angabe"
lab val Einkommensart Einkommensart
tab Einkommensart, m

order  Einkommensart


keep if Einkommensart == 1 | Einkommensart == 2 | Einkommensart == 3 | Einkommensart == 4



gen Arbeitslosigkeitsquote = .
replace Arbeitslosigkeitsquote = 5.3 if Land == 0
replace Arbeitslosigkeitsquote = 5.9 if Land == 1
replace Arbeitslosigkeitsquote = 5.0 if Land == 2
replace Arbeitslosigkeitsquote = 4.9 if Land == 3
replace Arbeitslosigkeitsquote = 6.4 if Land == 4
replace Arbeitslosigkeitsquote = 2.2 if Land == 5
replace Arbeitslosigkeitsquote = 3.2 if Land == 6
replace Arbeitslosigkeitsquote = 5.0 if Land == 7
replace Arbeitslosigkeitsquote = 5.0 if Land == 8
replace Arbeitslosigkeitsquote = 14.1 if Land == 9
replace Arbeitslosigkeitsquote = 7.2 if Land == 10
replace Arbeitslosigkeitsquote = 7.5 if Land == 11
replace Arbeitslosigkeitsquote = 4.4 if Land == 12
replace Arbeitslosigkeitsquote = 7.1 if Land == 13
replace Arbeitslosigkeitsquote = 3.8 if Land == 14
replace Arbeitslosigkeitsquote = 5.1 if Land == 15
replace Arbeitslosigkeitsquote = 3.6 if Land == 16
replace Arbeitslosigkeitsquote = 9.2 if Land == 17
replace Arbeitslosigkeitsquote = 6.0 if Land == 18
replace Arbeitslosigkeitsquote = 7.3 if Land == 19
replace Arbeitslosigkeitsquote = 15.9 if Land == 20
replace Arbeitslosigkeitsquote = 3.8 if Land == 21
replace Arbeitslosigkeitsquote = 3.6 if Land == 22
replace Arbeitslosigkeitsquote = 3.0 if Land == 23
replace Arbeitslosigkeitsquote = 6.3 if Land == 24
replace Arbeitslosigkeitsquote = 9.1 if Land == 25
replace Arbeitslosigkeitsquote = 8.0 if Land == 26
replace Arbeitslosigkeitsquote = 4.8 if Land == 27
replace Arbeitslosigkeitsquote = 6.3 if Land == 28
tab Arbeitslosigkeitsquote



replace rank = 3 if order ==1 & w == 3
replace rank = 4 if order ==1 & w == 4

replace rank = 3 if order ==19 & w == 3
replace rank = 4 if order ==19 & w == 4




/// NEU!!!
egen total = total(check), by(order)

drop if total != 4

egen rank2 = group(BipKopf2 order)
drop order rank check total
ren rank2 order


sort order w



replace w = 1 in  17/116   // this is not automated
replace w = 2 in 117/216   // mostly due to laziness
replace w = 3 in 217/316
replace w = 4 in 317/416

tab w


gen half = .

replace half = 1 in  17/67   // also not automated
replace half = 1 in 117/167  // same reason as above
replace half = 1 in 217/267
replace half = 1 in 317/367




*/
  
  
  
/*





	
	
clear

capture log close
cd $data/rose
log using $lofi/RosePlots, replace
set more off, perm
numlabel _all, add force


import excel using "https://github.com/rladies/spain_nightingale/blob/master/datos_florence.xlsx?raw=true", clear


drop in 1


ren A date
ren B size
ren C zymotic
ren D wounds
ren E other
ren F zymotic_rate
ren G wounds_rate
ren H other_rate



drop in 1
*** clean the date


gen month = month(date(substr(date,1,3), "M"))
gen year =   year(date(substr(date,5,4), "Y"))



ren date date_str
gen date = mdy(month,1,year)
format date %tdMon-yy


drop month year



destring _all, replace


*** wheels


gen wheel = .

replace wheel = 1 if  date <= -38291
recode wheel (. = 2)


order wheel date_str date


compress
save nightingale.dta, replace






global r = 5  // define a radius (can be any number)



use nightingale.dta, clear

keep if wheel == 1


gen order = _n
order order


labmask order, val(date_str)


// other (black), wounds (red), zymotic (blue)


replace wounds_rate  = wounds_rate  + 0.01 if wounds_rate  == 0
replace zymotic_rate = zymotic_rate + 0.01 if zymotic_rate  == 0
replace other_rate   = other_rate   + 0.01 if other_rate  == 0



gen val1 = other_rate
gen val2 = wounds_rate
gen val3 = zymotic_rate



// just keep what we need
keep order val*




reshape long val, i(order) j(w)


// generate the radius


gen height = sqrt(val * 12 / _pi)
drop val


summ height
gen radius = (height / r(max)) * $r   
drop height

// generate the angle


levelsof w
display _N / `r(r)'
gen theta = (1 / (_N / `r(r)')) * 2 * -_pi 

gen angle = .




sort w order
sum order

forval i = 1/`r(max)' {

 by w: replace angle = sum(theta) if order <= `i'  
 
}

 
drop theta






// generate the end points of the pie in polar coordinates



gen x =  radius * cos(angle) 
gen y =  radius * sin(angle)


// rotation matrix


local ro = 210 * _pi / 180


replace angle = angle + `ro' 
gen xhat =  x * cos(`ro') - y * sin(`ro')
gen yhat =  x * sin(`ro') + y * cos(`ro')




**** lets keep the rotated values


drop x y

ren xhat x
ren yhat y


sort w order


local items = _N
display `items'

sum order
local maxval = `r(max)' + 1
display `maxval'

expand 2 if order==1
replace order = `maxval' if _n > `items'

gen id = 1

reshape wide x y radius angle, i(id w) j(order)


expand 3  
sort w
bysort w: gen serial = _n
order w serial


forval i = 1/12 { 


// add the intercept dummy for the pie
replace x`i' = 0 if serial==1  
replace y`i' = 0 if serial==1

// pick the ending point from the next arc


local j = `i' + 1
replace x`i' = x`j' * radius`i' / radius`j' if serial==3
replace y`i' = y`j' * radius`i' / radius`j' if serial==3

recode x`i' (.=0) if serial==3  // for division with zero
recode y`i' (.=0) if serial==3
 
 }





****** get the arc right


gen marker0 = 0 in 1 // identify the origin.

// expand the rows = 100 * categories



levelsof w
local obsnew = _N + 100 * `r(r)'
set obs  `obsnew'  // points for the arc


replace w = 1 in  10/109   // this is not automated
replace w = 2 in 110/209   // mostly due to laziness
replace w = 3 in 210/309

tab w


gen half = .

replace half = 1 in  10/60   // also not automated
replace half = 1 in 110/160  // same reason as above
replace half = 1 in 210/260

replace half = 2 if half==.


// extend the identifiers

order w serial half


sort w serial
carryforward radius*, replace




levelsof w, local(lvls)

foreach k of local lvls {
forval i = 1/12 {

cap drop x`i'_temp
cap drop y`i'_temp
*cap drop zone`i'_temp


qui gen x`i'_temp = .
qui gen y`i'_temp = .


display "Layer `k': Wedge `i'"
display "positive half top"

summ y`i' if y`i' != 0 & w==`k'


if `r(min)' >= 0 & `r(max)' >= 0 {  
  sum x`i' if x`i' != 0 & w==`k'
  replace x`i'_temp = runiform(`r(min)' , `r(max)')   if w==`k' 
  replace y`i'_temp =  sqrt((radius`i')^2 - (x`i'_temp)^2) if w==`k' 

  replace x`i' = x`i'_temp if x`i'==. & w==`k'
  replace y`i' = y`i'_temp if y`i'==. & w==`k'
  
  
 }
 
 display "negative half bottom"
 
 else if `r(min)' < 0 & `r(max)' < 0 {  
  sum x`i' if x`i' != 0  & w==`k'
  replace x`i'_temp = runiform(`r(min)' , `r(max)')   if w==`k' 
  replace y`i'_temp =  -sqrt((radius`i')^2 - (x`i'_temp)^2) if w==`k' 
  
  replace x`i' = x`i'_temp if x`i'==.  & w==`k'
  replace y`i' = y`i'_temp if y`i'==.  & w==`k'
  
  
  }
  
  
	display "positive to negative"
	else if `r(min)' < 0 & `r(max)' >= 0 { 
	
	sum x`i' if x`i' != 0 & y`i' >= 0 & w==`k'
  
    if `r(min)' < 0 {
    replace x`i'_temp = runiform(-1 * radius`i', `r(min)') if half==1 & w==`k'
    }
  
  
	else {
    replace x`i'_temp = runiform(`r(min)', radius`i')    if half==1 & w==`k'
    } 
  
	replace y`i'_temp =   sqrt((radius`i')^2 - (x`i'_temp)^2)   if half==1 & w==`k'
  
	sum x`i' if x`i' != 0 & y`i' < 0 & w==`k'
  
    if `r(min)' < 0 {
    replace x`i'_temp = runiform(-radius`i', `r(min)')    if half==2 & w==`k'
    }
  
	else {
    replace x`i'_temp = runiform(`r(min)', radius`i')     if half==2 & w==`k' 
    } 
  
  
	replace y`i'_temp =   -sqrt((radius`i')^2 - (x`i'_temp)^2)    if half==2 & w==`k' 
  
	replace x`i' = x`i'_temp if x`i'==. & w==`k'
	replace y`i' = y`i'_temp if y`i'==. & w==`k'
	
	
	  
 }
}    
}
	
drop half
drop *temp
	
	
	
	
// two things need to be done
// all pie slices need to be sorted in ascending order
// the sorting has to depend on the longest axis   
	
	
	
drop id 
drop marker0  
bysort w: gen id = _n
	
reshape long  x y angle radius, i(id w) j(arc)  // here j is a variable name we create  
	
	
gen marker0 = 1 if x==0    
drop id   
sort arc marker0
	
gen sortme = .
	
	
// sorting based on the rules
	
levelsof   w, local(ws)
levelsof arc, local(lvls)
	
	
	
foreach x of local lvls {
foreach y of local  ws { 
	
	summ x if arc==`x' & w==`y'
	
	
if `r(max)'> 0 & `r(min)' < 0 {
   replace sortme = x if arc==`x' & w==`y'
    }
  else {
   replace sortme = y if arc==`x' & w==`y'
	
	
   }
  }  
}   
  	
	
	
sort w arc marker0 sortme 
drop marker0  
	
	
by w arc: gen id = _n  // dont use bysort here
	
reshape wide x y sortme angle radius serial, i(id w) j(arc)
	
	
	


// add pie labels


	
cap drop xlab* ylab*	
	
forval x = 1/12 {
	
summ radius`x' if w==3

if `x' <= 3 {
  local labrad =  `r(min)' + 0.8 //  push out the labels 
  }
  else {
  local labrad =  `r(min)' + 0.25    //  
   }
   
   local y = `x' + 1 
   
   
	gen xlab`x' =  `labrad' * cos((angle`x' + angle`y')/2) in 1
	gen ylab`x' =  `labrad' * sin((angle`x' + angle`y')/2) in 1  
  
  
    }
  
  // the last pie  
 replace ylab12 = ylab12 * -1
 replace xlab12 = xlab12 * -1
  
  
**** pie with labels
  
local areagraph1
local areagraph2
local areagraph3
local labs
  
  
forval i = 1/12 {
 local areagraph1 `areagraph1' (area y`i' x`i' if w==1, nodropbase fc(pink%60) lc(black) lw(vvthin)) ||
 local areagraph2 `areagraph2' (area y`i' x`i' if w==2, nodropbase fc(gs10%60) lc(black) lw(vvthin)) ||
 local areagraph3 `areagraph3' (area y`i' x`i' if w==3, nodropbase fc(eltblue%60) lc(black) lw(vvthin)) || 
 local labs   `labs'   (scatter ylab`i' xlab`i') ||
  
  }
  
  
twoway ///
`areagraph3' ///
`areagraph2' ///
`areagraph1' ///
`labs'   ///
, aspect(1) legend(off)  ///
  xlabel(, nogrid) ylabel(, nogrid) ///
  xscale(off) yscale(off) ///
  title("{fontface Arial Bold: My first custom rose plot}")
  
  
  
  
  
  
  
  
  
  
lab de marklab ///
1   "APRIL 1854"  ///
2   "MAY"   ///
3   "JUNE"   ///
4   "JULY"   ///
5   "AUGUST"   ///
6   "SEPTEMBER"  ///
7   "OCTOBER"  ///
8   "NOVEMBER"  ///
9   "DECEMBER"  ///
10   "JANUARY"  ///
11   "FEBRUARY"  ///
12   "MARCH 1855", ///
replace
  
  
  
cap drop lab*
  
forval i = 1/12 {
 gen lab`i' = `i' in 1
 lab val lab`i' marklab 
 }
  
  
gen px = .
gen py = .
gen pval = ""
  
replace px = 0 in 1   
replace py = 3 in 1
replace pval = "{bf:APRIL 1854} to {bf:MARCH 1855}" in 1
  
  
local areagraph1
local areagraph2
local areagraph3
local labs






forval i = 1/12 {

 local areagraph1 `areagraph1' (area y`i' x`i' if w==1, nodropbase fi(100) fc("130 130 130%40") lc(white) lw(vthin)) ||
 local areagraph2 `areagraph2' (area y`i' x`i' if w==2, nodropbase fi(100) fc("255 160 170%80") lc(white) lw(vthin)) ||
 local areagraph3 `areagraph3' (area y`i' x`i' if w==3, nodropbase fi(100) fc("135 192 230%60") lc(white) lw(vthin)) ||
  
 summ angle`i' 
 local angle = (`r(mean)'  * (180 / _pi))  - 102
 local labs `labs' (scatter ylab`i' xlab`i', mc(none) mlabel(lab`i') mlabangle(`angle')  mlabpos(0) mlabcolor(black) mlabsize(1.2))  
}
  
  
  
*** final graph here
  
  
twoway ///
`areagraph3'  ///
`areagraph2'  ///
`areagraph1'  ///
`labs'   ///
(scatter py px, mc(none) mlabel(pval) mlabpos(0) mlabcolor(black) mlabsize(2)) ///
, legend(order(1 "Preventable" 13 "Wounds" 25 "Other") pos(5) cols(1) ring(0) size(1.5))  ///
xlabel(-5(1)5, nogrid) ylabel(-5(1)5, nogrid) ///
xscale(off) yscale(off) ///
xsize(1) ysize(1) aspect(1)  ///
title("{bf:DIAGRAM} OF THE {bf:CAUSES} OF {bf:MORTALITY}", size(2.8)) ///
subtitle("IN THE {bf:ARMY} IN THE {bf:EAST}", size(2.2)) ///
  
  
  
  
 */
  
  
  
  
  
  
  
  
  
  
  
  
  
  


  
  
  
  
  
  
  
 







