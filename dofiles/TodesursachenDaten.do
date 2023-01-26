*--------------------Datensatzaufbereitung----------------*



capture log close
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_09neu.xlsx, firstrow clear
log using $lofi/LogFileDatenaufbereitung, replace
set more off, perm
numlabel _all, add force

cd $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet




*---2009----*

*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2009

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw


// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6   

// Unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y40"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"


label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M993" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"


label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch


replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12


// Longmake 2009 - Addieren von allem außer Alter

save Todesursachen_2009stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2009, replace



// Longmake 2009 - Addieren von allem außer Alter

clear
use Todesursachen_2009stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009
append using longmake2009


save longmakeX202009, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2009stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake09Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake09Alt1, replace

clear
use longmake09Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake09Alt2, replace

clear
use longmake09Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake09Alt3, replace

clear
use longmake09Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake09Alt4, replace

clear
use longmake09Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake09Alt5, replace

clear
use longmake09Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake09Alt6, replace


clear
use longmake09Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake09Alt7, replace

clear
use longmake09Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake09Alt8, replace

clear
use longmake09Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake09Alt9, replace

clear
use longmake09Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake09Alt10, replace

clear
use longmake09Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake09Alt11, replace

clear
use longmake09Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake09Alt12, replace

clear
use longmake09Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake09Alt13, replace

clear
use longmake09Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake09Alt14, replace

clear
use longmake09Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake09Alt15, replace

clear
use longmake09Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake09Alt16, replace

clear
use longmake09Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake09Alt17, replace

clear
use longmake09Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake09Alt18, replace

clear
use longmake09Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake09Alt19, replace

clear
use longmake09Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake09Alt20, replace

clear
use longmake09Alt1
append using longmake09Alt2 longmake09Alt3 longmake09Alt4 longmake09Alt5 longmake09Alt6 longmake09Alt7 longmake09Alt8 ///
longmake09Alt9 longmake09Alt10 longmake09Alt11 longmake09Alt12 longmake09Alt13 longmake09Alt14 longmake09Alt15 ///
longmake09Alt16 longmake09Alt17 longmake09Alt18 longmake09Alt19 longmake09Alt20


save longmake09Altfertig, replace




clear 
use longmakeX202009
merge 1:1 _n using longmake09Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2009fertig, replace





*---2010----*




clear
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_10neu.xlsx, firstrow clear



*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2010

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw


// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6  

// Unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y40"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"



 
label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M993" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"


label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch


replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12



// Longmake 2010 - Addieren von allem außer Alter

save Todesursachen_2010stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2010, replace



// Longmake 2010 - Addieren von allem außer Alter

clear
use Todesursachen_2010stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010
append using longmake2010


save longmakeX202010, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2010stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake10Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake10Alt1, replace

clear
use longmake10Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake10Alt2, replace

clear
use longmake10Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake10Alt3, replace

clear
use longmake10Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake10Alt4, replace

clear
use longmake10Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake10Alt5, replace

clear
use longmake10Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake10Alt6, replace


clear
use longmake10Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake10Alt7, replace

clear
use longmake10Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake10Alt8, replace

clear
use longmake10Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake10Alt9, replace

clear
use longmake10Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake10Alt10, replace

clear
use longmake10Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake10Alt11, replace

clear
use longmake10Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake10Alt12, replace

clear
use longmake10Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake10Alt13, replace

clear
use longmake10Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake10Alt14, replace

clear
use longmake10Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake10Alt15, replace

clear
use longmake10Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake10Alt16, replace

clear
use longmake10Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake10Alt17, replace

clear
use longmake10Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake10Alt18, replace

clear
use longmake10Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake10Alt19, replace

clear
use longmake10Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake10Alt20, replace

clear
use longmake10Alt1
append using longmake10Alt2 longmake10Alt3 longmake10Alt4 longmake10Alt5 longmake10Alt6 longmake10Alt7 longmake10Alt8 ///
longmake10Alt9 longmake10Alt10 longmake10Alt11 longmake10Alt12 longmake10Alt13 longmake10Alt14 longmake10Alt15 ///
longmake10Alt16 longmake10Alt17 longmake10Alt18 longmake10Alt19 longmake10Alt20

save longmake10Altfertig, replace




clear 
use longmakeX202010
merge 1:1 _n using longmake10Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2010fertig, replace





*---2011----*



clear
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_11neu.xlsx, firstrow clear



*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2011

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw


// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6  

// unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y40"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"



  

label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M993" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"


label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch


replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12



// Longmake 2011 - Addieren von allem außer Alter

save Todesursachen_2011stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2011, replace



// Longmake 2012 - Addieren von allem außer Alter

clear
use Todesursachen_2011stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011
append using longmake2011


save longmakeX202011, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2011stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake11Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake11Alt1, replace

clear
use longmake11Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake11Alt2, replace

clear
use longmake11Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake11Alt3, replace

clear
use longmake11Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake11Alt4, replace

clear
use longmake11Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake11Alt5, replace

clear
use longmake11Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake11Alt6, replace


clear
use longmake11Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake11Alt7, replace

clear
use longmake11Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake11Alt8, replace

clear
use longmake11Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake11Alt9, replace

clear
use longmake11Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake11Alt10, replace

clear
use longmake11Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake11Alt11, replace

clear
use longmake11Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake11Alt12, replace

clear
use longmake11Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake11Alt13, replace

clear
use longmake11Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake11Alt14, replace

clear
use longmake11Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake11Alt15, replace

clear
use longmake11Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake11Alt16, replace

clear
use longmake11Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake11Alt17, replace

clear
use longmake11Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake11Alt18, replace

clear
use longmake11Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake11Alt19, replace

clear
use longmake11Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake11Alt20, replace

clear
use longmake11Alt1
append using longmake11Alt2 longmake11Alt3 longmake11Alt4 longmake11Alt5 longmake11Alt6 longmake11Alt7 longmake11Alt8 ///
longmake11Alt9 longmake11Alt10 longmake11Alt11 longmake11Alt12 longmake11Alt13 longmake11Alt14 longmake11Alt15 ///
longmake11Alt16 longmake11Alt17 longmake11Alt18 longmake11Alt19 longmake11Alt20

save longmake11Altfertig, replace




clear 
use longmakeX202011
merge 1:1 _n using longmake11Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2011fertig, replace


*---2012----*




clear
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_12neu.xlsx, firstrow clear


*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2012

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw


// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6    

// Unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y40"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"





label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M993" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"



label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch


replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12



// Longmake 2012 - Addieren von allem außer Alter

save Todesursachen_2012stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2012, replace



// Longmake 2012 - Addieren von allem außer Alter

clear
use Todesursachen_2012stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012
append using longmake2012


save longmakeX202012, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2012stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake12Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake12Alt1, replace

clear
use longmake12Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake12Alt2, replace

clear
use longmake12Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake12Alt3, replace

clear
use longmake12Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake12Alt4, replace

clear
use longmake12Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake12Alt5, replace

clear
use longmake12Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake12Alt6, replace


clear
use longmake12Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake12Alt7, replace

clear
use longmake12Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake12Alt8, replace

clear
use longmake12Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake12Alt9, replace

clear
use longmake12Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake12Alt10, replace

clear
use longmake12Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake12Alt11, replace

clear
use longmake12Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake12Alt12, replace

clear
use longmake12Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake12Alt13, replace

clear
use longmake12Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake12Alt14, replace

clear
use longmake12Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake12Alt15, replace

clear
use longmake12Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake12Alt16, replace

clear
use longmake12Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake12Alt17, replace

clear
use longmake12Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake12Alt18, replace

clear
use longmake12Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake12Alt19, replace

clear
use longmake12Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake12Alt20, replace

clear
use longmake12Alt1
append using longmake12Alt2 longmake12Alt3 longmake12Alt4 longmake12Alt5 longmake12Alt6 longmake12Alt7 longmake12Alt8 ///
longmake12Alt9 longmake12Alt10 longmake12Alt11 longmake12Alt12 longmake12Alt13 longmake12Alt14 longmake12Alt15 ///
longmake12Alt16 longmake12Alt17 longmake12Alt18 longmake12Alt19 longmake12Alt20

save longmake12Altfertig, replace




clear 
use longmakeX202012
merge 1:1 _n using longmake12Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2012fertig, replace






