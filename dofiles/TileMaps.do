





clear

capture log close
cd $data
log using $lofi/TileMaps, replace
set more off, perm
numlabel _all, add force


********************************************************************************
****		                 Tile Map 1									    ****
********************************************************************************



use ESS/ESS9.dta

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


keep DichAVGleichheit Land 
keep  if DichAVGleichheit == 0 | DichAVGleichheit == 1


collapse (mean) DichAVGleichheit, by(Land)

decod Land, gen(country)


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
label def Wohlfahrtsstaaten 2 "Bismarck/Konservativer WS", modify	
label def Wohlfahrtsstaaten 3 "Skandinavischer/Sozialdemokratischer WS", modify	
label def Wohlfahrtsstaaten 4 "Mediterraner WS", modify	
label def Wohlfahrtsstaaten 5 "Osten", modify	


gen ctry = .
replace ctry = 1 if country=="IS"
replace ctry = 2 if country=="NO"
replace ctry = 3 if country=="SE"
replace ctry = 4 if country=="FI"
replace ctry = 5 if country=="IE"
replace ctry = 6 if country=="GB"
replace ctry = 7 if country=="DK"
replace ctry = 8 if country=="BE"
replace ctry = 9 if country=="NL"
replace ctry = 10 if country=="DE"
replace ctry = 11 if country=="LT"
replace ctry = 12 if country=="LV"  
replace ctry = 13 if country=="EE"
replace ctry = 14 if country=="FR"
replace ctry = 15 if country=="CH"
replace ctry = 16 if country=="AT"
replace ctry = 17 if country=="PL"
replace ctry = 18 if country=="CZ"
replace ctry = 19 if country=="SK"
replace ctry = 20 if country=="PT"
replace ctry = 21 if country=="ES"
replace ctry = 22 if country=="IT"
replace ctry = 23 if country=="SI"
replace ctry = 24 if country=="HU"
replace ctry = 25 if country=="HR"
replace ctry = 26 if country=="ME"
replace ctry = 27 if country=="RS"
replace ctry = 28 if country=="BG"
replace ctry = 29 if country=="CY"

labmask ctry, val(country)



// expand the observations

levelsof country
local items `r(r)'

// define the dots
local rows =  10   

// row dots
local cols  = 10   

// col dots
local obsv = `cols' * `rows'  

// calculate the total number of rows per group

