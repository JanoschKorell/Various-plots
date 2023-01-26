*STATA Grafiken
*Masterdofile

*Globyle Style Einstellungen

graph set window fontface "Abel"						
										
										
										
										
global path "/Users/janoschkorell/Desktop/Wissenschaft/Statistik/Deskriptive_Analyse/Stata_Grafiken"
//Janosch	

													
global data $path/Data
global dofi $path/DoFiles
global lofi $path/LogFiles
global grafi $path/Grafiken
log using $lofi/LogFileMaster, replace
********************************************************************************
****		DOFILE Daten 1: Todesursachen 			                        *****
********************************************************************************


do $dofi/TodesursachenDaten



********************************************************************************
****		DOFILE Grafiken 1: Bar Graph Pie Graph									    ****
********************************************************************************
*

*1. Bar Todesursachen  Durschnitt 0919
*2. Pie Todesursachen Durchschnitt 0919
*3. Bar Altersgruppen und Todesursachen Stack Percentage Durschnitt 0919
*4. Bar Überblick mit by 

do $dofi/BarPie


********************************************************************************
****		DOFILE Grafiken 2: Ridgeplots									    ****
********************************************************************************
*

*1. COVID19 Verlau der Fälle

do $dofi/RidgePlots



********************************************************************************
****		DOFILE Grafiken 3: Waffleplots									    ****
********************************************************************************
*

*1. Zustimmung zur Gerechtigkeit der Gleichheit in Europa

do $dofi/WafflePlots



********************************************************************************
****		DOFILE Grafiken 4: Circular Bar									    ****
********************************************************************************
*

*1. GDP per Capita worldwide

do $dofi/CircularBar





********************************************************************************
****		DOFILE Grafiken 5: TileMaps									    ****
********************************************************************************


*1. Zustimmung zur Gerechtigkeit der Gleichheit in Europa

do $dofi/TileMaps



********************************************************************************
****		DOFILE Grafiken 6: Sankey									    ****
********************************************************************************


do $dofi/Sankey



********************************************************************************
****		DOFILE Grafiken 7: Arc Plot									    ****
********************************************************************************


do $dofi/ArcPlot



********************************************************************************
****		DOFILE Grafiken 8: Rose (Coxcomb) Plot									    ****
********************************************************************************


do $dofi/RosePlot



********************************************************************************
****		DOFILE Grafiken 9: Heat Plot									    ****
********************************************************************************


do $dofi/HeatPlot



********************************************************************************
****		DOFILE Grafiken 10: Spider Plot									    ****
********************************************************************************


do $dofi/Spider




********************************************************************************
****		DOFILE Grafiken 11: Stream Plot									    ****
********************************************************************************


do $dofi/Streams



********************************************************************************
****		DOFILE Grafiken 11: Stream Plot									    ****
********************************************************************************


do $dofi/Radial






