*---2013----*



clear
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_13neu.xlsx, firstrow clear



*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2013

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw


// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6  

// Unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y40"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"


label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M993" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"


label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch


replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12



// Longmake 2013 - Addieren von allem außer Alter

save Todesursachen_2013stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2013, replace



// Longmake 2013 - Addieren von allem außer Alter

clear
use Todesursachen_2013stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013
append using longmake2013


save longmakeX202013, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2013stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake13Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake13Alt1, replace

clear
use longmake13Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake13Alt2, replace

clear
use longmake13Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake13Alt3, replace

clear
use longmake13Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake13Alt4, replace

clear
use longmake13Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake13Alt5, replace

clear
use longmake13Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake13Alt6, replace


clear
use longmake13Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake13Alt7, replace

clear
use longmake13Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake13Alt8, replace

clear
use longmake13Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake13Alt9, replace

clear
use longmake13Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake13Alt10, replace

clear
use longmake13Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake13Alt11, replace

clear
use longmake13Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake13Alt12, replace

clear
use longmake13Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake13Alt13, replace

clear
use longmake13Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake13Alt14, replace

clear
use longmake13Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake13Alt15, replace

clear
use longmake13Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake13Alt16, replace

clear
use longmake13Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake13Alt17, replace

clear
use longmake13Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake13Alt18, replace

clear
use longmake13Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake13Alt19, replace

clear
use longmake13Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake13Alt20, replace

clear
use longmake13Alt1
append using longmake13Alt2 longmake13Alt3 longmake13Alt4 longmake13Alt5 longmake13Alt6 longmake13Alt7 longmake13Alt8 ///
longmake13Alt9 longmake13Alt10 longmake13Alt11 longmake13Alt12 longmake13Alt13 longmake13Alt14 longmake13Alt15 ///
longmake13Alt16 longmake13Alt17 longmake13Alt18 longmake13Alt19 longmake13Alt20

save longmake13Altfertig, replace




clear 
use longmakeX202013
merge 1:1 _n using longmake13Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2013fertig, replace


*---2014----*




clear
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_14neu.xlsx, firstrow clear



*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2014

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw


// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6   

// Unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y40"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"


label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M993" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"


label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch


replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12



// Longmake 2014 - Addieren von allem außer Alter

save Todesursachen_2014stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2014, replace



// Longmake 2014 - Addieren von allem außer Alter

clear
use Todesursachen_2014stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014
append using longmake2014


save longmakeX202014, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2014stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake14Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake14Alt1, replace

clear
use longmake14Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake14Alt2, replace

clear
use longmake14Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake14Alt3, replace

clear
use longmake14Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake14Alt4, replace

clear
use longmake14Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake14Alt5, replace

clear
use longmake14Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake14Alt6, replace


clear
use longmake14Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake14Alt7, replace

clear
use longmake14Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake14Alt8, replace

clear
use longmake14Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake14Alt9, replace

clear
use longmake14Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake14Alt10, replace

clear
use longmake14Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake14Alt11, replace

clear
use longmake14Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake14Alt12, replace

clear
use longmake14Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake14Alt13, replace

clear
use longmake14Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake14Alt14, replace

clear
use longmake14Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake14Alt15, replace

clear
use longmake14Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake14Alt16, replace

clear
use longmake14Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake14Alt17, replace

clear
use longmake14Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake14Alt18, replace

clear
use longmake14Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake14Alt19, replace

clear
use longmake14Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake14Alt20, replace

clear
use longmake14Alt1
append using longmake14Alt2 longmake14Alt3 longmake14Alt4 longmake14Alt5 longmake14Alt6 longmake14Alt7 longmake14Alt8 ///
longmake14Alt9 longmake14Alt10 longmake14Alt11 longmake14Alt12 longmake14Alt13 longmake14Alt14 longmake14Alt15 ///
longmake14Alt16 longmake14Alt17 longmake14Alt18 longmake14Alt19 longmake14Alt20

save longmake14Altfertig, replace




clear 
use longmakeX202014
merge 1:1 _n using longmake14Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2014fertig, replace







*---2015----*




clear
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_15neu.xlsx, firstrow clear



*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2015

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw


// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6  

// Unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y40"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"


label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M993" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"


label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch


replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12



// Longmake 2015 - Addieren von allem außer Alter

save Todesursachen_2015stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2015, replace



// Longmake 2015 - Addieren von allem außer Alter

clear
use Todesursachen_2015stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015
append using longmake2015


save longmakeX202015, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2015stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake15Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake15Alt1, replace

clear
use longmake15Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake15Alt2, replace

clear
use longmake15Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake15Alt3, replace

clear
use longmake15Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake15Alt4, replace

clear
use longmake15Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake15Alt5, replace

clear
use longmake15Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake15Alt6, replace


clear
use longmake15Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake15Alt7, replace

clear
use longmake15Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake15Alt8, replace

clear
use longmake15Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake15Alt9, replace

clear
use longmake15Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake15Alt10, replace

clear
use longmake15Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake15Alt11, replace

clear
use longmake15Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake15Alt12, replace

clear
use longmake15Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake15Alt13, replace

clear
use longmake15Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake15Alt14, replace

clear
use longmake15Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake15Alt15, replace

clear
use longmake15Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake15Alt16, replace

clear
use longmake15Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake15Alt17, replace

clear
use longmake15Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake15Alt18, replace

clear
use longmake15Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake15Alt19, replace

clear
use longmake15Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake15Alt20, replace

clear
use longmake15Alt1
append using longmake15Alt2 longmake15Alt3 longmake15Alt4 longmake15Alt5 longmake15Alt6 longmake15Alt7 longmake15Alt8 ///
longmake15Alt9 longmake15Alt10 longmake15Alt11 longmake15Alt12 longmake15Alt13 longmake15Alt14 longmake15Alt15 ///
longmake15Alt16 longmake15Alt17 longmake15Alt18 longmake15Alt19 longmake15Alt20

save longmake15Altfertig, replace




clear 
use longmakeX202015
merge 1:1 _n using longmake15Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2015fertig, replace





*---2016----*



clear
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_16neu.xlsx, firstrow clear




*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2016

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw


// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6 

// Unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y40"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"


label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M993" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"


label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch


replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12



// Longmake 2016 - Addieren von allem außer Alter

save Todesursachen_2016stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2016, replace



// Longmake 2016 - Addieren von allem außer Alter

clear
use Todesursachen_2016stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016
append using longmake2016


save longmakeX202016, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2016stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake16Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake16Alt1, replace

clear
use longmake16Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake16Alt2, replace

clear
use longmake16Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake16Alt3, replace

clear
use longmake16Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake16Alt4, replace

clear
use longmake16Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake16Alt5, replace

clear
use longmake16Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake16Alt6, replace


clear
use longmake16Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake16Alt7, replace

clear
use longmake16Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake16Alt8, replace

clear
use longmake16Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake16Alt9, replace

clear
use longmake16Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake16Alt10, replace

clear
use longmake16Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake16Alt11, replace

clear
use longmake16Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake16Alt12, replace

clear
use longmake16Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake16Alt13, replace

clear
use longmake16Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake16Alt14, replace

clear
use longmake16Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake16Alt15, replace

clear
use longmake16Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake16Alt16, replace

clear
use longmake16Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake16Alt17, replace

clear
use longmake16Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake16Alt18, replace

clear
use longmake16Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake16Alt19, replace

clear
use longmake16Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake16Alt20, replace

clear
use longmake16Alt1
append using longmake16Alt2 longmake16Alt3 longmake16Alt4 longmake16Alt5 longmake16Alt6 longmake16Alt7 longmake16Alt8 ///
longmake16Alt9 longmake16Alt10 longmake16Alt11 longmake16Alt12 longmake16Alt13 longmake16Alt14 longmake16Alt15 ///
longmake16Alt16 longmake16Alt17 longmake16Alt18 longmake16Alt19 longmake16Alt20

save longmake16Altfertig, replace




clear 
use longmakeX202016
merge 1:1 _n using longmake16Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2016fertig, replace



*---2017----*





clear
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_17neu.xlsx, firstrow clear



*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2017

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw


// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6  

// Unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y40"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"


label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M995" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"


label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch


replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12



// Longmake 2017 - Addieren von allem außer Alter

