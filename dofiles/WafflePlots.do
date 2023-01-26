



clear

capture log close
cd $data/ESS
log using $lofi/WafflePlots, replace
set more off, perm
numlabel _all, add force





use ESS9.dta

*Ländervariable

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








gen DichAVGleichheitPro = DichAVGleichheit
drop DichAVGleichheit 


// Reihenfolge Länder nach Zustimmung

gsort-  DichAVGleichheitPro 
egen rank = rank(DichAVGleichheitPro), f
decode Land, gen(cntry)
labmask rank, values(cntry)

sort cntry

rename Land Landnorm
rename rank  Land



gen Wohlfahrtsstaaten = .
replace Wohlfahrtsstaaten = 1 if Landnorm == 15 | Landnorm == 12
		// Liberaler WS Irland, GB
replace Wohlfahrtsstaaten = 2 if Landnorm == 6	| Landnorm == 11 | Landnorm == 1 | Landnorm == 21 | Landnorm == 3 | Landnorm == 0											
		// Bismarck/Konservativer WS Deutschland, Frankreich, Belgien, Niederlande, Luxemburg???, Schweiz, Austria
replace Wohlfahrtsstaaten = 3 if Landnorm == 26 | Landnorm == 7  | Landnorm == 10 | Landnorm == 22	| Landnorm == 16 																	
		// Skandinavischer/Sozialdemokratischer WS Schweden, Dänemark, Finnland, Norwegen, Island (16)
replace Wohlfahrtsstaaten = 4 if Landnorm == 17 | Landnorm == 9	 | Landnorm == 24 | Landnorm == 4	
		// Mediterraner WS Griechenland???, Italien, Spanien, Portugal, Zypern
replace Wohlfahrtsstaaten = 5 if Landnorm == 5	| Landnorm == 8	 | Landnorm == 14 | Landnorm == 19 | Landnorm == 18 | Landnorm == 23 | Landnorm == 28 | Landnorm == 27 | Landnorm == 2 | Landnorm == 13	| Landnorm == 20 | Landnorm == 25 | Landnorm == 29
		// Osten Czech Republic, Estonia, Hungary, Latvia, Lithuania, Poland, Slovakia, Slovenia, Bulgarien (2), Kroatien (13), Montenegro (20), Serbien (25)


label values Wohlfahrtsstaaten Wohlfahrtsstaaten
label def Wohlfahrtsstaaten 1 "Liberaler WS", modify
label def Wohlfahrtsstaaten 2 "Bismarck/Konservativer WS", modify	
label def Wohlfahrtsstaaten 3 "Skandinavischer/Sozialdemokratischer WS", modify	
label def Wohlfahrtsstaaten 4 "Mediterraner WS", modify	
label def Wohlfahrtsstaaten 5 "Osten", modify	









// define the dots
local rows =  20   // row dots
local cols  = 20   // col dots
local obsv = `cols' * `rows'  

expand `obsv'

// generate the dots
bysort Land: egen y = seq(), b(`cols')  
             egen x = seq(), t(`cols')


   
by Land: gen id = _n    
egen tag = tag(Land) 
gen dots = .
 
 
 
 
levelsof cntry, local(lvls)

foreach x of local lvls {
   summ DichAVGleichheitPro if cntry=="`x'" & tag==1
   local DichAVGleichheitPro = `r(mean)'
   
   summ id if cntry=="`x'"
   replace dots = id <= int(`DichAVGleichheitPro' * `r(max)')  if cntry=="`x'"
}




// generate labels for by headers
cap drop country2
gen country2 = cntry + " (" + string(DichAVGleichheitPro * 100, "%9.1f") + "%)"  // final graph  
labmask Land, values(country2)


cd $grafi/WafflePlots

twoway ///
(scatter y x if dots==1 & Wohlfahrtsstaaten == 1, msize(0.8) msymbol(square) mc(mint)) ///
(scatter y x if dots==1 & Wohlfahrtsstaaten == 2, msize(0.8) msymbol(square) mc(pink)) ///
(scatter y x if dots==1 & Wohlfahrtsstaaten == 3, msize(0.8) msymbol(square) mc(yellow)) ///
(scatter y x if dots==1 & Wohlfahrtsstaaten == 4, msize(0.8) msymbol(square) mc(red)) ///
(scatter y x if dots==1 & Wohlfahrtsstaaten == 5, msize(0.8) msymbol(square) mc(lavender)) ///
(scatter y x if dots==0, msize(0.8) msymbol(square) mc(gs14)) ///
, ///
ytitle("") yscale(noline) ylabel(, nogrid) ///
xtitle("") xscale(noline) xlabel(, nogrid) ///
by(, title("Zustimmung zur Gerechtigkeit der Gleichheit in Europa", margin(Large)) ///
subtitle("Nach Wohlfahrtsstaaten (Ferrera/Gal)") ///
note("Source: European Social Survey 9", size(vsmall))) ///
by(, ) /// 
legend(rows(1)) /// 
legend(label(1 "Liberaler WS") label(2 "Konservativer WS") label(3 "Sozialdemokratischer WS") label(4 "Mediterraner WS") label(5 "Osteuropa") size(tiny)) ///
legend(order (1 2 3 4 5)) ///
by(Land, cols(8) noiyaxes noixaxes noiytick noixtick noiylabel noixlabel) ///
subtitle(, size(3) nobox) ///
aspectratio(1) 
graph export "Waffle Plot - Zustimmung zur Gerechtigkeit nach WS.jpg", replace as(png) width(4600)









