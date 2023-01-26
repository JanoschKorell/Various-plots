


clear

capture log close
cd $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet
log using $lofi/LogFileBarPie, replace
set more off, perm
numlabel _all, add force





*-------------------------Grafiken--------------------------------*

********************Bar Todesursachen  Durschnitt 0919*******************



use Todesursachen0919long

cd $grafi/Normale_Plots/Bar_Pie

drop if TodesU100ord == .

collapse (sum) Todesfälle, by(TodesU100ord Jahr)

sort TodesU100ord Jahr

egen SumTodOrd =  mean(Todesfälle), by(TodesU100ord)

keep if Jahr == 2009

drop Jahr

gsort+ SumTodOrd
egen rank = fill(1 2 to 14)





colorpalette  HCL Heat, n(14) nograph

foreach x of numlist 1/16 {
 

*** here the code for bar colors
 local barcolor `barcolor' bar(`x', fcolor("`r(p`x')'"%70)  lcolor(black) lwidth(*0.1)) `///' 
 
}



graph bar SumTodOrd, over(TodesU100ord, label(labsize(vsmall)  angle(45)) ///
sort(1)  descending axis(lcolor(none))) ///
bargap(30) ///
ascategory  showyvars asyvars `barcolor' ///
legend(position(6) ring(3)) legend(rows(3) size(vsmall)) ///
ytitle("Durchschnitt: Gestorbene 2009-2019", size(vsmall)) ///
ylabel(#20, labsize(1.5)) ymtick(##5)  ///
blabel(bar, size(1.7) orientation(horizontal)  margin(vsmall) format(%12.0fc)) ///
legend(off) ///
name(BarDurch0919, replace)

********************Pie Todesursachen Durchschnitt 0919**************************

egen sumperc = sum(SumTodOrd)

gen percentages = .


foreach x of numlist 1/14 {

replace percentages = round((SumTodOrd / sumperc) * 100, 0.01)

}


colorpalette  HCL Heat, n(16) nograph

foreach x of numlist 1/14 {
 
 local piecolor `piecolor' pie(`x', color("`r(p`x')'"%70) ) `///' 
 
}


foreach x of numlist 1/11 {
 
 local plabel `plabel' plabel(`x' percent, size(1.7) format(%9.1f)) `///' 
 
}



graph pie SumTodOrd, over(TodesU100ord) sort  descending ///
legend(position(6) ring(3)) legend(rows(5) size(vsmall)) ///
`piecolor' ///
`plabel' ///
pie(12, explode(15)) plabel(12 percent, size(vsmall) color(black)format(%9.1f) position(outside) gap(1))  ///
pie(1, explode(1)) pie(2, explode(3)) ///
name(PieDurch0919, replace) ///
legend(label(1 "Kreislauf" "37.1%")  label(2 "Krebs" "24.9%") label(3 "Atmungssystem" "6.9%") ///
label(4 "Verdauungssystem" "4.4%") label(5 "Psyche- und Verhaltensstörungen" "4.3%") ///
label(6 "Verletzungen / Vergiftungen (u.a.) 3.9%") label(7 "Stoffwechselkrankheiten (u.a.)" "3.4") ///
label(8 "Nicht klassifiziert" "2.9") label(9 "Nervensystem" "2.9") label(10 "Unfälle (u.a.)" "2.8") ///
label(11 "Urogenital" "2.4%") label(12 "Infektionskrankheiten" "1.9%") label(13 "Weitere Krankheiten" "1.2%") ///
label(14 "Selbstbeschädigung" "1.1%"))



graph combine BarDurch0919 PieDurch0919, rows(1) note("Quelle: Bundesamt für Statistik", size(1.5)) ///
title("Durschnittlich Gestorbene 2009-2019")
graph export "Bar Pie Durchschnitt Todesfälle 0919.jpg", replace as(png) width(4600)

*********************Bar Altersgruppen und Todesursachen Stack Percentage Durschnitt 0919**********************

clear

cd $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/

use Todesursachen0919long

cd $grafi/Normale_Plots/Bar_Pie

drop if TodesU100ord == .

collapse (sum) Todesfälle, by(Altersgruppe TodesU100ord Jahr)

sort Altersgruppe TodesU100ord 

egen SumTodOrd =  mean(Todesfälle), by(Altersgruppe TodesU100ord)

keep if Jahr == 2009

drop Jahr


numlabel _all, remove

foreach x of numlist 1/20 {

colorpalette  s2, gscal(0.5) name(20%gray) n(16) nograph
 
 local barcolor `barcolor' bar(`x', fcolor("`r(p`x')'"%70)  lcolor(black) lwidth(*0.1)) `///' 
 
}

graph bar (sum) SumTodOrd, over(TodesU100ord) over(Altersgruppe, label(labsize(vsmall) angle(45))) bargap(30) ///
ascategory `barcolor' showyvars asyvars percentage stack ///
legend(position(6) ring(3)) legend(rows(3) size(vsmall)) ///
ytitle("Durchschnitt: Gestorbene 2009-2019 in %", size(vsmall)) ///
ylabel(#20, labsize(1.5)) ymtick(##5)  ///
legend(position(6) ring(3)) legend(rows(4) size(tiny)) ///
title("Anteil der Altersgruppen an Todesursachen in Prozent (Durchschnitt 2009-2019)", size(small)) ///
note("Quelle: Bundesamt für Statistik", size(1.5))
graph export "Anteil der Altersgruppen an Todesursachen in Prozent (Durchschnitt 2009-2019).jpg", replace as(png) width(4600)





***************************Bar Überblick mit by **************************
                 // Alle Krankheiten im Zeitverlauf mit rank //



clear

cd $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/

use Todesursachen0919long

cd $grafi/Normale_Plots/Bar_Pie

drop if TodesU100ord == .

collapse (sum) Todesfälle Todesfälle100 , by(TodesU100ord Jahr)

sort TodesU100ord Jahr

egen rankp1 = rank(Todesfälle100), by(TodesU100ord)


grstyle init
grstyle set plain, horizontal
grstyle set intensity 30: bar
grstyle set color Accent: p#bar p#barline

tw ///
(bar Todesfälle100 Jahr if rank == 1,  color(red%10)) ///
(bar Todesfälle100 Jahr if rank == 2,  color(red%20)) ///
(bar Todesfälle100 Jahr if rank == 3,  color(red%30)) ///
(bar Todesfälle100 Jahr if rank == 4,  color(red%40)) ///
(bar Todesfälle100 Jahr if rank == 5,  color(red%50)) ///
(bar Todesfälle100 Jahr if rank == 6,  color(red%60)) ///
(bar Todesfälle100 Jahr if rank == 7,  color(red%70)) ///
(bar Todesfälle100 Jahr if rank == 8,  color(red%80)) ///
(bar Todesfälle100 Jahr if rank == 9,  color(red%90)) ///
(bar Todesfälle100 Jahr if rank == 10, color(red)) ///
(bar Todesfälle100 Jahr if rank == 11, color("102 0 0")) ///
, ///
by(TodesU100ord, edgelabel iscale(*0.9 )legend(off) title("Übersicht Todesursachen 2009-2019 pro 100000 Einwohner", size(small))  ///
note("Quelle: Bundesamt für Statistik (Daten)", size(tiny))) ///
xtitle(" ")xlabel( 2009 "2009" 2010 "2010" 2011 "2011" 2012 "2012" 2013 "2013" 2014 "2014" ///
2015 "2015" 2016 "2016" 2017 "2017" 2018 "2018" 2019 "2019", noticks labsize(2.3)) ///
yla(#9, labsize(2.5) axis(1)) ymtick(##5) ytitle("Gestorbene pro 100000", size(vsmall) axis(1))  yscale(range(0 .) axis(1)) 
graph export "Übersicht Todesursachen 2009-2019 pro 100000 Einwohner.jpg", replace as(png) width(4600)

 