save Todesursachen_2017stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2017, replace



// Longmake 2017 - Addieren von allem außer Alter

clear
use Todesursachen_2017stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017
append using longmake2017


save longmakeX202017, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2017stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake17Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake17Alt1, replace

clear
use longmake17Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake17Alt2, replace

clear
use longmake17Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake17Alt3, replace

clear
use longmake17Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake17Alt4, replace

clear
use longmake17Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake17Alt5, replace

clear
use longmake17Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake17Alt6, replace


clear
use longmake17Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake17Alt7, replace

clear
use longmake17Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake17Alt8, replace

clear
use longmake17Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake17Alt9, replace

clear
use longmake17Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake17Alt10, replace

clear
use longmake17Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake17Alt11, replace

clear
use longmake17Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake17Alt12, replace

clear
use longmake17Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake17Alt13, replace

clear
use longmake17Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake17Alt14, replace

clear
use longmake17Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake17Alt15, replace

clear
use longmake17Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake17Alt16, replace

clear
use longmake17Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake17Alt17, replace

clear
use longmake17Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake17Alt18, replace

clear
use longmake17Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake17Alt19, replace

clear
use longmake17Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake17Alt20, replace

clear
use longmake17Alt1
append using longmake17Alt2 longmake17Alt3 longmake17Alt4 longmake17Alt5 longmake17Alt6 longmake17Alt7 longmake17Alt8 ///
longmake17Alt9 longmake17Alt10 longmake17Alt11 longmake17Alt12 longmake17Alt13 longmake17Alt14 longmake17Alt15 ///
longmake17Alt16 longmake17Alt17 longmake17Alt18 longmake17Alt19 longmake17Alt20

save longmake17Altfertig, replace




clear 
use longmakeX202017
merge 1:1 _n using longmake17Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2017fertig, replace






*--------------2018---------*


clear
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_18neu.xlsx, firstrow clear


numlabel _all, add force

*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2018

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw

// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6 

// Unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y400"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"

   

label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M995" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"


label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch

replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12


// Longmake 2018 - Addieren von allem außer Alter

save Todesursachen_2018stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2018, replace



// Longmake 2018 - Addieren von allem außer Alter

clear
use Todesursachen_2018stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018
append using longmake2018


save longmakeX202018, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2018stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake18Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake18Alt1, replace

clear
use longmake18Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake18Alt2, replace

clear
use longmake18Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake18Alt3, replace

clear
use longmake18Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake18Alt4, replace

clear
use longmake18Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake18Alt5, replace

clear
use longmake18Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake18Alt6, replace


clear
use longmake18Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake18Alt7, replace

clear
use longmake18Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake18Alt8, replace

clear
use longmake18Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake18Alt9, replace

clear
use longmake18Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake18Alt10, replace

clear
use longmake18Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake18Alt11, replace

clear
use longmake18Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake18Alt12, replace

clear
use longmake18Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake18Alt13, replace

clear
use longmake18Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake18Alt14, replace

clear
use longmake18Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake18Alt15, replace

clear
use longmake18Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake18Alt16, replace

clear
use longmake18Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake18Alt17, replace

clear
use longmake18Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake18Alt18, replace

clear
use longmake18Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake18Alt19, replace

clear
use longmake18Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake18Alt20, replace

clear
use longmake18Alt1
append using longmake18Alt2 longmake18Alt3 longmake18Alt4 longmake18Alt5 longmake18Alt6 longmake18Alt7 longmake18Alt8 ///
longmake18Alt9 longmake18Alt10 longmake18Alt11 longmake18Alt12 longmake18Alt13 longmake18Alt14 longmake18Alt15 ///
longmake18Alt16 longmake18Alt17 longmake18Alt18 longmake18Alt19 longmake18Alt20

save longmake18Altfertig, replace




clear 
use longmakeX202018 
merge 1:1 _n using longmake18Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2018fertig, replace

*---2019----*



clear
import excel $data/Data_Todesursachen/Todesursachenstatistik_tiefgegliedert_geordnet/Todesursachen_19neu.xlsx, firstrow clear



*-----Labels-----*

// Geschlecht

label values Geschlecht Geschlecht
label def Geschlecht 1 "Männlich", modify
label def Geschlecht 2 "Weiblich", modify

// Jahr 

replace Jahr = 2019

// Unfälle


label variable Unfallkategorie "Unfallkategorie"

label define Unfallkategorien ///
        1    "Arbeitsunfall" ///
        2    "Schulunfall" ///
        3    "Verkehrsunfall" ///
        4    "Häuslicher Unfall" ///
        5    "Sportunfall" ///
        6    "sonstiger Unfall" ///
		
label values Unfallkategorie Unfallkategorien 


label variable Unfallort "Unfallort"

label define Unfallorte ///
       0   "Zu Hause" ///
       1   "Wohnheim oder -anstalten" ///
       2   "Schule, sonstige öffentliche Bauten" ///
       3   "Sportstätten" ///
       4   "Straßen und Wege" ///
       5   "Gewerbe- und Dienstleistungseinrichtungen" ///
       6   "Industrieanlagen und Baustellen" ///
       7   "Landwirtschaftlicher Betrieb" ///
       8   "Sonstige näher bezeichnete Orte" ///
       9   "Nicht näher bezeichneter Ort des Ereignisses" ///
		
label values Unfallort Unfallorte 

// Äußere Ursachen von Morbidität und Mortalität

// Vervollständigung aeuw

// Bekannte Ursachen

replace aeuw  = 1 if Unfallkategorie ==  1    
replace aeuw  = 2 if Unfallkategorie ==  2    
replace aeuw  = 3 if Unfallkategorie ==  3    
replace aeuw  = 4 if Unfallkategorie ==  4    
replace aeuw  = 5 if Unfallkategorie ==  5   
replace aeuw  = 6 if Unfallkategorie ==  6   

// Unbekannte Ursachen

replace aeuw = 7 if aeu > "X599" & aeu < "X85"
replace aeuw = 8 if aeu > "X84" & aeu < "Y10"
replace aeuw = 9 if aeu > "Y09" & aeu < "Y35"
replace aeuw = 10 if aeu > "Y34" & aeu < "Y40"
replace aeuw = 11 if aeu > "Y369" & aeu < "Y85"
replace aeuw = 12 if aeu > "Y849" & aeu < "Y9"



label values aeuw aeuw
label def aeuw 1 "Arbeitsunfall", modify
label def aeuw 2 "Schulunfall", modify
label def aeuw 3 "Verkehrsunfall", modify
label def aeuw 4 "Häuslicher Unfall", modify
label def aeuw 5 "Sportunfall", modify
label def aeuw 6 "sonstiger Unfall", modify
label def aeuw 7 "Selbstbeschädigung", modify
label def aeuw 8 "Tätlicher Angriff", modify
label def aeuw 9 "Unbekante Umstände", modify
label def aeuw 10 "Gesetzliche Maßnahmen und Krieg", modify
label def aeuw 11 "Zusammenhang Medizin", modify
label def aeuw 12 "Folgezustände_aeu", modify

// ICD

// ICDW


replace ICDW = 1 if ICD > "A009" & ICD < "C000"
replace ICDW = 2 if ICD > "B99" & ICD < "D50"
replace ICDW = 3 if ICD > "D489" & ICD < "E000"
replace ICDW = 4 if ICD > "D90" & ICD < "F000"
replace ICDW = 5 if ICD > "E90" & ICD < "G000"
replace ICDW = 6 if ICD > "F99" & ICD < "H000"
replace ICDW = 7 if ICD > "G99" & ICD < "H60"
replace ICDW = 8 if ICD > "H59" & ICD < "I000"
replace ICDW = 9 if ICD > "H95" & ICD < "J000"
replace ICDW = 10 if ICD > "I99" & ICD < "K000"
replace ICDW = 11 if ICD > "J99" & ICD < "L000"
replace ICDW = 12 if ICD > "K93" & ICD < "M000"
replace ICDW = 13 if ICD > "L993" & ICD < "N000"
replace ICDW = 14 if ICD > "M995" &| ICD > "M999" &  ICD < "O000" 
replace ICDW = 15 if ICD > "N99" & ICD < "P000"
replace ICDW = 16 if ICD >  "O998"  & ICD < "Q000" 
replace ICDW = 17 if ICD > "P969" & ICD < "R000"
replace ICDW = 18 if ICD > "Q999" & ICD < "S000"
replace ICDW = 19 if ICD > "R99" & aeu < "V01"
replace ICDW = 20 if aeu > "V00" & aeu < "Y90"