expand `obsv' 

// generate the dots

bysort country: egen y = seq(), b(`cols')  
                egen x = seq(), t(`cols')
				
				
by country: gen id = _n    
egen tag = tag(country) 
gen dots = .
 
levelsof country, local(lvls)

foreach x of local lvls {
   summ DichAVGleichheit if country=="`x'" & tag==1
   local DichAVGleichheit = `r(mean)'
   
   summ id if country=="`x'"
   replace dots = id <= int(`DichAVGleichheit' * `r(max)')  if country=="`x'"
}



cd $grafi/TileMaps

levelsof ctry, local(lvls)


foreach x of local lvls {

local t : label ctry `x'

colorpalette tableau, nograph 

twoway ///
(scatter y x if dots==1 & Wohlfahrtsstaaten == 1, msize(1.4) mcolor("`r(p1)'%50") mfcolor("`r(p1)'%50") msymbol(circle)) ///
(scatter y x if dots==1 & Wohlfahrtsstaaten == 2, msize(1.4) mcolor("`r(p2)'%50") mlcolor("`r(p2)'%50") msymbol(circle)) ///
(scatter y x if dots==1 & Wohlfahrtsstaaten == 3, msize(1.4) mcolor("`r(p3)'%50") mlcolor("`r(p3)'%50") msymbol(circle)) ///
(scatter y x if dots==1 & Wohlfahrtsstaaten == 4, msize(1.4) mcolor("`r(p4)'%50") mlcolor("`r(p4)'%50") msymbol(circle)) ///
(scatter y x if dots==1 & Wohlfahrtsstaaten == 5, msize(1.4) mcolor("`r(p5)'%50") mlcolor("`r(p5)'%50") msymbol(circle)) ///
if ctry==`x' , ///
ytitle("") yscale(noline) ylabel(1 10, nogrid) ///
xtitle("") xscale(noline) xlabel(1 10, nogrid) ///
title("`t'", margin(small) size(6.6)) ///
aspectratio(1)  ///
legend(position(6) ring(3)) legend(rows(1) size(vsmall)) ///
legend(label(1 "Liberaler WS") label(2 "Konservativer WS") label(3 "Sozialdemokratischer WS") label(4 "Mediterraner WS") label(5 "Osteuropa") size(tiny)) ///
legend(order (1 2 3 4 5)) ///
xscale(off) yscale(off) ///
xsize(1) ysize(1) ///
graphregion(lcolor(black)) ///
name(map`x', replace)
}




grc1leg2 ///
map1  map2  map3  map4  map5  map6  map7  map8  map9 map10 ///
map11 map12 map13 map14 map15 map16 map17 map18 map19 map20 ///
map21 map22 map23 map24 map25 map26 map27 map28 map29 ///
, ///
cols(9) ///
holes( ///
1		3	4	5	6	7	8	9 ///
10	11	12	13	14				18 ///
		21	22	23	24	25	26	27 ///
28	29	30		32	33	34	35	36 ///
37				41	42			///
46	47					52	53	54 ///
55	56	57	58	59			62	63 ///
64				68			71	72 ///
73	74	75	76	77			80	81 ///
82	83	84	85	86			89	90 ///
91	92	93	94	95	96	97		99 ///
) ///
title("Zustimmung zum Gerechtigkeitsprinzip der Gleichheit in Europa", margin(small) size(3.5)) ///
subtitle("Coloriert nach Wohlfahrtsstaaten (Ferrera/Gal) / 1 dot = 1%", size(vsmall)) ///
note("Quelle: ESS9", size(1.25) margin(small)) ///
xsize(1.2) ysize(1) 
graph export "TileMap - Zustimmung zum Gerechtigkeitsprinzip der Gleichheit in Europa.jpg", replace as(png) width(4600)





********************************************************************************
****		                 Tile Map 2									    ****
********************************************************************************


*https://www.kas.de/de/einzeltitel/-/content/wahlbeteiligung-und-wahlverhalten-nach-alter-und-geschlecht-in-deutschland

clear

capture log close
cd $data
log using $lofi/TileMaps, replace
set more off, perm
numlabel _all, add force



import excel  "wahl/wahl.xlsx", firstrow clear


drop if Land == "Bund"
drop if Land == "BE-O"
drop if Land == "BE-W"
drop if Geschlecht == "Summe"
drop if Geburtsjahresgruppe == "Summe"
drop if ErstZweitstimme == 2
encode Geschlecht, gen(sex)
drop  Geschlecht
encode Geburtsjahresgruppe, gen(Alter)
vreverse Alter, gen(AlerRev)
drop Geburtsjahresgruppe

replace Land = "Schleswig-Holstein" if Land == "SH"
replace Land = "Hamburg" if Land == "HH"
replace Land = "Niedersachsen" if Land == "NI"
replace Land = "Nordrhein-Westfalen" if Land == "NW"
replace Land = "Rheinland-Pfalz" if Land == "RP"
replace Land = "Bayern" if Land == "BY"
replace Land = "Mecklenburg-Vorpommern" if Land == "MV"
replace Land = "Thüringen" if Land == "TH"
replace Land = "Baden-Württemberg" if Land == "BW"
replace Land = "Bremen" if Land == "HB"
replace Land = "Brandenburg" if Land == "BB"
replace Land = "Sachsen" if Land == "SN"
replace Land = "Sachsen-Anhalt" if Land == "ST"
replace Land = "Berlin" if Land == "BE"
replace Land = "Saarland" if Land == "SL"
replace Land = "Hessen" if Land == "HE"



encode Land, gen(BL)


replace BL = 1 if Land=="Schleswig-Holstein"
replace BL = 2 if Land=="Niedersachsen"
replace BL = 3 if Land=="Bremen"
replace BL = 4 if Land=="Hamburg"
replace BL = 5 if Land=="Mecklenburg-Vorpommern"
replace BL = 6 if Land=="Nordrhein-Westfalen"
replace BL = 7 if Land=="Sachsen-Anhalt"
replace BL = 8 if Land=="Brandenburg"
replace BL = 9 if Land=="Berlin"
replace BL = 10 if Land=="Saarland"
replace BL = 11 if Land=="Rheinland-Pfalz"
replace BL = 12 if Land=="Hessen"
replace BL = 13 if Land=="Thüringen"
replace BL = 14 if Land=="Sachsen"
replace BL = 15 if Land=="Baden-Württemberg"
replace BL = 16 if Land=="Bayern"

labmask BL, val(Land)

egen Total = total(Summe), by(BL)
gen Prozent = .
replace Prozent = (Summe/Total)*100


gen ProzM = .
gen ProzW = .
replace ProzM = Prozent if sex == 1
replace ProzW = Prozent if sex == 2


order BL ProzM ProzW AlerRev sex


cap drop *norm

summ ProzM
local ProzMmax = 3 * ceil(`r(max)' / 3) 
gen ProzM_norm = (ProzM - 0) / (`ProzMmax' - 0)   

summ ProzW
local ProzWsmax = 3 * ceil(`r(max)' / 3)  
gen ProzW_norm = ((ProzW - 0) / (`ProzWsmax' - 0)) 


order BL ProzM_norm ProzW_norm  

replace ProzW_norm = ProzW_norm * -1




// legend

// store ticks in locals



summ ProzM_norm
 local y3 = 3 * ceil(`r(max)' / 3)  
 local y2 = `y3' * 2 / 3
 local y1 = `y3' * 1 / 3



summ ProzW_norm
 local z3 = 3 * ceil(`r(max)' / 3)  
 local z2 = `z3' * 2 / 3
 local z1 = `z3' * 1 / 3 
 



// draw the graph, style it, and save it in memory

cd $grafi/TileMaps


levelsof BL, local(lvls)


foreach x of local lvls {

local t : label BL `x'

colorpalette hue,  hue(0 -120) chroma(50) luminance(70) nograph saturate(+25)

twoway ///
(area ProzM_norm  AlerRev, fc("`r(p15)'%20") lc("`r(p15)'%75") lwidth(thin)) ///
(area ProzW_norm  AlerRev, fc("`r(p1)'%20") lc("`r(p1)'%75") lwidth(thin)) ///
if BL==`x', ///
xscale(noline) yscale(noline) ///
xlabel(, nolabels noticks glcolor(none)) ///
ylabel(-1 -0.66 -0.33 0 0.33 0.66 1 1.1, nolabels noticks glcolor(none)) ///
xtitle("") ///
title("`t'", ring(0) size(verysmall)) ///
legend(off) ///  //  
plotregion(fcolor(gs15%40)) ///
xsize(1) ysize(1) aspectratio(1) ///
name("st`x'", replace)  
}





graph combine              ///
st1 st2                   ///
st3 st4                   ///
st5 st6 st7 st8 st9 st10 st11 st12 st13 st14       ///
st15 st16                            ///
, ///
cols(5) ///
imargin(tiny) ///
holes( ///
1 2 4 5 ///
6 ///
11 ///
21 22 25 ///
) ///
title("Wahlbeteiligung nach Alter in Prozent pro Bundesland", margin(small) size(5.5)) ///
subtitle("Männlich (blau) and weiblich (rot) / Alter in 5 Jahresschritten ab 18 - 70 und älter", size(2.5))   ///
note("Quelle: Wahlleiter, repräsentative Erhebung", size(1.25) margin(small)) ///
xsize(1.25) ysize(1)
graph export "TileMap - Wahlbeteiligung nach Alter in Prozent pro Bundesland.jpg", replace as(png) width(4600)


































/*

import delim using "https://raw.githubusercontent.com/nytimes/covid-19-data/master/rolling-averages/us-states.csv", clear

gen date2 = date(date, "YMD")
format date2 %tdDD-Mon-yy
drop date
ren date2 date
order date


split geoid, p("-")
drop geoid geoid1
destring geoid2, replace
ren geoid2 fips
order date fips
sort  date fips
xtset date fips  // declare the data to be a panel



cap drop *ma
tssmooth ma cases_ma  = cases_avg_per_100k , window(6 1 0)
tssmooth ma deaths_ma = deaths_avg_per_100k, window(6 1 0)

drop if date < 22462

cap drop storder
gen storder = .

replace storder = 1 if state=="Alaska"
replace storder = 2 if state=="Maine"
replace storder = 3 if state=="Vermont"
replace storder = 4 if state=="New Hampshire"
replace storder = 5 if state=="Washington"
replace storder = 6 if state=="Idaho"
replace storder = 7 if state=="Montana"
replace storder = 8 if state=="North Dakota"
replace storder = 9 if state=="Minnesota"
replace storder = 10 if state=="Wisconsin"
replace storder = 11 if state=="Michigan"
replace storder = 12 if state=="New York"
replace storder = 13 if state=="Rhode Island"
replace storder = 14 if state=="Massachusetts"
replace storder = 15 if state=="Oregon"
replace storder = 16 if state=="Utah"
replace storder = 17 if state=="Wyoming"
replace storder = 18 if state=="South Dakota"
replace storder = 19 if state=="Iowa"
replace storder = 20 if state=="Illinois"
replace storder = 21 if state=="Ohio"
replace storder = 22 if state=="Pennsylvania"
replace storder = 23 if state=="New Jersey"
replace storder = 24 if state=="Connecticut"
replace storder = 25 if state=="California"
replace storder = 26 if state=="Nevada"
replace storder = 27 if state=="Colorado"
replace storder = 28 if state=="Nebraska"
replace storder = 29 if state=="Missouri"
replace storder = 30 if state=="Indiana"
replace storder = 31 if state=="West Virginia"
replace storder = 32 if state=="Virginia"
replace storder = 33 if state=="Maryland"
replace storder = 34 if state=="District of Columbia"
replace storder = 35 if state=="Arizona"
replace storder = 36 if state=="New Mexico"
replace storder = 37 if state=="Kansas"
replace storder = 38 if state=="Arkansas"
replace storder = 39 if state=="Kentucky"
replace storder = 40 if state=="Tennessee"
replace storder = 41 if state=="South Carolina"
replace storder = 42 if state=="North Carolina"
replace storder = 43 if state=="Delaware"
replace storder = 44 if state=="Oklahoma"
replace storder = 45 if state=="Texas"
replace storder = 46 if state=="Louisiana"
replace storder = 47 if state=="Mississippi"
replace storder = 48 if state=="Alabama"
replace storder = 49 if state=="Georgia"
replace storder = 50 if state=="Hawaii"
replace storder = 51 if state=="Florida"

// mask the names as value labels for later


labmask storder, val(state)
label list



cap drop *norm

summ cases_ma
local casesmax = 3 * ceil(`r(max)' / 3) 
gen cases_norm = (cases_ma - 0) / (`casesmax' - 0)   

summ deaths_ma
local deathsmax = 3 * ceil(`r(max)' / 3)  
gen deaths_norm = ((deaths_ma - 0) / (`deathsmax' - 0)) 



replace deaths_norm = deaths_norm * -1


// legend

// part 1: store ticks in locals



summ cases_ma
 local y3 = 3 * ceil(`r(max)' / 3)  
 local y2 = `y3' * 2 / 3
 local y1 = `y3' * 1 / 3



summ deaths_ma
 local z3 = 3 * ceil(`r(max)' / 3)  
 local z2 = `z3' * 2 / 3
 local z1 = `z3' * 1 / 3 


// part 2: make the colors pop a bit more


colorpalette tableau, nograph saturate(+25)


// part 3: draw the graph, style it, and save it in memory




levelsof storder if storder!=1, local(lvls)


foreach x of local lvls {

local t : label storder `x'

colorpalette tableau, nograph saturate(+25)

twoway ///
 (area cases_norm  date, fc("`r(p1)'") lc("`r(p1)'") lwidth(thin)) ///
 (area deaths_norm date, fc("`r(p2)'") lc("`r(p2)'") lwidth(thin)) ///
  if storder==`x', ///
  xscale(noline) yscale(noline) ///
  xlabel(, nolabels noticks glcolor(none)) ///
  ylabel(-1 -0.66 -0.33 0 0.33 0.66 1 1.1, nolabels noticks glcolor(none)) ///
  xtitle("") ///
   title("`t'", ring(0) size(5.8)) ///
   legend(off) ///  //  
   plotregion(fcolor(gs15%40)) ///
   xsize(1) ysize(1) aspectratio(1) ///
   name("st`x'", replace)  
}




graph combine              ///
 st1 st2                   ///
 st3 st4                   ///
 st5 st6 st7 st8 st9 st10 st11 st12 st13 st14       ///
 st15 st16 st17 st18 st19 st20 st21 st22 st23 st24  ///
 st25 st26 st27 st28 st29 st30 st31 st32 st33 st34  /// 
 st35 st36 st37 st38 st39 st40 st41 st42 st43       ///
 st44 st45 st46 st47 st48 st49          ///
 st50 st51                              ///
 , ///
 cols(12) ///
 imargin(tiny) ///
 holes( ///
  2 3 4 5 6 7 8 9 10 11 ///
  13 14 15 16 17 18 19 20 21 22 ///
  25 33 ///
  37 48 ///
  49 60 ///
  61 62 72 ///
  73 74 75 82 83 84 ///
  86 87 88 89 90 91 92 94 95 96 ///
  ) ///
 title("{fontface Arial Bold:COVID-19 in the USA}", margin(small) size(5.5)) ///
 subtitle("Cases (blue) and deaths (orange) per 100k population", size(2.5))   ///
 note("Source: New York Times GitHub repository (https://github.com/nytimes/covid-19-data)", size(1.25) margin(small)) ///
 xsize(1.25) ysize(1)













use GESIS/GESIS.dta, clear


keep inc ps04 land age

decode land , gen(land1)
encode land1, gen(Land)

gen Einkommen = .
replace Einkommen = inc if inc > 0

gen Staatgut = .
replace Staatgut = ps04 if ps04 > 0
recode Staatgut (1 = 1) (2 = 1) (3 = 0) (4 = 0), gen (DichStaatgut)

label def DichStaatgut 0 "Staat funktioniert schlecht" 1 "Staat funktioniert gut", modify	
label values DichStaatgut DichStaatgut


drop if Einkommen > 2300
drop if DichStaatgut == .
drop if age < 0

sort age
twoway ///
(lowess age Einkommen  if DichStaatgut == 1 & Land == 1, lcolor(yellow)) ///
(lowess age Einkommen  if DichStaatgut == 0 & Land == 1, lcolor(red)) ///
(lowess age Einkommen  if DichStaatgut == 1 & Land == 2, lcolor(yellow)) ///
(lowess age Einkommen  if DichStaatgut == 0 & Land == 2, lcolor(red)) ///
(lowess age Einkommen  if DichStaatgut == 1 & Land == 3, lcolor(yellow)) ///
(lowess age Einkommen  if DichStaatgut == 0 & Land == 3, lcolor(red)) ///
(lowess age Einkommen  if DichStaatgut == 1 & Land == 4, lcolor(yellow)) ///
(lowess age Einkommen  if DichStaatgut == 0 & Land == 4, lcolor(red))


twoway ///
(lowess Einkommen age    if Land == 1, lcolor(yellow)) ///
(lowess Einkommen age    if Land == 2, lcolor(yellow)) ///
(lowess Einkommen age    if Land == 3, lcolor(yellow)) ///
(lowess Einkommen age    if Land == 4, lcolor(yellow)) /// 
(lowess Einkommen age    if Land == 5, lcolor(yellow))  ///
(lowess Einkommen age    if Land == 6, lcolor(yellow))  /// 
(lowess Einkommen age    if Land == 7, lcolor(yellow))  ///
(lowess Einkommen age    if Land == 8, lcolor(yellow))  ///
(lowess Einkommen age    if Land == 9, lcolor(yellow))  ///
(lowess Einkommen age    if Land == 10, lcolor(yellow))  ///
(lowess Einkommen age    if Land == 11, lcolor(yellow))  ///
(lowess Einkommen age    if Land == 12, lcolor(yellow))  ///
(lowess Einkommen age    if Land == 13, lcolor(yellow)) /// 
(lowess Einkommen age    if Land == 14, lcolor(yellow))  ///
(lowess Einkommen age    if Land == 15, lcolor(yellow))  ///
(lowess Einkommen age    if Land == 16, lcolor(yellow)) 

norm Einkommen

drop freq
egen freq = count(Einkommen), by(Einkommen)


hist Einkommen, freq

twoway ///
(lowess Einkommen age)

graph box Einkommen 
hist Einkommen














/*


clear


import delim using "https://covid.ourworldindata.org/data/owid-covid-data.csv", clear
gen date2 = date(date, "YMD")
format date2 %tdDD-Mon-yy
drop date
ren date2 date
ren location country
keep iso_code continent country date people_fully_vaccinated population
keep if continent=="Africa"
bysort country: egen last = max(date) if people_fully_vaccinated!=.
keep if date==last
summ date
global dateval: display %tdd_m_y `r(max)'
display "$dateval"
tab country
gen share = people_fully_vaccinated / population
keep country share



// fill in Eritrea

local newobs = _N + 1
set obs `newobs'
replace country = "Eritrea" in `newobs'
replace share   = 0         in `newobs'


// clean up the countriesreplace country = "DR Congo"    if country=="Democratic Republic of Congo" 
replace country = "C. African Rep."  if country=="Central African Republic"
replace country = "Sao Tome"    if country=="Sao Tome and Principe" 
replace country = "Eq. Guinea"  if country=="Equatorial Guinea" 
replace country = "Gambia"      if country=="Gambia, The"


cap drop ctry
gen ctry = .
replace ctry = 1 if country=="Morocco"
replace ctry = 2 if country=="Algeria"
replace ctry = 3 if country=="Tunisia"
replace ctry = 4 if country=="Libya"
replace ctry = 5 if country=="Egypt"
replace ctry = 6 if country=="Senegal"
replace ctry = 7 if country=="Mauritania"
replace ctry = 8 if country=="Mali"
replace ctry = 9 if country=="Niger"
replace ctry = 10 if country=="Chad"
replace ctry = 11 if country=="Sudan"
replace ctry = 12 if country=="Eritrea"  // manually added above
replace ctry = 13 if country=="Cape Verde"
replace ctry = 14 if country=="Gambia"
replace ctry = 15 if country=="Guinea-Bissau"
replace ctry = 16 if country=="Guinea"
replace ctry = 17 if country=="Burkina Faso"
replace ctry = 18 if country=="Nigeria"
replace ctry = 19 if country=="C. African Rep."
replace ctry = 20 if country=="South Sudan"
replace ctry = 21 if country=="Ethiopia"
replace ctry = 22 if country=="Djibouti"
replace ctry = 23 if country=="Liberia"
replace ctry = 24 if country=="Ghana"
replace ctry = 25 if country=="Sierra Leone"
replace ctry = 26 if country=="Cote d'Ivoire"
replace ctry = 27 if country=="Togo"
replace ctry = 28 if country=="Cameroon"
replace ctry = 29 if country=="Uganda"
replace ctry = 30 if country=="Somalia"
replace ctry = 31 if country=="Eq. Guinea"
replace ctry = 32 if country=="Benin"
replace ctry = 33 if country=="Congo"
replace ctry = 34 if country=="DR Congo"
replace ctry = 35 if country=="Kenya"
replace ctry = 36 if country=="Comoros"
replace ctry = 37 if country=="Sao Tome"
replace ctry = 38 if country=="Angola"
replace ctry = 39 if country=="Burundi"
replace ctry = 40 if country=="Rwanda"
replace ctry = 41 if country=="Tanzania"
replace ctry = 42 if country=="Gabon"
replace ctry = 43 if country=="Zambia"
replace ctry = 44 if country=="Malawi"
replace ctry = 45 if country=="Mozambique"
replace ctry = 46 if country=="Seychelles"
replace ctry = 47 if country=="Namibia"
replace ctry = 48 if country=="Botswana"
replace ctry = 49 if country=="Zimbabwe"
replace ctry = 50 if country=="Eswatini"
replace ctry = 51 if country=="Lesotho"
replace ctry = 52 if country=="Madagascar"
replace ctry = 53 if country=="Mauritius"
replace ctry = 54 if country=="South Africa"




labmask ctry, val(country)
label list

tab ctry
keep if ctry!=.
sort ctry


// expand the observations
levelsof country
local items `r(r)'

// define the dots
local rows =  10   

// row dots
local cols  = 10   

// col dots
local obsv = `cols' * `rows'  

// calculate the total number of rows per group

expand `obsv' 

// generate the dots

bysort country: egen y = seq(), b(`cols')  
                egen x = seq(), t(`cols')
				
				
by country: gen id = _n    
egen tag = tag(country) 
gen dots = .
 
levelsof country, local(lvls)

foreach x of local lvls {
   summ share if country=="`x'" & tag==1
   local share = `r(mean)'
   
   summ id if country=="`x'"
   replace dots = id <= int(`share' * `r(max)')  if country=="`x'"
}







levelsof ctry, local(lvls)

foreach x of local lvls {

local t : label ctry `x'
 
twoway ///
 (scatter y x if dots==1, msize(1.4) msymbol(circle)) ///
  if ctry==`x' , ///
  ytitle("") yscale(noline) ylabel(1 10, nogrid) ///
  xtitle("") xscale(noline) xlabel(1 10, nogrid) ///
  title("`t'", margin(small) size(6.6)) ///
   aspectratio(1)  legend(off) ///
   xscale(off) yscale(off) ///
   xsize(1) ysize(1) ///
    graphregion(lcolor(black)) ///
   name(map`x', replace)
}






graph combine ///
  map1  map2  map3  map4  map5  map6  map7  map8  map9 map10 ///
 map11 map12 map13 map14 map15 map16 map17 map18 map19 map20 ///
 map21 map22 map23 map24 map25 map26 map27 map28 map29 map30 ///
 map31 map32 map33 map35 map36 map37 map38 map39 map40 ///
 map41 map42 map43 map44 map45 map46 map47 map48 map49 map50 ///
 map51 map52 map53 map54             ///
 , ///
 cols(13) ///
 holes( ///
  1 2 3 4 10 11 12 13  ///
  14 15 16 24 25 26    ///
  28 38 39 ///
  40 41 42 51 52 ///
  53 54 55 56 57 63 64 ///
  66 68 69 70 71 76 77 78 ///
  79 80 81 82 83 84 89 90 ///
  92 93 94 95 96 97 101 102 103 104 ///
  105 106 107 108 109 110 111 114 115 ///
  118 119 120 121 122 123 124 126 127 128 129 130 ///
  ) ///
 title("{fontface Arial Bold:Share of population fully vaccinated in African countries}", margin(small) size(3.5)) ///
 note("Source: Our World in Data. 1 dot = 1% vaccinated.", size(1.25) margin(small)) ///
 xsize(1.2) ysize(1)





