label values ICDW ICDW
label def ICDW 1 "Infektionskrankheiten", modify
label def ICDW 2 "Krebs", modify
label def ICDW 3 "Blut und blutbildende Organe", modify
label def ICDW 4 "Stoffwechselkrankheiten", modify
label def ICDW 5 "Psychische und Verhaltensstörungen", modify
label def ICDW 6 "Krankheiten des Nervensystems", modify
label def ICDW 7 "Krankheiten des Auge", modify
label def ICDW 8 "Krankheiten des Ohres", modify
label def ICDW 9 "Krankheiten des Kreislaufsystems", modify
label def ICDW 10 "Krankheiten des Atmungssystems", modify
label def ICDW 11 "Krankheiten des Verdauungssystems", modify
label def ICDW 12 "Krankheiten der Haut", modify
label def ICDW 13 "Krankheiten des Muskel-Skelett-Systems", modify
label def ICDW 14 "Krankheiten des Urogenitalsystems", modify
label def ICDW 15 "Schwangerschaft", modify
label def ICDW 16 "Ursprung in der Perinatalperiode", modify
label def ICDW 17 "Fehlbildungen", modify
label def ICDW 18 "Nicht klassifiziert", modify
label def ICDW 19 "Verletzungen, Vergiftungen u.a.", modify
label def ICDW 20 "Äußere Ursachen von Morbidität und Mortalität", modify



// ICDW kategorisch


// Infektionskrankheiten

replace ICDWK = 1 if ICD > "A0" & ICD < "A150"  
replace ICDWK = 2 if ICD > "A14" & ICD < "A20" 
replace ICDWK = 3 if ICD > "A199" & ICD < "A30" 
replace ICDWK = 4 if ICD > "A29" & ICD < "A50" 
replace ICDWK = 5 if ICD > "A499" & ICD < "A65"
replace ICDWK = 6 if ICD > "A64" & ICD < "A70"
replace ICDWK = 7 if ICD > "A692" & ICD < "A75"
replace ICDWK = 8 if ICD > "A74" & ICD < "A80"
replace ICDWK = 9 if ICD > "A79" & ICD < "A90"
replace ICDWK = 10 if ICD > "A91" & ICD < "B000"
replace ICDWK = 11 if ICD > "A99" & ICD < "B10"
replace ICDWK = 12 if ICD > "B14" & ICD < "B200"
replace ICDWK = 13 if ICD > "B199" & ICD < "B25"
replace ICDWK = 14 if ICD > "B24" & ICD < "B35"
replace ICDWK = 15 if ICD > "B349" & ICD < "B50"
replace ICDWK = 16 if ICD > "B49" & ICD < "B65"
replace ICDWK = 17 if ICD > "B64" & ICD < "B85"
replace ICDWK = 18 if ICD > "B84" & ICD < "B90"
replace ICDWK = 19 if ICD > "B89" & ICD < "B95"
replace ICDWK = 20 if ICD > "B949" & ICD < "B99"
replace ICDWK = 21 if ICD > "B98" & ICD < "C0"

 //Krebs

replace ICDWK = 22 if ICD > "B99" & ICD < "D50"

// Blut

replace ICDWK = 23 if ICD > "D489" & ICD < "E00"

// Stoffwechsel

replace ICDWK = 24 if ICD > "D90" & ICD < "E100"
replace ICDWK = 25 if ICD > "E079" & ICD < "E15"
replace ICDWK = 26 if ICD > "E149" & ICD < "E200"
replace ICDWK = 27 if ICD > "E162" & ICD < "E400"
replace ICDWK = 28 if ICD > "E359" & ICD < "E500"
replace ICDWK = 29 if ICD > "E469" & ICD < "E650"
replace ICDWK = 30 if ICD > "E649" & ICD < "E700"
replace ICDWK = 31 if ICD > "E689" & ICD < "F000"

// Psychische und Verhaltensstörungen

replace ICDWK = 32 if ICD > "E90" & ICD < "F10"
replace ICDWK = 33 if ICD > "F09" & ICD < "F20"
replace ICDWK = 34 if ICD > "F199" & ICD < "F30"
replace ICDWK = 35 if ICD > "F29" & ICD < "F40"
replace ICDWK = 36 if ICD > "F39 " & ICD < "F50"
replace ICDWK = 37 if ICD > "F49 " & ICD < "F60"
replace ICDWK = 38 if ICD > "F59" & ICD < "F70"
replace ICDWK = 39 if ICD > "F69 " & ICD < "F80"
replace ICDWK = 40 if ICD > "F799" & ICD < "F90"
replace ICDWK = 41 if ICD > "F89" & ICD < "F99 "
replace ICDWK = 42 if ICD > "F98" & ICD < "G00"

// Nervensystem

replace ICDWK = 43 if ICD > "F99" & ICD < "H00"


// Krankheiten des Auges und der Augenanhangsgebilde


replace ICDWK = 44 if ICD > "G99" & ICD < "H60"


// Krankheiten des Ohres und des Warzenfortsatzes


replace ICDWK = 45 if ICD > "H59" & ICD < "I00"

// Krankheiten des Kreislaufsystems

replace ICDWK = 46 if ICD > "H95" & ICD < "I05"
replace ICDWK = 47 if ICD > "I02" & ICD < "I15"
replace ICDWK = 48 if ICD > "I099" & ICD < "I20"
replace ICDWK = 49 if ICD > "I15" & ICD < "I26"
replace ICDWK = 50 if ICD > "I259 " & ICD < "I30"
replace ICDWK = 51 if ICD > "I28" & ICD < "I60"
replace ICDWK = 52 if ICD > "I52 " & ICD < "I70"
replace ICDWK = 53 if ICD > "I699 " & ICD < "I80"
replace ICDWK = 54 if ICD > "I79 " & ICD < "I95 "
replace ICDWK = 55 if ICD > "I899 " & ICD < "J00"


// Krankheiten des Atmungssystems

replace ICDWK = 56 if ICD > "I99" & ICD < "J09"
replace ICDWK = 57 if ICD > "J069" & ICD < "J12" // Grippe
replace ICDWK = 58 if ICD > "J119" & ICD < "J13" // Viruspneunomie
replace ICDWK = 59 if ICD > "J129" & ICD < "J200" // Pneumonie
replace ICDWK = 60 if ICD > "J189" & ICD < "J30"
replace ICDWK = 61 if ICD > "J22" & ICD < "J40"
replace ICDWK = 62 if ICD > "J399" & ICD < "J60"
replace ICDWK = 63 if ICD > "J47" & ICD < "J80"
replace ICDWK = 64 if ICD > "J704" & ICD < "J85"
replace ICDWK = 65 if ICD > "J849" & ICD < "J90"
replace ICDWK = 66 if ICD > "J869" & ICD < "J95"
replace ICDWK = 67 if ICD > "J949" & ICD < "K00"

// Krankheiten des Verdauungssystems

replace ICDWK = 68 if ICD > "J99" & ICD < "L00"

// Krankheiten der Haut und der Unterhaut

replace ICDWK = 69 if ICD > "K93" & ICD < "M00"

// Krankheiten des Muskel-Skelett-Systems und des Bindegewebes


replace ICDWK = 70 if ICD > "L999" & ICD < "N000"


// Krankheiten des Urogenitalsystems

replace ICDWK = 71 if ICD > "M999" & ICD < "O000"


// Schwangerschaft, Geburt und Wochenbett

replace ICDWK = 72 if ICD > "N999" & ICD < "P000"

// Bestimmte Zustände, die ihren Ursprung in der Perinatalperiode haben

replace ICDWK = 73 if ICD > "O999" & ICD < "Q000"

// Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien

replace ICDWK = 74 if ICD > "P969" & ICD < "R000"

// Symptome und abnorme klinische und Laborbefunde, die anderenorts nicht klassifiziert sind

replace ICDWK = 75 if ICD > "Q999" & ICD < "S000"

// Verletzungen, Vergiftungen und bestimmte andere Folgen äußerer Ursachen

replace ICDWK = 76 if ICD > "R99" & aeu < "V01"


// label ICDWK

label values ICDWK ICDWK
label def ICDWK 1 "Infektiöse Darmkrankheiten", modify
label def ICDWK 2 "Tuberkulose", modify
label def ICDWK 3 "Bestimmte bakterielle Zoonosen", modify
label def ICDWK 4 "Sonstige bakterielle Krankheiten", modify
label def ICDWK 5 "Infektionen, die vorwiegend durch Geschlechtsverkehr übertragen werden", modify
label def ICDWK 6 "Sonstige Spirochätenkrankheiten", modify
label def ICDWK 7 "Sonstige Krankheiten durch Chlamydien", modify
label def ICDWK 8 "Rickettsiosen", modify
label def ICDWK 9 "Virusinfektionen des Zentralnervensystems", modify
label def ICDWK 10 "Durch Arthropoden übertragene Viruskrankheiten und virale hämorrhagische Fieber", modify
label def ICDWK 11 "Virusinfektionen, die durch Haut- und Schleimhautläsionen gekennzeichnet sind", modify
label def ICDWK 12 "Virushepatitis", modify
label def ICDWK 13 "HIV", modify
label def ICDWK 14 "Sonstige Viruskrankheiten", modify
label def ICDWK 15 "Mykosen", modify
label def ICDWK 16 "Protozoenkrankheiten", modify
label def ICDWK 17 "Helminthosen", modify
label def ICDWK 18 "Läuse/Milben", modify
label def ICDWK 19 "Folgezustände von Infektionen", modify
label def ICDWK 20 "In anderen Kapiteln klassifizert", modify
label def ICDWK 21 "Sonstige Infektionskrankheiten", modify
label def ICDWK 22 "Krebs", modify
label def ICDWK 23 "Blut und blutbildende Organe", modify
label def ICDWK 24 "Schilddrüse", modify
label def ICDWK 25 "Diabetes mellitus", modify
label def ICDWK 26 "Störungen der Blutglukose-Regulation/Inneren Sekretion des Pankreas", modify
label def ICDWK 27 "Endokrine Drüsen", modify
label def ICDWK 28 "Mangelernährung", modify
label def ICDWK 29 "Alimentäre Mangelzustände", modify
label def ICDWK 30 "Adipositas", modify
label def ICDWK 31 "Stoffwechselstörungen", modify
label def ICDWK 32 "Organische, einschließlich symptomatischer psychischer Störungen", modify
label def ICDWK 33 "Psychische und Verhaltensstörungen durch psychotrope Substanzen", modify
label def ICDWK 34 "Schizophrenie, schizotype und wahnhafte Störungen", modify
label def ICDWK 35 "Affektive Störungen", modify
label def ICDWK 36 "Neurotische, Belastungs- und somatoforme Störungen", modify
label def ICDWK 37 "Verhaltensauffälligkeiten mit körperlichen Störungen und Faktoren", modify
label def ICDWK 38 "Persönlichkeits- und Verhaltensstörungen", modify
label def ICDWK 39 "Intelligenzstörung", modify
label def ICDWK 40 "Entwicklungsstörungen", modify
label def ICDWK 41 "Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend", modify
label def ICDWK 42 "Nicht näher bezeichnete psychische Störungen", modify
label def ICDWK 43 "Krankheiten des Nervensystems", modify
label def ICDWK 44 "Krankheiten des Auge", modify
label def ICDWK 45 "Krankheiten des Ohres", modify
label def ICDWK 46 "Akutes rheumatisches Fieber", modify
label def ICDWK 47 "Chronische rheumatische Herzkrankheiten", modify
label def ICDWK 48 "Hypertonie", modify
label def ICDWK 49 "Ischämische Herzkrankheiten", modify
label def ICDWK 50 "Pulmonale Herzkrankheit und Krankheiten des Lungenkreislaufes", modify
label def ICDWK 51 "Sonstige Formen der Herzkrankheit", modify
label def ICDWK 52 "Zerebrovaskuläre Krankheiten", modify
label def ICDWK 53 "Krankheiten der Arterien, Arteriolen und Kapillaren", modify
label def ICDWK 54 "Krankheiten der Venen, der Lymphgefäße und der Lymphknoten, anderenorts nicht klassifiziert", modify
label def ICDWK 55 "Sonstiges", modify
label def ICDWK 56 "Akute Infektionen der oberen Atemwege", modify
label def ICDWK 57 "Grippe", modify
label def ICDWK 58 "Viruspneumonie", modify
label def ICDWK 59 "Pneumonie", modify
label def ICDWK 60 "Sonstige akute Infektionen der unteren Atemwege", modify
label def ICDWK 61 "Sonstige Krankheiten der oberen Atemwege", modify
label def ICDWK 62 "Chronische Krankheiten der unteren Atemwege", modify
label def ICDWK 63 "Lungenkrankheiten durch exogene Substanzen", modify
label def ICDWK 64 "Sonstige Krankheiten der Atmungsorgane", modify
label def ICDWK 65 "Purulente und nekrotisierende Krankheitszustände der unteren Atemwege", modify
label def ICDWK 66 "Sonstige Krankheiten der Pleura", modify
label def ICDWK 67 "Sonstige Krankheiten des Atmungssystems", modify
label def ICDWK 68 "Krankheiten des Verdauungssystems", modify
label def ICDWK 69 "Krankheiten der Haut und der Unterhaut", modify
label def ICDWK 70 "Krankheiten des Muskel-Skelett-Systems und des Bindegewebes", modify
label def ICDWK 71 "Krankheiten des Urogenitalsystems", modify
label def ICDWK 72 "Schwangerschaft, Geburt und Wochenbett", modify
label def ICDWK 73 "Perinatalperiode", modify
label def ICDWK 74 "Angeborene Fehlbildungen, Deformitäten und Chromosomenanomalien", modify
label def ICDWK 75 "Nicht klassifiziert", modify
label def ICDWK 76 "Verletzungen, Vergiftungen und Folgen äußerer Ursachen", modify

// ICDnumerisch


replace ICDnumerisch = 1 if ICDW == 1
replace ICDnumerisch = 2 if ICDW == 2
replace ICDnumerisch = 3 if ICDW == 3
replace ICDnumerisch = 4 if ICDW == 4
replace ICDnumerisch = 5 if ICDW == 5
replace ICDnumerisch = 6 if ICDW == 6
replace ICDnumerisch = 7 if ICDW == 7
replace ICDnumerisch = 8 if ICDW == 8
replace ICDnumerisch = 9 if ICDW == 9
replace ICDnumerisch = 10 if ICDW == 10
replace ICDnumerisch = 11 if ICDW == 11
replace ICDnumerisch = 12 if ICDW == 12
replace ICDnumerisch = 13 if ICDW == 13
replace ICDnumerisch = 14 if ICDW == 14
replace ICDnumerisch = 15 if ICDW == 15
replace ICDnumerisch = 16 if ICDW == 16
replace ICDnumerisch = 17 if ICDW == 17
replace ICDnumerisch = 18 if ICDW == 18
replace ICDnumerisch = 19 if ICDW == 19

replace ICDnumerisch = 20 if aeuw == 1
replace ICDnumerisch = 21 if aeuw == 2
replace ICDnumerisch = 22 if aeuw == 3
replace ICDnumerisch = 23 if aeuw == 4
replace ICDnumerisch = 24 if aeuw == 5
replace ICDnumerisch = 25 if aeuw == 6
replace ICDnumerisch = 26 if aeuw == 7
replace ICDnumerisch = 27 if aeuw == 8
replace ICDnumerisch = 28 if aeuw == 9
replace ICDnumerisch = 29 if aeuw == 10
replace ICDnumerisch = 30 if aeuw == 11
replace ICDnumerisch = 31 if aeuw == 12



// Longmake 2019 - Addieren von allem außer Alter

save Todesursachen_2019stata, replace

keep Jahr ICD aeu Unfallkategorie Unfallort aeuw ICDnumerisch ICDW ICDWK Geschlecht

save longmake2019, replace



// Longmake 2019 - Addieren von allem außer Alter

clear
use Todesursachen_2019stata
keep Jahr ICD aeu Unfallkategorie ICDnumerisch Unfallort ICDW ICDWK Geschlecht
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019
append using longmake2019


save longmakeX202019, replace

// Longmake - Zusammenführen der Altersgruppen und hinzufügen der ID Altersgruppe


clear

use Todesursachen_2019stata
keep A_1 A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
save longmake19Alt, replace

drop A_5 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_1 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 1 
save longmake19Alt1, replace

clear
use longmake19Alt
drop  A_1 A_10 A_15 A_20 A_25 A_30 A_35 A_40 A_45 A_50 A_55 A_60 A_65 A_70 A_75 A_80 A_85 A_90 A_gr90
rename A_5 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 2 
save longmake19Alt2, replace

clear
use longmake19Alt
keep  A_10 
rename A_10 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 3 
save longmake19Alt3, replace

clear
use longmake19Alt
keep   A_15
rename A_15 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 4 
save longmake19Alt4, replace

clear
use longmake19Alt
keep   A_20 
rename A_20 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 5 
save longmake19Alt5, replace

clear
use longmake19Alt
keep   A_25 
rename A_25 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 6 
save longmake19Alt6, replace


clear
use longmake19Alt
keep   A_30 
rename A_30 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 7 
save longmake19Alt7, replace

clear
use longmake19Alt
keep  A_35 
rename A_35 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 8 
save longmake19Alt8, replace

clear
use longmake19Alt
keep  A_40
rename A_40 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 9 
save longmake19Alt9, replace

clear
use longmake19Alt
keep   A_45 
rename A_45 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 10 
save longmake19Alt10, replace

clear
use longmake19Alt
keep  A_50 
rename A_50 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 11 
save longmake19Alt11, replace

clear
use longmake19Alt
keep  A_55
rename A_55 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 12 
save longmake19Alt12, replace

clear
use longmake19Alt
keep  A_60
rename A_60 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 13 
save longmake19Alt13, replace

clear
use longmake19Alt
keep  A_65
rename A_65 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 14 
save longmake19Alt14, replace

clear
use longmake19Alt
keep  A_70 
rename A_70 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 15
save longmake19Alt15, replace

clear
use longmake19Alt
keep  A_75
rename A_75 Todesfälle
gen Altersgruppe = 16
save longmake19Alt16, replace

clear
use longmake19Alt
keep  A_80 
rename A_80 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 17 
save longmake19Alt17, replace

clear
use longmake19Alt
keep  A_85
rename A_85 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 18 
save longmake19Alt18, replace

clear
use longmake19Alt
keep  A_90 
rename A_90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 19
save longmake19Alt19, replace

clear
use longmake19Alt
keep  A_gr90
rename A_gr90 Todesfälle
gen Altersgruppe = .
replace Altersgruppe = 20 
save longmake19Alt20, replace

clear
use longmake19Alt1
append using longmake19Alt2 longmake19Alt3 longmake19Alt4 longmake19Alt5 longmake19Alt6 longmake19Alt7 longmake19Alt8 ///
longmake19Alt9 longmake19Alt10 longmake19Alt11 longmake19Alt12 longmake19Alt13 longmake19Alt14 longmake19Alt15 ///
longmake19Alt16 longmake19Alt17 longmake19Alt18 longmake19Alt19 longmake19Alt20

save longmake19Altfertig, replace




clear 
use longmakeX202019 
merge 1:1 _n using longmake19Altfertig
drop _merge



label values Altersgruppe Altersgruppe
label def Altersgruppe 1 "Unter 1", modify
label def Altersgruppe 2 "1-4", modify
label def Altersgruppe 3 "5-9", modify
label def Altersgruppe 4 "10-14", modify
label def Altersgruppe 5 "15-19", modify
label def Altersgruppe 6 "20-24", modify
label def Altersgruppe 7 "25-29", modify
label def Altersgruppe 8 "30-34", modify
label def Altersgruppe 9 "35-39", modify
label def Altersgruppe 10 "40-44", modify
label def Altersgruppe 11 "45-49", modify
label def Altersgruppe 12 "50-54", modify
label def Altersgruppe 13 "55-59", modify
label def Altersgruppe 14 "60-64", modify
label def Altersgruppe 15 "65-69", modify
label def Altersgruppe 16 "70-74", modify
label def Altersgruppe 17 "75-79", modify
label def Altersgruppe 18 "80-84", modify
label def Altersgruppe 19 "85-89", modify
label def Altersgruppe 20 "90+", modify


save Todesursachen_2019fertig, replace
















use Todesursachen_2009fertig
append using Todesursachen_2010fertig Todesursachen_2011fertig Todesursachen_2012fertig Todesursachen_2013fertig ///
Todesursachen_2014fertig Todesursachen_2015fertig Todesursachen_2016fertig Todesursachen_2017fertig ///
Todesursachen_2018fertig Todesursachen_2019fertig


 

*----------------------Variablenaufbeareitung--------------------------*


numlabel _all, add force

set more off, permanently





// Hauptsächliche Variablen

gen Todesursachen = . 
replace Todesursachen= 1 if ICDnumerisch == 1  & Jahr
replace Todesursachen= 2 if ICDnumerisch == 2  & Jahr
replace Todesursachen= 3 if ICDnumerisch == 3 & Jahr
replace Todesursachen= 4 if ICDnumerisch == 4 & Jahr
replace Todesursachen = 5 if ICDnumerisch == 5 & Jahr
replace Todesursachen= 6 if ICDnumerisch == 6 & Jahr
replace Todesursachen= 7 if ICDnumerisch == 7 & Jahr
replace Todesursachen= 8 if ICDnumerisch == 8 & Jahr
replace Todesursachen= 9 if ICDnumerisch == 9 & Jahr
replace Todesursachen= 10 if ICDnumerisch == 10 & Jahr
replace Todesursachen= 11 if ICDnumerisch == 11 & Jahr
replace Todesursachen= 12 if ICDnumerisch == 12 & Jahr
replace Todesursachen= 13 if ICDnumerisch == 13 & Jahr
replace Todesursachen= 14 if ICDnumerisch == 14 & Jahr
replace Todesursachen= 15 if ICDnumerisch == 15 & Jahr
replace Todesursachen= 16 if ICDnumerisch == 16 & Jahr
replace Todesursachen= 17 if ICDnumerisch == 17 & Jahr
replace Todesursachen= 18 if ICDnumerisch == 18 & Jahr
replace Todesursachen= 19 if ICDnumerisch == 19 & Jahr
replace Todesursachen= 20 if ICDnumerisch == 20 & Jahr
replace Todesursachen = 21 if ICDnumerisch == 21 & Jahr
replace Todesursachen= 22 if ICDnumerisch == 22 & Jahr
replace Todesursachen= 23 if ICDnumerisch == 23 & Jahr
replace Todesursachen= 24 if ICDnumerisch == 24 & Jahr
replace Todesursachen= 25 if ICDnumerisch == 25 & Jahr
replace Todesursachen= 26 if ICDnumerisch == 26 & Jahr
replace Todesursachen= 27 if ICDnumerisch == 27 & Jahr
replace Todesursachen= 28 if ICDnumerisch == 28 & Jahr
replace Todesursachen= 29 if ICDnumerisch == 29 & Jahr
replace Todesursachen= 30 if ICDnumerisch == 30 & Jahr
replace Todesursachen= 31 if ICDnumerisch == 31 & Jahr

tabstat aeuw


label variable Todesursachen "Todesursachen"

label define Todesursachen ///
1 "Infektionskrankheiten" /// 
2 "Krebs" /// 
3 "Krankheit: Blut" /// 
4 "Endokrine, Ernährungs- und Stoffwechselkrankheiten" /// 
5 "Psychische und Verhaltensstörungen" /// 
6 "Krankheit: Nervensystems" /// 
7 "Krankheit: Auge" ///
8 "Krankheit: Ohr u. Warzenfortsatz" ///
9 "Krankheit: Kreislaufsystem" ///
10 "Krankheit: Atmungssystems" /// 
11 "Krankheiten: Verdauungssystems" /// 
12 "Krankheit: Haut" ///
13 "Krankheit: Muskel/Skelett/Bindegewebe" ///
14 "Krankheit: Urogenitals" ///
15 "Schwangerschaft/Geburt/Wochenbett" ///
16 "Urpsprung in der Perinatalperiode" ///
17 "Angeborene Fehlbildungen" ///
18 "Nicht klassifiziert" ///
19 "Verletzungen und Vergiftungen u.a." /// 
20 "Arbeitsunfalll" /// 
21 "Schulunfall" ///
22 "Verkehrsunfall" /// 
23 "Häuslicher Unfall" /// 
24 "Sportunfall" ///
25 "Sonstiger Unfall" ///
26 "Selbstbeschädigung" /// 
27 "Tätlicher Angriff" /// 
28 "Unklar ob U/TA/S" ///
29 "Gesetzliche Maßnahmen und Krieg" ///
30 "Zusammenhang Medizin" /// 
31 "Folgezustände" ///


label values Todesursachen Todesursachen 

/// Todesfälle Auswahl

gen Todauswahl = .
replace Todauswahl = 1 if Todesursachen == 1 & Jahr
replace Todauswahl = 2 if Todesursachen == 2 & Jahr
replace Todauswahl = 3 if Todesursachen == 4 & Jahr
replace Todauswahl = 4 if Todesursachen == 5 & Jahr
replace Todauswahl = 5 if Todesursachen == 6 & Jahr
replace Todauswahl = 6 if Todesursachen == 9 & Jahr
replace Todauswahl = 7 if Todesursachen == 10 & Jahr
replace Todauswahl = 8 if Todesursachen == 11 & Jahr
replace Todauswahl = 9 if Todesursachen == 19 & Jahr
replace Todauswahl = 10 if Todesursachen == 20 & Jahr
replace Todauswahl = 11 if Todesursachen == 22 & Jahr
replace Todauswahl = 12 if Todesursachen == 23 & Jahr
replace Todauswahl = 13 if Todesursachen == 26 & Jahr
replace Todauswahl = 14 if Todesursachen == 27 & Jahr 
replace Todauswahl = 15 if Todesursachen == 30 & Jahr
replace Todauswahl = 16 if inlist(Todesursachen,3,7,8,12,13,14,15,16,17,18,21,24,25,28,29,31) & Jahr


label variable Todauswahl "Todesursachen"

label define Todauswahl ///
1 "Infektionskrankheiten" /// 
2 "Krebs" /// 
3 "Endokrine, Ernährungs- und Stoffwechselkrankheiten" /// 
4 "Psychische und Verhaltensstörungen" /// 
5 "Krankheit: Nervensystems" /// 
6 "Krankheit: Kreislaufsystem" ///
7 "Krankheit: Atmungssystems" /// 
8 "Krankheiten: Verdauungssystems" /// 
9 "Verletzungen und Vergiftungen u.a." /// 
10 "Arbeitsunfalll" /// 
11 "Verkehrsunfall" /// 
12 "Häuslicher Unfall" /// 
13 "Selbstbeschädigung" /// 
14 "Tätlicher Angriff" /// 
15 "Zusammenhang Medizin" /// 
16 "Weitere Todesursachen" 

label values Todauswahl Todauswahl 



// Weitere Todesursachen

gen WeitereTod = . 
replace WeitereTod = 1 if Todesursachen == 3
replace WeitereTod = 2 if Todesursachen == 7
replace WeitereTod = 3 if Todesursachen == 8
replace WeitereTod = 4 if Todesursachen == 12
replace WeitereTod = 5 if Todesursachen == 13
replace WeitereTod = 6 if Todesursachen == 14
replace WeitereTod = 7 if Todesursachen == 15
replace WeitereTod = 8 if Todesursachen == 16
replace WeitereTod = 9 if Todesursachen == 17
replace WeitereTod = 10 if Todesursachen == 18
replace WeitereTod = 11 if Todesursachen == 21
replace WeitereTod = 12 if Todesursachen == 24
replace WeitereTod = 13 if Todesursachen == 25
replace WeitereTod = 14 if Todesursachen == 28
replace WeitereTod = 15 if Todesursachen == 29
replace WeitereTod = 16 if Todesursachen == 31



label values WeitereTod WeitereTod
label def WeitereTod 1 "Krankheit: Blut", modify
label def WeitereTod 2 "Krankheit: Auge", modify
label def WeitereTod 3 "Krankheit: Ohr u. Warzenfortsatz", modify
label def WeitereTod 4 "Krankheit: Haut", modify
label def WeitereTod 5 "Krankheit: Muskel/Skelett/Bindegewebe", modify
label def WeitereTod 6 "Krankheit: Urogenitals", modify
label def WeitereTod 7 "Schwangerschaft/Geburt/Wochenbett", modify
label def WeitereTod 8 "Urpsprung in der Perinatalperiode", modify
label def WeitereTod 9 "Angeborene Fehlbildungen", modify
label def WeitereTod 10 "Nicht klassifiziert", modify
label def WeitereTod 11 "Schulunfall", modify
label def WeitereTod 12 "Sportunfall", modify
label def WeitereTod 13 "Sonstiger Unfall", modify
label def WeitereTod 14 "Unklar ob U/TA/S", modify
label def WeitereTod 15 "Gesetzliche Maßnahmen und Krieg", modify
label def WeitereTod 16 "Folgezustände", modify





// Todesauswahl geordnet

gen Todauswahlord = .
replace Todauswahlord = 1 if Todauswahl == 6 & Jahr
replace Todauswahlord = 2 if Todauswahl == 2 & Jahr
replace Todauswahlord = 3 if Todauswahl == 16 & Jahr
replace Todauswahlord = 4 if Todauswahl == 7 & Jahr
replace Todauswahlord = 5 if Todauswahl == 4 & Jahr
replace Todauswahlord = 6 if Todauswahl == 9 & Jahr
replace Todauswahlord = 7 if Todauswahl == 8 & Jahr
replace Todauswahlord = 8 if Todauswahl == 5 & Jahr
replace Todauswahlord = 9 if Todauswahl == 3 & Jahr
replace Todauswahlord = 10 if Todauswahl == 1 & Jahr
replace Todauswahlord = 11 if Todauswahl == 12 & Jahr
replace Todauswahlord = 12 if Todauswahl == 13 & Jahr
replace Todauswahlord = 13 if Todauswahl == 11 & Jahr
replace Todauswahlord = 14 if Todauswahl == 15 & Jahr 
replace Todauswahlord = 15 if Todauswahl == 14 & Jahr
replace Todauswahlord = 16 if Todauswahl == 10 & Jahr


label variable Todauswahlord "TodesursachenOrd"

label define Todauswahlord ///
1 "Krankheit: Kreislaufsystem" ///
2 "Krebs" /// 
3 "Weitere Todesursachen" ///
4 "Krankheit: Atmungssystems" /// 
5 "Psychische und Verhaltensstörungen" /// 
6 "Verletzungen und Vergiftungen u.a." /// 
7 "Krankheiten: Verdauungssystems" /// 
8 "Krankheit: Nervensystems" /// 
9 "Endokrine, Ernährungs- und Stoffwechselkrankheiten" /// 
10 "Infektionskrankheiten" /// 
11 "Häuslicher Unfall" /// 
12 "Selbstbeschädigung" ///
13 "Verkehrsunfall" ///
14 "Zusammenhang Medizin" /// 
15 "Tätlicher Angriff" /// 
16 "Arbeitsunfalll" /// 

label values Todauswahlord Todauswahlord 



// Atemwegserkrankungen

gen Atemwegserkrankungen = .
replace Atemwegserkrankungen = 1 if ICDWK == 56 & Jahr
replace Atemwegserkrankungen = 2 if ICDWK == 57 & Jahr
replace Atemwegserkrankungen = 3 if ICDWK == 58 & Jahr
replace Atemwegserkrankungen = 4 if ICDWK == 59 & Jahr
replace Atemwegserkrankungen = 5 if ICDWK == 60 & Jahr
replace Atemwegserkrankungen = 6 if ICDWK == 61 & Jahr
replace Atemwegserkrankungen = 7 if ICDWK == 62 & Jahr
replace Atemwegserkrankungen = 8 if ICDWK == 63 & Jahr
replace Atemwegserkrankungen = 9 if ICDWK == 64 & Jahr
replace Atemwegserkrankungen = 10 if ICDWK == 65 & Jahr
replace Atemwegserkrankungen = 11 if ICDWK == 66 & Jahr
replace Atemwegserkrankungen = 12 if ICDWK == 67 & Jahr

label variable Atemwegserkrankungen "Todesursachen Atemwegserkrankungen"

label define Atemwegserkrankungen2 ///
1 "Akute Infektion der oberen Atemwege" ///
2 "Grippe" ///
3 "Viruspneumonie" ///
4 "Pneunomie (Bakterien)" ///
5 "Sonstige akute Infektionen der unteren Atemwege" ///
6 "Sonstige Krankheiten der oberen Atemwege" ///
7 "Chronische Krankheiten der unteren Atemwege" ///
8 "Lungenkrankheiten durch exogene Substanzen" ///
9 "Sonstige Krankheiten der Atmungsorgane" ///
10 "Purulente und nekrotisiertende Krankheiten" ///
11 "Sonstige Krankheiten der Pleura" ///
12 "Sonstgie Krankheiten des Atmungssystems" ///


// Sum für if und Ordnung

egen sumGestbyAltKat = sum(Todesfälle) if Jahr , by(Todesursachen Altersgruppe) 

egen sumGest  = sum(Todesfälle), by(Jahr)





label values Atemwegserkrankungen Atemwegserkrankungen2 

// Atemserkrankungen vs. Grippe/Pneunomie

gen AtemvsGri = .
replace AtemvsGri = 1 if inlist(Atemwegserkrankungen, 1,5,6,7,8,9,10,11,12) & Jahr
replace AtemvsGri = 2 if inlist(Atemwegserkrankungen,3,4)  & Jahr
replace AtemvsGri = 3 if Atemwegserkrankungen == 2 & Jahr

label variable AtemvsGri "Grippe, Pneumonie und andere Atemwegserkrankungen"
label define AtemvsGri ///
1 "Andere Atemwegserkrankungen" ///
2 "Pneunomien" ///
3 "Grippe" ///

label values AtemvsGri AtemvsGri 



// Todalle vs. Pneunomie vs. Grippe vs. Infektionskrankheiten

gen TodallevsPGI = .
replace TodallevsPGI = 1 if AtemvsGri == 1 & Jahr
replace TodallevsPGI = 2 if AtemvsGri == 2 & Jahr
replace TodallevsPGI = 3 if AtemvsGri == 3 & Jahr
replace TodallevsPGI = 4 if Todauswahl == 1 & Jahr
replace TodallevsPGI = 5 if Todauswahl != 1 & Todauswahl != 7 & Jahr

label variable TodallevsPGI "Todalle vs. Pneunomie vs. Grippe vs. Infektionskrankheiten"
label define TodallevsPGI ///
1 "Atemwegs- erkrankungen ohne Grippe und Pneunomien" ///
2 "Pneunomien" ///
3 "Grippe" ///
4 "Infektions- krankheiten" ///
5 "Restliche Krankheiten" ///

label values TodallevsPGI TodallevsPGI 

// Auf 100 Tausend

gen Todesfälle100 = .
replace Todesfälle100 = (Todesfälle/83092962)*100000 if Jahr == 2019
replace Todesfälle100 = (Todesfälle/82905782)*100000 if Jahr == 2018
replace Todesfälle100 = (Todesfälle/82657003)*100000 if Jahr == 2017
replace Todesfälle100 = (Todesfälle/82348669)*100000 if Jahr == 2016
replace Todesfälle100 = (Todesfälle/81686611)*100000 if Jahr == 2015
replace Todesfälle100 = (Todesfälle/80982500)*100000 if Jahr == 2014
replace Todesfälle100 = (Todesfälle/80645605)*100000 if Jahr == 2013
replace Todesfälle100 = (Todesfälle/81917349)*100000 if Jahr == 2012
replace Todesfälle100 = (Todesfälle/81779221)*100000 if Jahr == 2011
replace Todesfälle100 = (Todesfälle/81757471)*100000 if Jahr == 2010
replace Todesfälle100 = (Todesfälle/81874770)*100000 if Jahr == 2009

egen Todesfälle100sum = sum(Todesfälle100), by(Jahr)
egen Todesfälle100sumtotal = sum(Todesfälle100)


egen Todesfälle100sumTod = sum(Todesfälle100), by(Todesursachen)


// 100 geordnet 

/*
egen group = group(Todesfälle100sumTod) 
replace group = -group 
labmask group, values(Todesursachen) 
label var group "`: var label Todesursachen'" 

tabstat Todesfälle100sumTod, by(group) labelwidth(100) stat(mean)

*/



gen TodesU100ord = .
replace TodesU100ord = 1 if Todesursachen == 9 
replace TodesU100ord = 2 if Todesursachen == 2 
replace TodesU100ord = 3 if Todesursachen == 10 
replace TodesU100ord = 4 if Todesursachen == 11 
replace TodesU100ord = 5 if Todesursachen == 5   
replace TodesU100ord = 6 if Todesursachen == 19 
replace TodesU100ord = 7 if Todesursachen == 4  
replace TodesU100ord = 8 if Todesursachen == 18 
replace TodesU100ord = 9 if Todesursachen == 6  
replace TodesU100ord = 10 if inlist(Todesursachen,20,21,22,23,24,25,27,28,29,30,31)
replace TodesU100ord = 11 if Todesursachen == 14 
replace TodesU100ord = 12 if Todesursachen == 1  
replace TodesU100ord = 13 if inlist(Todesursachen,3,7,8,12,13,15,16,17)
replace TodesU100ord = 14 if Todesursachen == 26  

label values TodesU100ord TodesU100ord

label def TodesU100ord 1 "Kreislaufsystem", modify
label def TodesU100ord 2 "Krebs", modify
label def TodesU100ord 3 "Atmungssystem", modify
label def TodesU100ord 4 "Verdauungssystem", modify
label def TodesU100ord 5 "Psyche- und Verhaltensstörungen", modify
label def TodesU100ord 6 "Verletzungen / Vergiftungen (u.a.)", modify
label def TodesU100ord 7 "Stoffwechselkrankheiten (u.a.)", modify
label def TodesU100ord 8 "Nicht klassifiziert", modify
label def TodesU100ord 9 "Nervensystem", modify
label def TodesU100ord 10 "Unfälle (u.a.)", modify
label def TodesU100ord 11 "Urogenital", modify
label def TodesU100ord 12 "Infektionskrankheiten", modify
label def TodesU100ord 13  "Weitere Krankheiten", modify
label def TodesU100ord 14 "Selbstbeschädigung", modify


save Todesursachen0919long, replace



*----------------------Wide--------------------------*


numlabel _all, remove

tab TodesU100ord, gen(TA)
renvarlab TA*, lab
rename TodesU100ord_* *_TA

replace _Kreislaufsystem_TA        = Todesfälle100 if TodesU100ord == 1 & Jahr
replace _Krebs_TA                     = Todesfälle100 if TodesU100ord == 2 & Jahr 
replace _Atmungssystem_TA        = Todesfälle100 if TodesU100ord == 3 & Jahr
replace _Verdauungssystem_TA        = Todesfälle100 if TodesU100ord == 4 & Jahr 
replace _Psyche__und_Verhal_TA        = Todesfälle100 if TodesU100ord == 5 & Jahr 
replace _Verletzungen___Ver_TA        = Todesfälle100 if TodesU100ord == 6 & Jahr
replace _Stoffwechselkrankh_TA         = Todesfälle100 if TodesU100ord == 7 & Jahr 
replace _Nicht_klassifizier_TA        = Todesfälle100 if TodesU100ord == 8 & Jahr 
replace _Nervensystem_TA        = Todesfälle100 if TodesU100ord == 9 & Jahr 
replace _Unfälle__u_a___TA         = Todesfälle100 if TodesU100ord == 10 & Jahr 
replace _Urogenital_TA        = Todesfälle100 if TodesU100ord == 11 & Jahr 
replace _Infektionskrankhei_TA        = Todesfälle100 if TodesU100ord == 12 & Jahr 
replace _Weitere_Krankheite_TA        = Todesfälle100 if TodesU100ord == 13 & Jahr 
replace _Selbstbeschädigun_TA         = Todesfälle100 if TodesU100ord == 14 & Jahr
 

 *** (a) preserve the labels...

levelsof Todauswahlord, local(idlabels)      // store the id levels
 
foreach x of local idlabels {       
   local idlab_`x' : label id `x'  
   }
 
 
collapse (sum) *_TA Todesfälle100, by(Jahr)


save Todesursachen0919longcollapse, replace
