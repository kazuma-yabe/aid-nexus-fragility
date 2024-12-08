* Set directory
cd "~/Desktop/aid_nexus_fragility"

* Importing all pre-processed csv data into dta
import delimited "source_data/pillar_model/HMT_FSI.csv", delimiter(comma) encoding(ISO-8859-1)
save "data/pillar_model/HMT_FSI.dta", replace
clear

import delimited "source_data/pillar_modelDEV_FSI.csv", delimiter(comma) encoding(ISO-8859-1)
save "data/pillar_model/DEV_FSI.dta", replace
clear

import delimited "source_data/pillar_model/PEC_FSI.csv", delimiter(comma) encoding(ISO-8859-1)
save "data/pillar_model/PEC_FSI.dta", replace
clear

import delimited "source_data/pillar_model/HMT_SoF.csv", delimiter(comma) encoding(ISO-8859-1)
save "data/pillar_model/HMT_SoF.dta", replace
clear

import delimited "source_data/pillar_model/DEV_SoF.csv", delimiter(comma) encoding(ISO-8859-1)
save "data/pillar_model/DEV_SoF.dta", replace
clear

import delimited "source_data/pillar_model/PEC_SoF.csv", delimiter(comma) encoding(ISO-8859-1)
save "data/pillar_model/PEC_SoF.dta", replace
clear

*************************************
* IMPORTING UN voting data into dta

* Getting country names and codes
import delimited "source_data/UN_votes/UNVotes.csv", delimiter(comma) 
	* tenhle soubor asi neni to, co potrebujeme; ma ale country names...
	keep ccode country countryname session
	tab countryname if session == 75
	tab countryname if session == 70
	tab countryname if session == 77
	tab countryname if session == 73
	tab countryname if session == 65
	* session 75 has the most countries (di 18528/96 = 193) so I am keeping this
	keep if session == 75
	drop session
	drop in 194/18528
	tab country
	* now I have numerical codes, country codes and country names that I can use in the other dataset
save "data/UN_votes/country-codes-names.dta", replace
clear

* Getting the agreement scores
import delimited "source_data/UN_votes/AgreementScoresAll_Jul2023.csv", delimiter(comma)
	* we need ccode1 ccode2 agree year, that's probably it...(no need of sessions and the other variables...)
	keep ccode1 ccode2 agree year
	* we can also limit the years to what Kazuma is using (regarding lags - he is creating this during calculation, therefore I need to match his years precisely)
	keep if year > 2007 & year < 2020
	sum year /*2008-2019 which matches precisely */
save "data/UN_votes/un-agree_ccodes_2008-2019.dta", replace
clear

* Changing country names and codes to merge the data
use "data/UN_votes/un-agree_ccodes_2008-2019.dta"

{
gen country1 = ""
replace country1 = "AFG" if ccode1 == 700
replace country1 = "ALB" if ccode1 == 339
replace country1 = "DZA" if ccode1 == 615
replace country1 = "AND" if ccode1 == 232
replace country1 = "AGO" if ccode1 == 540
replace country1 = "ATG" if ccode1 == 58
replace country1 = "ARG" if ccode1 == 160
replace country1 = "ARM" if ccode1 == 371
replace country1 = "AUS" if ccode1 == 900
replace country1 = "AUT" if ccode1 == 305
replace country1 = "AZE" if ccode1 == 373
replace country1 = "BHS" if ccode1 == 31
replace country1 = "BHR" if ccode1 == 692
replace country1 = "BGD" if ccode1 == 771
replace country1 = "BRB" if ccode1 == 53
replace country1 = "BLR" if ccode1 == 370
replace country1 = "BEL" if ccode1 == 211
replace country1 = "BLZ" if ccode1 == 80
replace country1 = "BEN" if ccode1 == 434
replace country1 = "BTN" if ccode1 == 760
replace country1 = "BOL" if ccode1 == 145
replace country1 = "BIH" if ccode1 == 346
replace country1 = "BWA" if ccode1 == 571
replace country1 = "BRA" if ccode1 == 140
replace country1 = "BRN" if ccode1 == 835
replace country1 = "BGR" if ccode1 == 355
replace country1 = "BFA" if ccode1 == 439
replace country1 = "BDI" if ccode1 == 516
replace country1 = "CPV" if ccode1 == 402
replace country1 = "KHM" if ccode1 == 811
replace country1 = "CMR" if ccode1 == 471
replace country1 = "CAN" if ccode1 == 20
replace country1 = "CAF" if ccode1 == 482
replace country1 = "TCD" if ccode1 == 483
replace country1 = "CHL" if ccode1 == 155
replace country1 = "CHN" if ccode1 == 710
replace country1 = "COL" if ccode1 == 100
replace country1 = "COM" if ccode1 == 581
replace country1 = "COG" if ccode1 == 484
replace country1 = "CRI" if ccode1 == 94
replace country1 = "CIV" if ccode1 == 437
replace country1 = "HRV" if ccode1 == 344
replace country1 = "CUB" if ccode1 == 40
replace country1 = "CYP" if ccode1 == 352
replace country1 = "CZE" if ccode1 == 316
replace country1 = "PRK" if ccode1 == 731
replace country1 = "COD" if ccode1 == 490
replace country1 = "DNK" if ccode1 == 390
replace country1 = "DJI" if ccode1 == 522
replace country1 = "DMA" if ccode1 == 54
replace country1 = "DOM" if ccode1 == 42
replace country1 = "ECU" if ccode1 == 130
replace country1 = "EGY" if ccode1 == 651
replace country1 = "SLV" if ccode1 == 92
replace country1 = "GNQ" if ccode1 == 411
replace country1 = "ERI" if ccode1 == 531
replace country1 = "EST" if ccode1 == 366
replace country1 = "SWZ" if ccode1 == 572
replace country1 = "ETH" if ccode1 == 530
replace country1 = "FJI" if ccode1 == 950
replace country1 = "FIN" if ccode1 == 375
replace country1 = "FRA" if ccode1 == 220
replace country1 = "GAB" if ccode1 == 481
replace country1 = "GMB" if ccode1 == 420
replace country1 = "GEO" if ccode1 == 372
replace country1 = "DEU" if ccode1 == 255
replace country1 = "GHA" if ccode1 == 452
replace country1 = "GRC" if ccode1 == 350
replace country1 = "GRD" if ccode1 == 55
replace country1 = "GTM" if ccode1 == 90
replace country1 = "GIN" if ccode1 == 438
replace country1 = "GNB" if ccode1 == 404
replace country1 = "GUY" if ccode1 == 110
replace country1 = "HTI" if ccode1 == 41
replace country1 = "HND" if ccode1 == 91
replace country1 = "HUN" if ccode1 == 310
replace country1 = "ISL" if ccode1 == 395
replace country1 = "IND" if ccode1 == 750
replace country1 = "IDN" if ccode1 == 850
replace country1 = "IRN" if ccode1 == 630
replace country1 = "IRQ" if ccode1 == 645
replace country1 = "IRL" if ccode1 == 205
replace country1 = "ISR" if ccode1 == 666
replace country1 = "ITA" if ccode1 == 325
replace country1 = "JAM" if ccode1 == 51
replace country1 = "JPN" if ccode1 == 740
replace country1 = "JOR" if ccode1 == 663
replace country1 = "KAZ" if ccode1 == 705
replace country1 = "KEN" if ccode1 == 501
replace country1 = "KIR" if ccode1 == 946
replace country1 = "KWT" if ccode1 == 690
replace country1 = "KGZ" if ccode1 == 703
replace country1 = "LAO" if ccode1 == 812
replace country1 = "LVA" if ccode1 == 367
replace country1 = "LBN" if ccode1 == 660
replace country1 = "LSO" if ccode1 == 570
replace country1 = "LBR" if ccode1 == 450
replace country1 = "LBY" if ccode1 == 620
replace country1 = "LIE" if ccode1 == 223
replace country1 = "LTU" if ccode1 == 368
replace country1 = "LUX" if ccode1 == 212
replace country1 = "MDG" if ccode1 == 580
replace country1 = "MWI" if ccode1 == 553
replace country1 = "MYS" if ccode1 == 820
replace country1 = "MDV" if ccode1 == 781
replace country1 = "MLI" if ccode1 == 432
replace country1 = "MLT" if ccode1 == 338
replace country1 = "MHL" if ccode1 == 983
replace country1 = "MRT" if ccode1 == 435
replace country1 = "MUS" if ccode1 == 590
replace country1 = "MEX" if ccode1 == 70
replace country1 = "FSM" if ccode1 == 987
replace country1 = "MCO" if ccode1 == 221
replace country1 = "MNG" if ccode1 == 712
replace country1 = "MNE" if ccode1 == 341
replace country1 = "MAR" if ccode1 == 600
replace country1 = "MOZ" if ccode1 == 541
replace country1 = "MMR" if ccode1 == 775
replace country1 = "NAM" if ccode1 == 565
replace country1 = "NRU" if ccode1 == 970
replace country1 = "NPL" if ccode1 == 790
replace country1 = "NLD" if ccode1 == 210
replace country1 = "NZL" if ccode1 == 920
replace country1 = "NIC" if ccode1 == 93
replace country1 = "NER" if ccode1 == 436
replace country1 = "NGA" if ccode1 == 475
replace country1 = "MKD" if ccode1 == 343
replace country1 = "NOR" if ccode1 == 385
replace country1 = "OMN" if ccode1 == 698
replace country1 = "PAK" if ccode1 == 770
replace country1 = "PLW" if ccode1 == 986
replace country1 = "PAN" if ccode1 == 95
replace country1 = "PNG" if ccode1 == 910
replace country1 = "PRY" if ccode1 == 150
replace country1 = "PER" if ccode1 == 135
replace country1 = "PHL" if ccode1 == 840
replace country1 = "POL" if ccode1 == 290
replace country1 = "PRT" if ccode1 == 235
replace country1 = "QAT" if ccode1 == 694
replace country1 = "KOR" if ccode1 == 732
replace country1 = "MDA" if ccode1 == 359
replace country1 = "ROU" if ccode1 == 360
replace country1 = "RUS" if ccode1 == 365
replace country1 = "RWA" if ccode1 == 517
replace country1 = "KNA" if ccode1 == 60
replace country1 = "LCA" if ccode1 == 56
replace country1 = "VCT" if ccode1 == 57
replace country1 = "WSM" if ccode1 == 990
replace country1 = "SMR" if ccode1 == 331
replace country1 = "STP" if ccode1 == 403
replace country1 = "SAU" if ccode1 == 670
replace country1 = "SEN" if ccode1 == 433
replace country1 = "YUG" if ccode1 == 345
replace country1 = "SYC" if ccode1 == 591
replace country1 = "SLE" if ccode1 == 451
replace country1 = "SGP" if ccode1 == 830
replace country1 = "SVK" if ccode1 == 317
replace country1 = "SVN" if ccode1 == 349
replace country1 = "SLB" if ccode1 == 940
replace country1 = "SOM" if ccode1 == 520
replace country1 = "ZAF" if ccode1 == 560
replace country1 = "SSD" if ccode1 == 626
replace country1 = "ESP" if ccode1 == 230
replace country1 = "LKA" if ccode1 == 780
replace country1 = "SDN" if ccode1 == 625
replace country1 = "SUR" if ccode1 == 115
replace country1 = "SWE" if ccode1 == 380
replace country1 = "CHE" if ccode1 == 225
replace country1 = "SYR" if ccode1 == 652
replace country1 = "TJK" if ccode1 == 702
replace country1 = "THA" if ccode1 == 800
replace country1 = "TLS" if ccode1 == 860
replace country1 = "TGO" if ccode1 == 461
replace country1 = "TON" if ccode1 == 955
replace country1 = "TTO" if ccode1 == 52
replace country1 = "TUN" if ccode1 == 616
replace country1 = "TUR" if ccode1 == 640
replace country1 = "TKM" if ccode1 == 701
replace country1 = "TUV" if ccode1 == 947
replace country1 = "UGA" if ccode1 == 500
replace country1 = "UKR" if ccode1 == 369
replace country1 = "ARE" if ccode1 == 696
replace country1 = "GBR" if ccode1 == 200
replace country1 = "TZA" if ccode1 == 510
replace country1 = "USA" if ccode1 == 2
replace country1 = "URY" if ccode1 == 165
replace country1 = "UZB" if ccode1 == 704
replace country1 = "VUT" if ccode1 == 935
replace country1 = "VEN" if ccode1 == 101
replace country1 = "VNM" if ccode1 == 816
replace country1 = "YEM" if ccode1 == 679
replace country1 = "ZMB" if ccode1 == 551
replace country1 = "ZWE" if ccode1 == 552

gen countryname1 = ""
replace countryname1 = "Afghanistan" if ccode1 == 700
replace countryname1 = "Albania" if ccode1 == 339
replace countryname1 = "Algeria" if ccode1 == 615
replace countryname1 = "Andorra" if ccode1 == 232
replace countryname1 = "Angola" if ccode1 == 540
replace countryname1 = "Antigua & Barbuda" if ccode1 == 58
replace countryname1 = "Argentina" if ccode1 == 160
replace countryname1 = "Armenia" if ccode1 == 371
replace countryname1 = "Australia" if ccode1 == 900
replace countryname1 = "Austria" if ccode1 == 305
replace countryname1 = "Azerbaijan" if ccode1 == 373
replace countryname1 = "Bahamas" if ccode1 == 31
replace countryname1 = "Bahrain" if ccode1 == 692
replace countryname1 = "Bangladesh" if ccode1 == 771
replace countryname1 = "Barbados" if ccode1 == 53
replace countryname1 = "Belarus" if ccode1 == 370
replace countryname1 = "Belgium" if ccode1 == 211
replace countryname1 = "Belize" if ccode1 == 80
replace countryname1 = "Benin" if ccode1 == 434
replace countryname1 = "Bhutan" if ccode1 == 760
replace countryname1 = "Bolivia" if ccode1 == 145
replace countryname1 = "Bosnia & Herzegovina" if ccode1 == 346
replace countryname1 = "Botswana" if ccode1 == 571
replace countryname1 = "Brazil" if ccode1 == 140
replace countryname1 = "Brunei" if ccode1 == 835
replace countryname1 = "Bulgaria" if ccode1 == 355
replace countryname1 = "Burkina Faso" if ccode1 == 439
replace countryname1 = "Burundi" if ccode1 == 516
replace countryname1 = "Cape Verde" if ccode1 == 402
replace countryname1 = "Cambodia" if ccode1 == 811
replace countryname1 = "Cameroon" if ccode1 == 471
replace countryname1 = "Canada" if ccode1 == 20
replace countryname1 = "Central African Republic" if ccode1 == 482
replace countryname1 = "Chad" if ccode1 == 483
replace countryname1 = "Chile" if ccode1 == 155
replace countryname1 = "China" if ccode1 == 710
replace countryname1 = "Colombia" if ccode1 == 100
replace countryname1 = "Comoros" if ccode1 == 581
replace countryname1 = "Congo - Brazzaville" if ccode1 == 484
replace countryname1 = "Costa Rica" if ccode1 == 94
replace countryname1 = "CÃ´te dâIvoire" if ccode1 == 437
replace countryname1 = "Croatia" if ccode1 == 344
replace countryname1 = "Cuba" if ccode1 == 40
replace countryname1 = "Cyprus" if ccode1 == 352
replace countryname1 = "Czechia" if ccode1 == 316
replace countryname1 = "North Korea" if ccode1 == 731
replace countryname1 = "Congo - Kinshasa" if ccode1 == 490
replace countryname1 = "Denmark" if ccode1 == 390
replace countryname1 = "Djibouti" if ccode1 == 522
replace countryname1 = "Dominica" if ccode1 == 54
replace countryname1 = "Dominican Republic" if ccode1 == 42
replace countryname1 = "Ecuador" if ccode1 == 130
replace countryname1 = "Egypt" if ccode1 == 651
replace countryname1 = "El Salvador" if ccode1 == 92
replace countryname1 = "Equatorial Guinea" if ccode1 == 411
replace countryname1 = "Eritrea" if ccode1 == 531
replace countryname1 = "Estonia" if ccode1 == 366
replace countryname1 = "Eswatini" if ccode1 == 572
replace countryname1 = "Ethiopia" if ccode1 == 530
replace countryname1 = "Fiji" if ccode1 == 950
replace countryname1 = "Finland" if ccode1 == 375
replace countryname1 = "France" if ccode1 == 220
replace countryname1 = "Gabon" if ccode1 == 481
replace countryname1 = "Gambia" if ccode1 == 420
replace countryname1 = "Georgia" if ccode1 == 372
replace countryname1 = "Germany" if ccode1 == 255
replace countryname1 = "Ghana" if ccode1 == 452
replace countryname1 = "Greece" if ccode1 == 350
replace countryname1 = "Grenada" if ccode1 == 55
replace countryname1 = "Guatemala" if ccode1 == 90
replace countryname1 = "Guinea" if ccode1 == 438
replace countryname1 = "Guinea-Bissau" if ccode1 == 404
replace countryname1 = "Guyana" if ccode1 == 110
replace countryname1 = "Haiti" if ccode1 == 41
replace countryname1 = "Honduras" if ccode1 == 91
replace countryname1 = "Hungary" if ccode1 == 310
replace countryname1 = "Iceland" if ccode1 == 395
replace countryname1 = "India" if ccode1 == 750
replace countryname1 = "Indonesia" if ccode1 == 850
replace countryname1 = "Iran" if ccode1 == 630
replace countryname1 = "Iraq" if ccode1 == 645
replace countryname1 = "Ireland" if ccode1 == 205
replace countryname1 = "Israel" if ccode1 == 666
replace countryname1 = "Italy" if ccode1 == 325
replace countryname1 = "Jamaica" if ccode1 == 51
replace countryname1 = "Japan" if ccode1 == 740
replace countryname1 = "Jordan" if ccode1 == 663
replace countryname1 = "Kazakhstan" if ccode1 == 705
replace countryname1 = "Kenya" if ccode1 == 501
replace countryname1 = "Kiribati" if ccode1 == 946
replace countryname1 = "Kuwait" if ccode1 == 690
replace countryname1 = "Kyrgyzstan" if ccode1 == 703
replace countryname1 = "Laos" if ccode1 == 812
replace countryname1 = "Latvia" if ccode1 == 367
replace countryname1 = "Lebanon" if ccode1 == 660
replace countryname1 = "Lesotho" if ccode1 == 570
replace countryname1 = "Liberia" if ccode1 == 450
replace countryname1 = "Libya" if ccode1 == 620
replace countryname1 = "Liechtenstein" if ccode1 == 223
replace countryname1 = "Lithuania" if ccode1 == 368
replace countryname1 = "Luxembourg" if ccode1 == 212
replace countryname1 = "Madagascar" if ccode1 == 580
replace countryname1 = "Malawi" if ccode1 == 553
replace countryname1 = "Malaysia" if ccode1 == 820
replace countryname1 = "Maldives" if ccode1 == 781
replace countryname1 = "Mali" if ccode1 == 432
replace countryname1 = "Malta" if ccode1 == 338
replace countryname1 = "Marshall Islands" if ccode1 == 983
replace countryname1 = "Mauritania" if ccode1 == 435
replace countryname1 = "Mauritius" if ccode1 == 590
replace countryname1 = "Mexico" if ccode1 == 70
replace countryname1 = "Micronesia (Federated States of)" if ccode1 == 987
replace countryname1 = "Monaco" if ccode1 == 221
replace countryname1 = "Mongolia" if ccode1 == 712
replace countryname1 = "Montenegro" if ccode1 == 341
replace countryname1 = "Morocco" if ccode1 == 600
replace countryname1 = "Mozambique" if ccode1 == 541
replace countryname1 = "Myanmar (Burma)" if ccode1 == 775
replace countryname1 = "Namibia" if ccode1 == 565
replace countryname1 = "Nauru" if ccode1 == 970
replace countryname1 = "Nepal" if ccode1 == 790
replace countryname1 = "Netherlands" if ccode1 == 210
replace countryname1 = "New Zealand" if ccode1 == 920
replace countryname1 = "Nicaragua" if ccode1 == 93
replace countryname1 = "Niger" if ccode1 == 436
replace countryname1 = "Nigeria" if ccode1 == 475
replace countryname1 = "North Macedonia" if ccode1 == 343
replace countryname1 = "Norway" if ccode1 == 385
replace countryname1 = "Oman" if ccode1 == 698
replace countryname1 = "Pakistan" if ccode1 == 770
replace countryname1 = "Palau" if ccode1 == 986
replace countryname1 = "Panama" if ccode1 == 95
replace countryname1 = "Papua New Guinea" if ccode1 == 910
replace countryname1 = "Paraguay" if ccode1 == 150
replace countryname1 = "Peru" if ccode1 == 135
replace countryname1 = "Philippines" if ccode1 == 840
replace countryname1 = "Poland" if ccode1 == 290
replace countryname1 = "Portugal" if ccode1 == 235
replace countryname1 = "Qatar" if ccode1 == 694
replace countryname1 = "South Korea" if ccode1 == 732
replace countryname1 = "Moldova" if ccode1 == 359
replace countryname1 = "Romania" if ccode1 == 360
replace countryname1 = "Russia" if ccode1 == 365
replace countryname1 = "Rwanda" if ccode1 == 517
replace countryname1 = "St. Kitts & Nevis" if ccode1 == 60
replace countryname1 = "St. Lucia" if ccode1 == 56
replace countryname1 = "St. Vincent & Grenadines" if ccode1 == 57
replace countryname1 = "Samoa" if ccode1 == 990
replace countryname1 = "San Marino" if ccode1 == 331
replace countryname1 = "SÃ£o TomÃ© & PrÃ­ncipe" if ccode1 == 403
replace countryname1 = "Saudi Arabia" if ccode1 == 670
replace countryname1 = "Senegal" if ccode1 == 433
replace countryname1 = "Yugoslavia" if ccode1 == 345
replace countryname1 = "Seychelles" if ccode1 == 591
replace countryname1 = "Sierra Leone" if ccode1 == 451
replace countryname1 = "Singapore" if ccode1 == 830
replace countryname1 = "Slovakia" if ccode1 == 317
replace countryname1 = "Slovenia" if ccode1 == 349
replace countryname1 = "Solomon Islands" if ccode1 == 940
replace countryname1 = "Somalia" if ccode1 == 520
replace countryname1 = "South Africa" if ccode1 == 560
replace countryname1 = "South Sudan" if ccode1 == 626
replace countryname1 = "Spain" if ccode1 == 230
replace countryname1 = "Sri Lanka" if ccode1 == 780
replace countryname1 = "Sudan" if ccode1 == 625
replace countryname1 = "Suriname" if ccode1 == 115
replace countryname1 = "Sweden" if ccode1 == 380
replace countryname1 = "Switzerland" if ccode1 == 225
replace countryname1 = "Syria" if ccode1 == 652
replace countryname1 = "Tajikistan" if ccode1 == 702
replace countryname1 = "Thailand" if ccode1 == 800
replace countryname1 = "Timor-Leste" if ccode1 == 860
replace countryname1 = "Togo" if ccode1 == 461
replace countryname1 = "Tonga" if ccode1 == 955
replace countryname1 = "Trinidad & Tobago" if ccode1 == 52
replace countryname1 = "Tunisia" if ccode1 == 616
replace countryname1 = "Turkey" if ccode1 == 640
replace countryname1 = "Turkmenistan" if ccode1 == 701
replace countryname1 = "Tuvalu" if ccode1 == 947
replace countryname1 = "Uganda" if ccode1 == 500
replace countryname1 = "Ukraine" if ccode1 == 369
replace countryname1 = "United Arab Emirates" if ccode1 == 696
replace countryname1 = "United Kingdom" if ccode1 == 200
replace countryname1 = "Tanzania" if ccode1 == 510
replace countryname1 = "United States" if ccode1 == 2
replace countryname1 = "Uruguay" if ccode1 == 165
replace countryname1 = "Uzbekistan" if ccode1 == 704
replace countryname1 = "Vanuatu" if ccode1 == 935
replace countryname1 = "Venezuela" if ccode1 == 101
replace countryname1 = "Vietnam" if ccode1 == 816
replace countryname1 = "Yemen" if ccode1 == 679
replace countryname1 = "Zambia" if ccode1 == 551
replace countryname1 = "Zimbabwe" if ccode1 == 552


gen country2 = ""
replace country2 = "AFG" if ccode2 == 700
replace country2 = "ALB" if ccode2 == 339
replace country2 = "DZA" if ccode2 == 615
replace country2 = "AND" if ccode2 == 232
replace country2 = "AGO" if ccode2 == 540
replace country2 = "ATG" if ccode2 == 58
replace country2 = "ARG" if ccode2 == 160
replace country2 = "ARM" if ccode2 == 371
replace country2 = "AUS" if ccode2 == 900
replace country2 = "AUT" if ccode2 == 305
replace country2 = "AZE" if ccode2 == 373
replace country2 = "BHS" if ccode2 == 31
replace country2 = "BHR" if ccode2 == 692
replace country2 = "BGD" if ccode2 == 771
replace country2 = "BRB" if ccode2 == 53
replace country2 = "BLR" if ccode2 == 370
replace country2 = "BEL" if ccode2 == 211
replace country2 = "BLZ" if ccode2 == 80
replace country2 = "BEN" if ccode2 == 434
replace country2 = "BTN" if ccode2 == 760
replace country2 = "BOL" if ccode2 == 145
replace country2 = "BIH" if ccode2 == 346
replace country2 = "BWA" if ccode2 == 571
replace country2 = "BRA" if ccode2 == 140
replace country2 = "BRN" if ccode2 == 835
replace country2 = "BGR" if ccode2 == 355
replace country2 = "BFA" if ccode2 == 439
replace country2 = "BDI" if ccode2 == 516
replace country2 = "CPV" if ccode2 == 402
replace country2 = "KHM" if ccode2 == 811
replace country2 = "CMR" if ccode2 == 471
replace country2 = "CAN" if ccode2 == 20
replace country2 = "CAF" if ccode2 == 482
replace country2 = "TCD" if ccode2 == 483
replace country2 = "CHL" if ccode2 == 155
replace country2 = "CHN" if ccode2 == 710
replace country2 = "COL" if ccode2 == 100
replace country2 = "COM" if ccode2 == 581
replace country2 = "COG" if ccode2 == 484
replace country2 = "CRI" if ccode2 == 94
replace country2 = "CIV" if ccode2 == 437
replace country2 = "HRV" if ccode2 == 344
replace country2 = "CUB" if ccode2 == 40
replace country2 = "CYP" if ccode2 == 352
replace country2 = "CZE" if ccode2 == 316
replace country2 = "PRK" if ccode2 == 731
replace country2 = "COD" if ccode2 == 490
replace country2 = "DNK" if ccode2 == 390
replace country2 = "DJI" if ccode2 == 522
replace country2 = "DMA" if ccode2 == 54
replace country2 = "DOM" if ccode2 == 42
replace country2 = "ECU" if ccode2 == 130
replace country2 = "EGY" if ccode2 == 651
replace country2 = "SLV" if ccode2 == 92
replace country2 = "GNQ" if ccode2 == 411
replace country2 = "ERI" if ccode2 == 531
replace country2 = "EST" if ccode2 == 366
replace country2 = "SWZ" if ccode2 == 572
replace country2 = "ETH" if ccode2 == 530
replace country2 = "FJI" if ccode2 == 950
replace country2 = "FIN" if ccode2 == 375
replace country2 = "FRA" if ccode2 == 220
replace country2 = "GAB" if ccode2 == 481
replace country2 = "GMB" if ccode2 == 420
replace country2 = "GEO" if ccode2 == 372
replace country2 = "DEU" if ccode2 == 255
replace country2 = "GHA" if ccode2 == 452
replace country2 = "GRC" if ccode2 == 350
replace country2 = "GRD" if ccode2 == 55
replace country2 = "GTM" if ccode2 == 90
replace country2 = "GIN" if ccode2 == 438
replace country2 = "GNB" if ccode2 == 404
replace country2 = "GUY" if ccode2 == 110
replace country2 = "HTI" if ccode2 == 41
replace country2 = "HND" if ccode2 == 91
replace country2 = "HUN" if ccode2 == 310
replace country2 = "ISL" if ccode2 == 395
replace country2 = "IND" if ccode2 == 750
replace country2 = "IDN" if ccode2 == 850
replace country2 = "IRN" if ccode2 == 630
replace country2 = "IRQ" if ccode2 == 645
replace country2 = "IRL" if ccode2 == 205
replace country2 = "ISR" if ccode2 == 666
replace country2 = "ITA" if ccode2 == 325
replace country2 = "JAM" if ccode2 == 51
replace country2 = "JPN" if ccode2 == 740
replace country2 = "JOR" if ccode2 == 663
replace country2 = "KAZ" if ccode2 == 705
replace country2 = "KEN" if ccode2 == 501
replace country2 = "KIR" if ccode2 == 946
replace country2 = "KWT" if ccode2 == 690
replace country2 = "KGZ" if ccode2 == 703
replace country2 = "LAO" if ccode2 == 812
replace country2 = "LVA" if ccode2 == 367
replace country2 = "LBN" if ccode2 == 660
replace country2 = "LSO" if ccode2 == 570
replace country2 = "LBR" if ccode2 == 450
replace country2 = "LBY" if ccode2 == 620
replace country2 = "LIE" if ccode2 == 223
replace country2 = "LTU" if ccode2 == 368
replace country2 = "LUX" if ccode2 == 212
replace country2 = "MDG" if ccode2 == 580
replace country2 = "MWI" if ccode2 == 553
replace country2 = "MYS" if ccode2 == 820
replace country2 = "MDV" if ccode2 == 781
replace country2 = "MLI" if ccode2 == 432
replace country2 = "MLT" if ccode2 == 338
replace country2 = "MHL" if ccode2 == 983
replace country2 = "MRT" if ccode2 == 435
replace country2 = "MUS" if ccode2 == 590
replace country2 = "MEX" if ccode2 == 70
replace country2 = "FSM" if ccode2 == 987
replace country2 = "MCO" if ccode2 == 221
replace country2 = "MNG" if ccode2 == 712
replace country2 = "MNE" if ccode2 == 341
replace country2 = "MAR" if ccode2 == 600
replace country2 = "MOZ" if ccode2 == 541
replace country2 = "MMR" if ccode2 == 775
replace country2 = "NAM" if ccode2 == 565
replace country2 = "NRU" if ccode2 == 970
replace country2 = "NPL" if ccode2 == 790
replace country2 = "NLD" if ccode2 == 210
replace country2 = "NZL" if ccode2 == 920
replace country2 = "NIC" if ccode2 == 93
replace country2 = "NER" if ccode2 == 436
replace country2 = "NGA" if ccode2 == 475
replace country2 = "MKD" if ccode2 == 343
replace country2 = "NOR" if ccode2 == 385
replace country2 = "OMN" if ccode2 == 698
replace country2 = "PAK" if ccode2 == 770
replace country2 = "PLW" if ccode2 == 986
replace country2 = "PAN" if ccode2 == 95
replace country2 = "PNG" if ccode2 == 910
replace country2 = "PRY" if ccode2 == 150
replace country2 = "PER" if ccode2 == 135
replace country2 = "PHL" if ccode2 == 840
replace country2 = "POL" if ccode2 == 290
replace country2 = "PRT" if ccode2 == 235
replace country2 = "QAT" if ccode2 == 694
replace country2 = "KOR" if ccode2 == 732
replace country2 = "MDA" if ccode2 == 359
replace country2 = "ROU" if ccode2 == 360
replace country2 = "RUS" if ccode2 == 365
replace country2 = "RWA" if ccode2 == 517
replace country2 = "KNA" if ccode2 == 60
replace country2 = "LCA" if ccode2 == 56
replace country2 = "VCT" if ccode2 == 57
replace country2 = "WSM" if ccode2 == 990
replace country2 = "SMR" if ccode2 == 331
replace country2 = "STP" if ccode2 == 403
replace country2 = "SAU" if ccode2 == 670
replace country2 = "SEN" if ccode2 == 433
replace country2 = "YUG" if ccode2 == 345
replace country2 = "SYC" if ccode2 == 591
replace country2 = "SLE" if ccode2 == 451
replace country2 = "SGP" if ccode2 == 830
replace country2 = "SVK" if ccode2 == 317
replace country2 = "SVN" if ccode2 == 349
replace country2 = "SLB" if ccode2 == 940
replace country2 = "SOM" if ccode2 == 520
replace country2 = "ZAF" if ccode2 == 560
replace country2 = "SSD" if ccode2 == 626
replace country2 = "ESP" if ccode2 == 230
replace country2 = "LKA" if ccode2 == 780
replace country2 = "SDN" if ccode2 == 625
replace country2 = "SUR" if ccode2 == 115
replace country2 = "SWE" if ccode2 == 380
replace country2 = "CHE" if ccode2 == 225
replace country2 = "SYR" if ccode2 == 652
replace country2 = "TJK" if ccode2 == 702
replace country2 = "THA" if ccode2 == 800
replace country2 = "TLS" if ccode2 == 860
replace country2 = "TGO" if ccode2 == 461
replace country2 = "TON" if ccode2 == 955
replace country2 = "TTO" if ccode2 == 52
replace country2 = "TUN" if ccode2 == 616
replace country2 = "TUR" if ccode2 == 640
replace country2 = "TKM" if ccode2 == 701
replace country2 = "TUV" if ccode2 == 947
replace country2 = "UGA" if ccode2 == 500
replace country2 = "UKR" if ccode2 == 369
replace country2 = "ARE" if ccode2 == 696
replace country2 = "GBR" if ccode2 == 200
replace country2 = "TZA" if ccode2 == 510
replace country2 = "USA" if ccode2 == 2
replace country2 = "URY" if ccode2 == 165
replace country2 = "UZB" if ccode2 == 704
replace country2 = "VUT" if ccode2 == 935
replace country2 = "VEN" if ccode2 == 101
replace country2 = "VNM" if ccode2 == 816
replace country2 = "YEM" if ccode2 == 679
replace country2 = "ZMB" if ccode2 == 551
replace country2 = "ZWE" if ccode2 == 552

gen countryname2 = ""
replace countryname2 = "Afghanistan" if ccode2 == 700
replace countryname2 = "Albania" if ccode2 == 339
replace countryname2 = "Algeria" if ccode2 == 615
replace countryname2 = "Andorra" if ccode2 == 232
replace countryname2 = "Angola" if ccode2 == 540
replace countryname2 = "Antigua & Barbuda" if ccode2 == 58
replace countryname2 = "Argentina" if ccode2 == 160
replace countryname2 = "Armenia" if ccode2 == 371
replace countryname2 = "Australia" if ccode2 == 900
replace countryname2 = "Austria" if ccode2 == 305
replace countryname2 = "Azerbaijan" if ccode2 == 373
replace countryname2 = "Bahamas" if ccode2 == 31
replace countryname2 = "Bahrain" if ccode2 == 692
replace countryname2 = "Bangladesh" if ccode2 == 771
replace countryname2 = "Barbados" if ccode2 == 53
replace countryname2 = "Belarus" if ccode2 == 370
replace countryname2 = "Belgium" if ccode2 == 211
replace countryname2 = "Belize" if ccode2 == 80
replace countryname2 = "Benin" if ccode2 == 434
replace countryname2 = "Bhutan" if ccode2 == 760
replace countryname2 = "Bolivia" if ccode2 == 145
replace countryname2 = "Bosnia & Herzegovina" if ccode2 == 346
replace countryname2 = "Botswana" if ccode2 == 571
replace countryname2 = "Brazil" if ccode2 == 140
replace countryname2 = "Brunei" if ccode2 == 835
replace countryname2 = "Bulgaria" if ccode2 == 355
replace countryname2 = "Burkina Faso" if ccode2 == 439
replace countryname2 = "Burundi" if ccode2 == 516
replace countryname2 = "Cape Verde" if ccode2 == 402
replace countryname2 = "Cambodia" if ccode2 == 811
replace countryname2 = "Cameroon" if ccode2 == 471
replace countryname2 = "Canada" if ccode2 == 20
replace countryname2 = "Central African Republic" if ccode2 == 482
replace countryname2 = "Chad" if ccode2 == 483
replace countryname2 = "Chile" if ccode2 == 155
replace countryname2 = "China" if ccode2 == 710
replace countryname2 = "Colombia" if ccode2 == 100
replace countryname2 = "Comoros" if ccode2 == 581
replace countryname2 = "Congo - Brazzaville" if ccode2 == 484
replace countryname2 = "Costa Rica" if ccode2 == 94
replace countryname2 = "CÃ´te dâIvoire" if ccode2 == 437
replace countryname2 = "Croatia" if ccode2 == 344
replace countryname2 = "Cuba" if ccode2 == 40
replace countryname2 = "Cyprus" if ccode2 == 352
replace countryname2 = "Czechia" if ccode2 == 316
replace countryname2 = "North Korea" if ccode2 == 731
replace countryname2 = "Congo - Kinshasa" if ccode2 == 490
replace countryname2 = "Denmark" if ccode2 == 390
replace countryname2 = "Djibouti" if ccode2 == 522
replace countryname2 = "Dominica" if ccode2 == 54
replace countryname2 = "Dominican Republic" if ccode2 == 42
replace countryname2 = "Ecuador" if ccode2 == 130
replace countryname2 = "Egypt" if ccode2 == 651
replace countryname2 = "El Salvador" if ccode2 == 92
replace countryname2 = "Equatorial Guinea" if ccode2 == 411
replace countryname2 = "Eritrea" if ccode2 == 531
replace countryname2 = "Estonia" if ccode2 == 366
replace countryname2 = "Eswatini" if ccode2 == 572
replace countryname2 = "Ethiopia" if ccode2 == 530
replace countryname2 = "Fiji" if ccode2 == 950
replace countryname2 = "Finland" if ccode2 == 375
replace countryname2 = "France" if ccode2 == 220
replace countryname2 = "Gabon" if ccode2 == 481
replace countryname2 = "Gambia" if ccode2 == 420
replace countryname2 = "Georgia" if ccode2 == 372
replace countryname2 = "Germany" if ccode2 == 255
replace countryname2 = "Ghana" if ccode2 == 452
replace countryname2 = "Greece" if ccode2 == 350
replace countryname2 = "Grenada" if ccode2 == 55
replace countryname2 = "Guatemala" if ccode2 == 90
replace countryname2 = "Guinea" if ccode2 == 438
replace countryname2 = "Guinea-Bissau" if ccode2 == 404
replace countryname2 = "Guyana" if ccode2 == 110
replace countryname2 = "Haiti" if ccode2 == 41
replace countryname2 = "Honduras" if ccode2 == 91
replace countryname2 = "Hungary" if ccode2 == 310
replace countryname2 = "Iceland" if ccode2 == 395
replace countryname2 = "India" if ccode2 == 750
replace countryname2 = "Indonesia" if ccode2 == 850
replace countryname2 = "Iran" if ccode2 == 630
replace countryname2 = "Iraq" if ccode2 == 645
replace countryname2 = "Ireland" if ccode2 == 205
replace countryname2 = "Israel" if ccode2 == 666
replace countryname2 = "Italy" if ccode2 == 325
replace countryname2 = "Jamaica" if ccode2 == 51
replace countryname2 = "Japan" if ccode2 == 740
replace countryname2 = "Jordan" if ccode2 == 663
replace countryname2 = "Kazakhstan" if ccode2 == 705
replace countryname2 = "Kenya" if ccode2 == 501
replace countryname2 = "Kiribati" if ccode2 == 946
replace countryname2 = "Kuwait" if ccode2 == 690
replace countryname2 = "Kyrgyzstan" if ccode2 == 703
replace countryname2 = "Laos" if ccode2 == 812
replace countryname2 = "Latvia" if ccode2 == 367
replace countryname2 = "Lebanon" if ccode2 == 660
replace countryname2 = "Lesotho" if ccode2 == 570
replace countryname2 = "Liberia" if ccode2 == 450
replace countryname2 = "Libya" if ccode2 == 620
replace countryname2 = "Liechtenstein" if ccode2 == 223
replace countryname2 = "Lithuania" if ccode2 == 368
replace countryname2 = "Luxembourg" if ccode2 == 212
replace countryname2 = "Madagascar" if ccode2 == 580
replace countryname2 = "Malawi" if ccode2 == 553
replace countryname2 = "Malaysia" if ccode2 == 820
replace countryname2 = "Maldives" if ccode2 == 781
replace countryname2 = "Mali" if ccode2 == 432
replace countryname2 = "Malta" if ccode2 == 338
replace countryname2 = "Marshall Islands" if ccode2 == 983
replace countryname2 = "Mauritania" if ccode2 == 435
replace countryname2 = "Mauritius" if ccode2 == 590
replace countryname2 = "Mexico" if ccode2 == 70
replace countryname2 = "Micronesia (Federated States of)" if ccode2 == 987
replace countryname2 = "Monaco" if ccode2 == 221
replace countryname2 = "Mongolia" if ccode2 == 712
replace countryname2 = "Montenegro" if ccode2 == 341
replace countryname2 = "Morocco" if ccode2 == 600
replace countryname2 = "Mozambique" if ccode2 == 541
replace countryname2 = "Myanmar (Burma)" if ccode2 == 775
replace countryname2 = "Namibia" if ccode2 == 565
replace countryname2 = "Nauru" if ccode2 == 970
replace countryname2 = "Nepal" if ccode2 == 790
replace countryname2 = "Netherlands" if ccode2 == 210
replace countryname2 = "New Zealand" if ccode2 == 920
replace countryname2 = "Nicaragua" if ccode2 == 93
replace countryname2 = "Niger" if ccode2 == 436
replace countryname2 = "Nigeria" if ccode2 == 475
replace countryname2 = "North Macedonia" if ccode2 == 343
replace countryname2 = "Norway" if ccode2 == 385
replace countryname2 = "Oman" if ccode2 == 698
replace countryname2 = "Pakistan" if ccode2 == 770
replace countryname2 = "Palau" if ccode2 == 986
replace countryname2 = "Panama" if ccode2 == 95
replace countryname2 = "Papua New Guinea" if ccode2 == 910
replace countryname2 = "Paraguay" if ccode2 == 150
replace countryname2 = "Peru" if ccode2 == 135
replace countryname2 = "Philippines" if ccode2 == 840
replace countryname2 = "Poland" if ccode2 == 290
replace countryname2 = "Portugal" if ccode2 == 235
replace countryname2 = "Qatar" if ccode2 == 694
replace countryname2 = "South Korea" if ccode2 == 732
replace countryname2 = "Moldova" if ccode2 == 359
replace countryname2 = "Romania" if ccode2 == 360
replace countryname2 = "Russia" if ccode2 == 365
replace countryname2 = "Rwanda" if ccode2 == 517
replace countryname2 = "St. Kitts & Nevis" if ccode2 == 60
replace countryname2 = "St. Lucia" if ccode2 == 56
replace countryname2 = "St. Vincent & Grenadines" if ccode2 == 57
replace countryname2 = "Samoa" if ccode2 == 990
replace countryname2 = "San Marino" if ccode2 == 331
replace countryname2 = "SÃ£o TomÃ© & PrÃ­ncipe" if ccode2 == 403
replace countryname2 = "Saudi Arabia" if ccode2 == 670
replace countryname2 = "Senegal" if ccode2 == 433
replace countryname2 = "Yugoslavia" if ccode2 == 345
replace countryname2 = "Seychelles" if ccode2 == 591
replace countryname2 = "Sierra Leone" if ccode2 == 451
replace countryname2 = "Singapore" if ccode2 == 830
replace countryname2 = "Slovakia" if ccode2 == 317
replace countryname2 = "Slovenia" if ccode2 == 349
replace countryname2 = "Solomon Islands" if ccode2 == 940
replace countryname2 = "Somalia" if ccode2 == 520
replace countryname2 = "South Africa" if ccode2 == 560
replace countryname2 = "South Sudan" if ccode2 == 626
replace countryname2 = "Spain" if ccode2 == 230
replace countryname2 = "Sri Lanka" if ccode2 == 780
replace countryname2 = "Sudan" if ccode2 == 625
replace countryname2 = "Suriname" if ccode2 == 115
replace countryname2 = "Sweden" if ccode2 == 380
replace countryname2 = "Switzerland" if ccode2 == 225
replace countryname2 = "Syria" if ccode2 == 652
replace countryname2 = "Tajikistan" if ccode2 == 702
replace countryname2 = "Thailand" if ccode2 == 800
replace countryname2 = "Timor-Leste" if ccode2 == 860
replace countryname2 = "Togo" if ccode2 == 461
replace countryname2 = "Tonga" if ccode2 == 955
replace countryname2 = "Trinidad & Tobago" if ccode2 == 52
replace countryname2 = "Tunisia" if ccode2 == 616
replace countryname2 = "Turkey" if ccode2 == 640
replace countryname2 = "Turkmenistan" if ccode2 == 701
replace countryname2 = "Tuvalu" if ccode2 == 947
replace countryname2 = "Uganda" if ccode2 == 500
replace countryname2 = "Ukraine" if ccode2 == 369
replace countryname2 = "United Arab Emirates" if ccode2 == 696
replace countryname2 = "United Kingdom" if ccode2 == 200
replace countryname2 = "Tanzania" if ccode2 == 510
replace countryname2 = "United States" if ccode2 == 2
replace countryname2 = "Uruguay" if ccode2 == 165
replace countryname2 = "Uzbekistan" if ccode2 == 704
replace countryname2 = "Vanuatu" if ccode2 == 935
replace countryname2 = "Venezuela" if ccode2 == 101
replace countryname2 = "Vietnam" if ccode2 == 816
replace countryname2 = "Yemen" if ccode2 == 679
replace countryname2 = "Zambia" if ccode2 == 551
replace countryname2 = "Zimbabwe" if ccode2 == 552

}

order country1 countryname1, after(ccode1)
order country2 countryname2, after(ccode2)

	* to check if there is no missing code or country
	count if country1 == ""
	count if country2 == ""
	count if countryname1 == ""
	count if countryname2 == ""
		* all zeros, good
	
	* we can get rid off the number coding
	drop ccode1 ccode2
	order year, before(agree)
		
	* now we need to keep only the donors on country1 side (and probably all countries on the recipients' (country2) side)

	keep if countryname1 == "Australia" | countryname1 == "Austria" | countryname1 == "Belgium" | countryname1 == "Canada" | countryname1 == "Denmark" | countryname1 == "Finland" | ///
			countryname1 == "France" | countryname1 == "Germany" | countryname1 == "Greece" | countryname1 == "Ireland" | countryname1 == "Italy" | countryname1 == "Japan" | countryname1 == "South Korea" | ///
			countryname1 == "Luxembourg" | countryname1 == "Netherlands" | countryname1 == "New Zealand" | countryname1 == "Norway" | countryname1 == "Portugal" | countryname1 == "Spain" | ///
			countryname1 == "Sweden" | countryname1 == "Switzerland" | countryname1 == "United Kingdom" | countryname1 == "United States"

save "data/UN_votes/un-agree_names-filtered_2008-2019.dta", replace

*** MERGING UN data with ODA data
clear
use "data/UN_votes/un-agree_names-filtered_2008-2019.dta"
ren country1 iso3c_d
ren country2 iso3c_r
save "data/UN_votes/un-agree_names-filtered-v2_2008-2019.dta", replace
clear

	* one by one for all six datasets
	use "data/pillar_model/HMT_FSI.dta"
	merge 1:1 iso3c_d iso3c_r year using "data/UN_votes/un-agree_names-filtered-v2_2008-2019.dta"
	sum population if _merge == 2 /*to check if we'd miss something when all non-matched observations are deleted => NO, we can delete them */
	drop if _merge == 2
	drop _merge 
	save "data/merged/HMT_FSI_merged.dta", replace
	clear
	
	use "data/pillar_model/DEV_FSI.dta"
	merge 1:1 iso3c_d iso3c_r year using "data/UN_votes/un-agree_names-filtered-v2_2008-2019.dta"
	sum population if _merge == 2 /*to check if we'd miss something when all non-matched observations are deleted => NO, we can delete them */
	drop if _merge == 2
	drop _merge 
	save "data/merged/DEV_FSI_merged.dta", replace
	clear
	
	use "data/pillar_model/PEC_FSI.dta"
	merge 1:1 iso3c_d iso3c_r year using "data/UN_votes/un-agree_names-filtered-v2_2008-2019.dta"
	sum population if _merge == 2 /*to check if we'd miss something when all non-matched observations are deleted => NO, we can delete them */
	drop if _merge == 2
	drop _merge 
	save "data/merged/PEC_FSI_merged.dta", replace
	clear

	use "data/pillar_model/HMT_SoF.dta"
	merge 1:1 iso3c_d iso3c_r year using "data/UN_votes/un-agree_names-filtered-v2_2008-2019.dta"
	sum population if _merge == 2 /*to check if we'd miss something when all non-matched observations are deleted => NO, we can delete them */
	drop if _merge == 2
	drop _merge 
	save "data/merged/HMT_SoF_merged.dta", replace
	clear
	
	use "data/pillar_model/DEV_SoF.dta"
	merge 1:1 iso3c_d iso3c_r year using "data/UN_votes/un-agree_names-filtered-v2_2008-2019.dta"
	sum population if _merge == 2 /*to check if we'd miss something when all non-matched observations are deleted => NO, we can delete them */
	drop if _merge == 2
	drop _merge 
	save "data/merged/DEV_SoF_merged.dta", replace
	clear
	
	use "data/pillar_model/PEC_SoF.dta"
	merge 1:1 iso3c_d iso3c_r year using "data/UN_votes/un-agree_names-filtered-v2_2008-2019.dta"
	sum population if _merge == 2 /*to check if we'd miss something when all non-matched observations are deleted => NO, we can delete them */
	drop if _merge == 2
	drop _merge 
	save "data/merged/PEC_SoF_merged.dta", replace
	clear

**** REDUCED FSI
forvalues i=2008(1)2019 {
import excel using "source_data/FSI_reduced/fsi-`i'.xlsx", firstrow
keep Country FSIexclE1P3X1
ren Country country
ren FSIexclE1P3X1 fsi_red
gen year = `i'
save "data/FSI_reduced/fsi-`i'.dta", replace
clear
}

use "data/FSI_reduced/fsi-2008.dta"
forvalues i=2009(1)2019 {
append using "data/FSI_reduced/fsi-`i'.dta"
}

replace country = "Serbia" if country == "Serbia  "
replace country = "Uruguay" if country == "Uruguay "
replace country = "Swaziland" if country == "Eswatini"
replace country = "Czech Republic" if country == "Czechia"

{
gen spicountrycode = ""
replace spicountrycode = "ABW" if country == "Aruba"
replace spicountrycode = "AFG" if country == "Afghanistan"
replace spicountrycode = "AGO" if country == "Angola"
replace spicountrycode = "AIA" if country == "Anguilla"
replace spicountrycode = "ALB" if country == "Albania"
replace spicountrycode = "AND" if country == "Andorra"
replace spicountrycode = "ANT" if country == "Neth. Antilles"
replace spicountrycode = "ANT" if country == "Netherlands Antilles"
replace spicountrycode = "ARE" if country == "United Arab Emirates"
replace spicountrycode = "ARE" if country == "UAE"
replace spicountrycode = "ARG" if country == "Argentina"
replace spicountrycode = "ARM" if country == "Armenia"
replace spicountrycode = "ASM" if country == "American Samoa"
replace spicountrycode = "ATG" if country == "Antigua & Barbuda"
replace spicountrycode = "ATG" if country == "Antigua and Barbuda"
replace spicountrycode = "AUS" if country == "Australia"
replace spicountrycode = "AUT" if country == "Austria"
replace spicountrycode = "AZE" if country == "Azerbaijan"
replace spicountrycode = "BDI" if country == "Burundi"
replace spicountrycode = "BEL" if country == "Belgium#"
replace spicountrycode = "BEL" if country == "Belgium"
replace spicountrycode = "BEN" if country == "Benin"
replace spicountrycode = "BES" if country == "Bonaire Sint Eustatius and Saba"
replace spicountrycode = "BES" if country == "Bonaire, Saint Eustatius and Saba"
replace spicountrycode = "BFA" if country == "Burkina Faso"
replace spicountrycode = "BGD" if country == "Bangladesh"
replace spicountrycode = "BGR" if country == "Bulgaria"
replace spicountrycode = "BHR" if country == "Bahrain"
replace spicountrycode = "BHS" if country == "Bahamas"
replace spicountrycode = "BHS" if country == "Bahamas, The"
replace spicountrycode = "BHS" if country == "The Bahamas"
replace spicountrycode = "BIH" if country == "Bosnia"
replace spicountrycode = "BIH" if country == "Bosnia & Herzegovina"
replace spicountrycode = "BIH" if country == "Bosnia and Herzegovina"
replace spicountrycode = "BIH" if country == "Bosnia-Herzegovina"
replace spicountrycode = "BIH" if country == "BosniaHerzegovina"
replace spicountrycode = "BIH" if country == "Bosnia and Hercegovina"
replace spicountrycode = "BLM" if country == "Saint Barthélemy"
replace spicountrycode = "BLM" if country == "Saint-Barthelemy"
replace spicountrycode = "BLM" if country == "Saint-Barthélemy"
replace spicountrycode = "BLM" if country == "St. Barthélemy"
replace spicountrycode = "BLR" if country == "Belarus"
replace spicountrycode = "BLZ" if country == "Belize"
replace spicountrycode = "BMU" if country == "Bermuda"
replace spicountrycode = "BOL" if country == "Bolivia"
replace spicountrycode = "BOL" if country == "Bolivia "
replace spicountrycode = "BOL" if country == "Bolivia (Plurinational State of)"
replace spicountrycode = "BOL" if country == "Bolivia, P. S."
replace spicountrycode = "BOL" if country == "Bolivia, Plurinational State of"
replace spicountrycode = "BRA" if country == "Brazil"
replace spicountrycode = "BRB" if country == "Barbados"
replace spicountrycode = "BRN" if country == "Brunei"
replace spicountrycode = "BRN" if country == "Brunei "
replace spicountrycode = "BRN" if country == "Brunei Darussalam"
replace spicountrycode = "BTN" if country == "Bhutan"
replace spicountrycode = "BUR" if country == "Burma"
replace spicountrycode = "BWA" if country == "Botswana"
replace spicountrycode = "CAF" if country == "Central African"
replace spicountrycode = "CAF" if country == "Central African Rep."
replace spicountrycode = "CAF" if country == "Central African Republic"
replace spicountrycode = "CAN" if country == "Canada"
replace spicountrycode = "CCK" if country == "Cocos Keeling Islands"
replace spicountrycode = "CHE" if country == "Switzerland"
replace spicountrycode = "CHI" if country == "Channel Islands"
replace spicountrycode = "CHL" if country == "Chile"
replace spicountrycode = "CHN" if country == "China"
replace spicountrycode = "CHN" if country == "China (People's Republic of)"
replace spicountrycode = "CHN" if country == "China, mainland"
replace spicountrycode = "CIV" if country == "C√¥te d'Ivoire"
replace spicountrycode = "CIV" if country == "C√É¬¥te d'Ivoire"
replace spicountrycode = "CIV" if country == "CÃ´te d'Ivoire"
replace spicountrycode = "CIV" if country == "Cote d Ivoire"
replace spicountrycode = "CIV" if country == "Cote d' Ivoire"
replace spicountrycode = "CIV" if country == "Côte d''Ivoire"
replace spicountrycode = "CIV" if country == "Cote d'Ivoire"
replace spicountrycode = "CIV" if country == "Côte d'Ivoire"
replace spicountrycode = "CIV" if country == "Cote d’Ivoire"
replace spicountrycode = "CIV" if country == "Côte d’Ivoire"
replace spicountrycode = "CIV" if country == "Côte d´Ivoire"
replace spicountrycode = "CIV" if country == "Cote dIvoire"
replace spicountrycode = "CIV" if country == "Côte dIvoire"
replace spicountrycode = "CIV" if country == "C��te d'Ivoire"
replace spicountrycode = "CIV" if country == "Ivory Coast"
replace spicountrycode = "CMR" if country == "Cameroon"
replace spicountrycode = "COD" if country == "Congo (D. R.)"
replace spicountrycode = "COD" if country == "Congo (Dem. Rep.)"
replace spicountrycode = "COD" if country == "Congo (Democratic Republic of the)"
replace spicountrycode = "COD" if country == "Congo (Kinshasa)"
replace spicountrycode = "COD" if country == "Congo Democratic Republic"
replace spicountrycode = "COD" if country == "Congo, Democratic Republic"
replace spicountrycode = "COD" if country == "Congo DR"
replace spicountrycode = "COD" if country == "Congo-Kinshasa"
replace spicountrycode = "COD" if country == "Congo, Dem. Rep."
replace spicountrycode = "COD" if country == "Congo, Democratic Rep."
replace spicountrycode = "COD" if country == "Congo, Democratic Republic of"
replace spicountrycode = "COD" if country == "Congo, Democratic Republic of the"
replace spicountrycode = "COD" if country == "Congo, Democratic Republic of the Congo"
replace spicountrycode = "COD" if country == "Congo, The Democratic Republic of the"
replace spicountrycode = "COD" if country == "D. R. Congo"
replace spicountrycode = "COD" if country == "Dem. Rep. Congo"
replace spicountrycode = "COD" if country == "Dem. Rep. of the Congo"
replace spicountrycode = "COD" if country == "Democratic Rep. of the Congo"
replace spicountrycode = "COD" if country == "Democratic Republic of Congo"
replace spicountrycode = "COD" if country == "Democratic Republic of the Congo"
replace spicountrycode = "COD" if country == "Democratic Republic of the Congo  (Kinshasa)"
replace spicountrycode = "COD" if country == "DRC"
replace spicountrycode = "COD" if country == "The Democratic Republic of Congo"
replace spicountrycode = "COD" if country == "DR Congo"
replace spicountrycode = "COD" if country == "Congo_Democratic Republic of"
replace spicountrycode = "COG" if country == "Congo"
replace spicountrycode = "COG" if country == "Congo (Brazzaville)"
replace spicountrycode = "COG" if country == "Congo (Rep.)"
replace spicountrycode = "COG" if country == "Congo (Republic)"
replace spicountrycode = "COG" if country == "Congo Brazzaville"
replace spicountrycode = "COG" if country == "Congo Republic"
replace spicountrycode = "COG" if country == "Congo-Brazzaville"
replace spicountrycode = "COG" if country == "Congo-Brazzaville (Republic of the Congo)"
replace spicountrycode = "COG" if country == "Congo, Rep."
replace spicountrycode = "COG" if country == "Congo, Republic of"
replace spicountrycode = "COG" if country == "Congo_Republic of the"
replace spicountrycode = "COG" if country == "Republic of Congo"
replace spicountrycode = "COG" if country == "Republic of the Congo"
replace spicountrycode = "COG" if country == "Republic of the Congo (Brazzaville)"
replace spicountrycode = "COG" if country == "Congo (Rep. of the)"
replace spicountrycode = "COK" if country == "Cook Islands"
replace spicountrycode = "COL" if country == "Colombia"
replace spicountrycode = "COM" if country == "Comores"
replace spicountrycode = "COM" if country == "Comoros"
replace spicountrycode = "CPV" if country == "Cabo Verde"
replace spicountrycode = "CPV" if country == "Cape Verde"
replace spicountrycode = "CRI" if country == "Costa Rica"
replace spicountrycode = "CSK" if country == "Czechoslovakia"
replace spicountrycode = "CUB" if country == "Cuba"
replace spicountrycode = "CUW" if country == "Curacao"
replace spicountrycode = "CUW" if country == "Curaçao"
replace spicountrycode = "CYM" if country == "Cayman Islands"
replace spicountrycode = "CYP" if country == "Cyprus"
replace spicountrycode = "CZE" if country == "Czech Republic"
replace spicountrycode = "CZE" if country == "Czechia"
replace spicountrycode = "DEU" if country == "Germany"
replace spicountrycode = "DJI" if country == "Djibouti"
replace spicountrycode = "DMA" if country == "Dominica"
replace spicountrycode = "DNK" if country == "Denmark"
replace spicountrycode = "DOM" if country == "Dominican Rep."
replace spicountrycode = "DOM" if country == "Dominican Republic"
replace spicountrycode = "DZA" if country == "Algeria"
replace spicountrycode = "ECU" if country == "Ecuador"
replace spicountrycode = "EGY" if country == "Egypt"
replace spicountrycode = "EGY" if country == "Egypt, Arab Rep."
replace spicountrycode = "ENW" if country == "England and Wales"
replace spicountrycode = "ERI" if country == "Eritrea"
replace spicountrycode = "ESH" if country == "Western Sahara"
replace spicountrycode = "ESP" if country == "Spain"
replace spicountrycode = "EST" if country == "Estonia"
replace spicountrycode = "ETH" if country == "Ethiopia"
replace spicountrycode = "FIN" if country == "Finland"
replace spicountrycode = "FJI" if country == "Fiji"
replace spicountrycode = "FLK" if country == "Falkland (Malvinas) Is."
replace spicountrycode = "FLK" if country == "Falkland Islands"
replace spicountrycode = "FLK" if country == "Falkland Islands (Malvinas)"
replace spicountrycode = "FRA" if country == "France"
replace spicountrycode = "FRO" if country == "Faeroe Islands"
replace spicountrycode = "FRO" if country == "Faroe Islands"
replace spicountrycode = "FSM" if country == "Federated States of Micronesia"
replace spicountrycode = "FSM" if country == "Micronesia"
replace spicountrycode = "FSM" if country == "Micronesia (Fed. States of)"
replace spicountrycode = "FSM" if country == "Micronesia (Federated States of)"
replace spicountrycode = "FSM" if country == "Micronesia, Fed. Sts."
replace spicountrycode = "GAB" if country == "Gabon"
replace spicountrycode = "GBR" if country == "Great Britain"
replace spicountrycode = "GBR" if country == "United Kingdom"
replace spicountrycode = "GBR" if country == "United Kingdom (England and Wales)"
replace spicountrycode = "GBR" if country == "United Kingdom of Great Britain and Northern Ireland"
replace spicountrycode = "GBR" if country == "UK"
replace spicountrycode = "GEO" if country == "Georgia"
replace spicountrycode = "GEO" if country == "Georgia (Country)"
replace spicountrycode = "GGY" if country == "Guernsey"
replace spicountrycode = "GHA" if country == "Ghana"
replace spicountrycode = "GIB" if country == "Gibraltar"
replace spicountrycode = "GIN" if country == "Guinea"
replace spicountrycode = "GLP" if country == "Guadeloupe"
replace spicountrycode = "GMB" if country == "Gambia"
replace spicountrycode = "GMB" if country == "Gambia The"
replace spicountrycode = "GMB" if country == "Gambia, The"
replace spicountrycode = "GMB" if country == "The Gambia"
replace spicountrycode = "GNB" if country == "Guinea Bissau"
replace spicountrycode = "GNB" if country == "Guinea-Bissau"
replace spicountrycode = "GNQ" if country == "Equatorial Guinea"
replace spicountrycode = "GRC" if country == "Greece"
replace spicountrycode = "GRD" if country == "Grenada"
replace spicountrycode = "GRL" if country == "Greenland"
replace spicountrycode = "GTM" if country == "Guatemala"
replace spicountrycode = "GUF" if country == "French Guiana"
replace spicountrycode = "GUM" if country == "Guam"
replace spicountrycode = "GUY" if country == "Guyana"
replace spicountrycode = "HKG" if country == "China, Hong Kong SAR"
replace spicountrycode = "HKG" if country == "China, Hong Kong Special Administrative Region"
replace spicountrycode = "HKG" if country == "Hong Kong"
replace spicountrycode = "HKG" if country == "Hong Kong SAR"
replace spicountrycode = "HKG" if country == "Hong Kong SAR, China"
replace spicountrycode = "HKG" if country == "Hong Kong Special Administrative Region of China"
replace spicountrycode = "HKG" if country == "Hong Kong, China"
replace spicountrycode = "HKG" if country == "Hong Kong, China (SAR)"
replace spicountrycode = "HKG" if country == "Hong Kong, SAR China"
replace spicountrycode = "HKG" if country == "Hong Kong, Special Administrative Region of China"
replace spicountrycode = "HKG" if country == "Hong Kong S.A.R. of China"
replace spicountrycode = "HND" if country == "Honduras"
replace spicountrycode = "HRV" if country == "Croatia"
replace spicountrycode = "HTI" if country == "Haiti"
replace spicountrycode = "HTI" if country == "Haïti"
replace spicountrycode = "HUN" if country == "Hungary"
replace spicountrycode = "IDN" if country == "Indonesia"
replace spicountrycode = "IMN" if country == "Isle of Man"
replace spicountrycode = "IND" if country == "India"
replace spicountrycode = "IRL" if country == "Ireland"
replace spicountrycode = "IRN" if country == "Iran"
replace spicountrycode = "IRN" if country == "Iran (I.R.)"
replace spicountrycode = "IRN" if country == "Iran (Islamic Republic of)"
replace spicountrycode = "IRN" if country == "Iran, Islamic Rep"
replace spicountrycode = "IRN" if country == "Iran, Islamic Rep."
replace spicountrycode = "IRN" if country == "Iran, Islamic Republic of"
replace spicountrycode = "IRN" if country == "Islamic Republic of Iran"
replace spicountrycode = "IRQ" if country == "Iraq"
replace spicountrycode = "ISL" if country == "Iceland"
replace spicountrycode = "ISR" if country == "Israel"
replace spicountrycode = "ISR" if country == "Israel (and West Bank)"
replace spicountrycode = "ISR" if country == "Israel and West Bank"
replace spicountrycode = "ITA" if country == "Italy"
replace spicountrycode = "JAM" if country == "Jamaica"
replace spicountrycode = "JEY" if country == "Jersey"
replace spicountrycode = "JOR" if country == "Jordan"
replace spicountrycode = "JPN" if country == "Japan"
replace spicountrycode = "KAZ" if country == "Kazakhstan"
replace spicountrycode = "KEN" if country == "Kenya"
replace spicountrycode = "KGZ" if country == "Kyrgyz Republic"
replace spicountrycode = "KGZ" if country == "Kyrgyzstan"
replace spicountrycode = "KHM" if country == "Cambodia"
replace spicountrycode = "KIR" if country == "Kiribati"
replace spicountrycode = "KNA" if country == "Saint Kitts & Nevis"
replace spicountrycode = "KNA" if country == "Saint Kitts and Nevis"
replace spicountrycode = "KNA" if country == "St. Kitts and Nevis"
replace spicountrycode = "KOR" if country == "Korea"
replace spicountrycode = "KOR" if country == "Korea (Rep.)"
replace spicountrycode = "KOR" if country == "Korea (Republic of)"
replace spicountrycode = "KOR" if country == "Korea (Rep. of)"
replace spicountrycode = "KOR" if country == "Korea (South)"
replace spicountrycode = "KOR" if country == "Korea Rep"
replace spicountrycode = "KOR" if country == "Korea, Rep"
replace spicountrycode = "KOR" if country == "Korea, Rep."
replace spicountrycode = "KOR" if country == "Korea, Rep. (South)"
replace spicountrycode = "KOR" if country == "Korea, Republic of"
replace spicountrycode = "KOR" if country == "Korea, South"
replace spicountrycode = "KOR" if country == "Republic of Korea"
replace spicountrycode = "KOR" if country == "South Korea"
replace spicountrycode = "KOR" if country == "Korea_South"
replace spicountrycode = "KSV" if country == "Kosovo"
replace spicountrycode = "KSV" if country == "Kosovo (in compliance with UN Security Council Resolution 1244/99)"
replace spicountrycode = "KWT" if country == "Kuwait"
replace spicountrycode = "LAO" if country == "Lao"
replace spicountrycode = "LAO" if country == "Lao P.D.R."
replace spicountrycode = "LAO" if country == "Lao PDR"
replace spicountrycode = "LAO" if country == "Lao People's Democratic Republic"
replace spicountrycode = "LAO" if country == "Laos"
replace spicountrycode = "LBN" if country == "Lebanon"
replace spicountrycode = "LBR" if country == "Liberia"
replace spicountrycode = "LBY" if country == "Libya"
replace spicountrycode = "LBY" if country == "Libyan Arab Jamahiriya"
replace spicountrycode = "LCA" if country == "Saint Lucia"
replace spicountrycode = "LCA" if country == "Saint. Lucia"
replace spicountrycode = "LCA" if country == "St. Lucia"
replace spicountrycode = "LIE" if country == "Liechtenstein"
replace spicountrycode = "LKA" if country == "Sri Lanka"
replace spicountrycode = "LSO" if country == "Lesotho"
replace spicountrycode = "LTU" if country == "Lithuania"
replace spicountrycode = "LUX" if country == "Luxembourg"
replace spicountrycode = "LVA" if country == "Latvia"
replace spicountrycode = "MAC" if country == "China, Macao SAR"
replace spicountrycode = "MAC" if country == "China, Macao Special Administrative Region"
replace spicountrycode = "MAC" if country == "Macao"
replace spicountrycode = "MAC" if country == "Macao SAR, China"
replace spicountrycode = "MAC" if country == "Macao, China"
replace spicountrycode = "MAC" if country == "Macau"
replace spicountrycode = "MAC" if country == "Macau, China"
replace spicountrycode = "MAC" if country == "Macao, Special Administrative Region of China"
replace spicountrycode = "MAF" if country == "Saint Martin"
replace spicountrycode = "MAF" if country == "Saint Martin (French Part)"
replace spicountrycode = "MAF" if country == "Saint-Martin"
replace spicountrycode = "MAF" if country == "Saint-Martin (French part)"
replace spicountrycode = "MAF" if country == "St. Martin (French part)"
replace spicountrycode = "MAF" if country == "St. Martin"
replace spicountrycode = "MAR" if country == "Morocco"
replace spicountrycode = "MCO" if country == "Monaco"
replace spicountrycode = "MDA" if country == "Moldova"
replace spicountrycode = "MDA" if country == "Moldova (Republic of)"
replace spicountrycode = "MDA" if country == "Moldova, Republic of"
replace spicountrycode = "MDA" if country == "Republic of Moldova"
replace spicountrycode = "MDG" if country == "Madagascar"
replace spicountrycode = "MDV" if country == "Maldives"
replace spicountrycode = "MEX" if country == "Mexico"
replace spicountrycode = "MHL" if country == "Marshall Islands"
replace spicountrycode = "MKD" if country == "Former Yugoslav Republic of Macedonia"
replace spicountrycode = "MKD" if country == "Macedonia"
replace spicountrycode = "MKD" if country == "Macedonia (FYR)"
replace spicountrycode = "MKD" if country == "Macedonia (FYROM)"
replace spicountrycode = "MKD" if country == "Macedonia TFYR"
replace spicountrycode = "MKD" if country == "Macedonia, FYR"
replace spicountrycode = "MKD" if country == "Macedonia, The former Yugoslav Republic of"
replace spicountrycode = "MKD" if country == "Republic of Macedonia"
replace spicountrycode = "MKD" if country == "TFYR Macedonia"
replace spicountrycode = "MKD" if country == "The former Yugoslav Rep. of Macedonia"
replace spicountrycode = "MKD" if country == "The former Yugoslav Republic of Macedonia"
replace spicountrycode = "MKD" if country == "The FYR of Macedonia"
replace spicountrycode = "MKD" if country == "Republic of North Macedonia"
replace spicountrycode = "MKD" if country == "North Macedonia"
replace spicountrycode = "MLI" if country == "Mali"
replace spicountrycode = "MLT" if country == "Malta"
replace spicountrycode = "MMR" if country == "Burma_Myanmar"
replace spicountrycode = "MMR" if country == "Burma (Myanmar)"
replace spicountrycode = "MMR" if country == "Burma/Myanmar"
replace spicountrycode = "MMR" if country == "Myammar"
replace spicountrycode = "MMR" if country == "Myanmar"
replace spicountrycode = "MNE" if country == "Montenegro"
replace spicountrycode = "MNG" if country == "Mongolia"
replace spicountrycode = "MNP" if country == "Northern Mariana Islands"
replace spicountrycode = "MNP" if country == "Northern Marianas"
replace spicountrycode = "MOZ" if country == "Mozambique"
replace spicountrycode = "MRT" if country == "Mauritania"
replace spicountrycode = "MSR" if country == "Montserrat"
replace spicountrycode = "MTQ" if country == "Martinique"
replace spicountrycode = "MUS" if country == "Mauritius"
replace spicountrycode = "MWI" if country == "Malawi"
replace spicountrycode = "MYS" if country == "Malaysia"
replace spicountrycode = "MYT" if country == "Mayotte"
replace spicountrycode = "NAM" if country == "Namibia"
replace spicountrycode = "NCL" if country == "New Caledonia"
replace spicountrycode = "NCY" if country == "Cyprus North"
replace spicountrycode = "NCY" if country == "North Cyprus"
replace spicountrycode = "NCY" if country == "Northern Cyprus"
replace spicountrycode = "NER" if country == "Niger"
replace spicountrycode = "NFK" if country == "Norfolk Island"
replace spicountrycode = "NFK" if country == "Norfolk Islands"
replace spicountrycode = "NGA" if country == "Nigeria"
replace spicountrycode = "NIC" if country == "Nicaragua"
replace spicountrycode = "NIR" if country == "Northern Ireland"
replace spicountrycode = "NIU" if country == "Niue"
replace spicountrycode = "NLD" if country == "Netherlands"
replace spicountrycode = "NOR" if country == "Norway"
replace spicountrycode = "NPL" if country == "Nepal"
replace spicountrycode = "NPL" if country == "Nepal (Republic of)"
replace spicountrycode = "NRU" if country == "Nauru"
replace spicountrycode = "NZL" if country == "New Zealand#"
replace spicountrycode = "NZL" if country == "New Zealand"
replace spicountrycode = "OMN" if country == "Oman"
replace spicountrycode = "PAK" if country == "Pakistan"
replace spicountrycode = "PAN" if country == "Panama"
replace spicountrycode = "PCN" if country == "Pitcairn"
replace spicountrycode = "PER" if country == "Peru"
replace spicountrycode = "PHL" if country == "Philippines"
replace spicountrycode = "PLW" if country == "Palau"
replace spicountrycode = "PNG" if country == "Papua New Guinea"
replace spicountrycode = "POL" if country == "Poland#"
replace spicountrycode = "POL" if country == "Poland"
replace spicountrycode = "PRI" if country == "Puerto Rico"
replace spicountrycode = "PRK" if country == "D.P.R. Korea"
replace spicountrycode = "PRK" if country == "Dem. People's Republic of Korea"
replace spicountrycode = "PRK" if country == "Dem. People's Rep. of Korea"
replace spicountrycode = "PRK" if country == "Democratic People's Republic of Korea"
replace spicountrycode = "PRK" if country == "Democratic People's Republic of  of Korea"
replace spicountrycode = "PRK" if country == "DPR Korea"
replace spicountrycode = "PRK" if country == "Korea (North)"
replace spicountrycode = "PRK" if country == "Korea DPR"
replace spicountrycode = "PRK" if country == "Korea, Dem. People's Rep."
replace spicountrycode = "PRK" if country == "Korea, Dem. People’s Rep."
replace spicountrycode = "PRK" if country == "Korea, Dem. Rep."
replace spicountrycode = "PRK" if country == "Korea, Dem. Rep. (North)"
replace spicountrycode = "PRK" if country == "Korea, Democratic People's Republic of"
replace spicountrycode = "PRK" if country == "Korea, Democratic Republic of"
replace spicountrycode = "PRK" if country == "Democratic People's Republic of Korea###"
replace spicountrycode = "PRK" if country == "Korea, North "
replace spicountrycode = "PRK" if country == "North Korea"
replace spicountrycode = "PRK" if country == "Korea_North"
replace spicountrycode = "PRT" if country == "Portugal"
replace spicountrycode = "PRY" if country == "Paraguay"
replace spicountrycode = "PYF" if country == "French Polynesia"
replace spicountrycode = "QAT" if country == "Qatar"
replace spicountrycode = "REU" if country == "Reunion"
replace spicountrycode = "REU" if country == "Réunion"
replace spicountrycode = "ROU" if country == "Romania#"
replace spicountrycode = "ROU" if country == "Romania"
replace spicountrycode = "RUS" if country == "Russia"
replace spicountrycode = "RUS" if country == "Russian Federation##"
replace spicountrycode = "RUS" if country == "Russian Federation"
replace spicountrycode = "RWA" if country == "Rwanda"
replace spicountrycode = "SAU" if country == "Saudi Arabia"
replace spicountrycode = "SCG" if country == "Serbia and Montenegro"
replace spicountrycode = "SCT" if country == "Scotland"
replace spicountrycode = "SDN" if country == "Sudan"
replace spicountrycode = "SDN" if country == "Sudan (pre-secession)"
replace spicountrycode = "SEN" if country == "Senegal"
replace spicountrycode = "SGP" if country == "Singapore"
replace spicountrycode = "SHN" if country == "Saint Helena"
replace spicountrycode = "SHN" if country == "Saint Helena, Ascension and Tristan da Cunha"
replace spicountrycode = "SHN" if country == "St. Helena"
replace spicountrycode = "SJM" if country == "Svalbard and Jan Mayen Islands"
replace spicountrycode = "SLB" if country == "Solomon Islands"
replace spicountrycode = "SLE" if country == "Sierra Leone"
replace spicountrycode = "SLV" if country == "El Salvador"
replace spicountrycode = "SML" if country == "Somaliland"
replace spicountrycode = "SML" if country == "Somaliland (Region)"
replace spicountrycode = "SML" if country == "Somaliland region"
replace spicountrycode = "SMR" if country == "San Marino"
replace spicountrycode = "SOM" if country == "Somalia"
replace spicountrycode = "SPM" if country == "Saint Pierre and Miquelon"
replace spicountrycode = "SPM" if country == "St. Pierre & Miquelon"
replace spicountrycode = "SPM" if country == "St. Pierre and Miquelon"
replace spicountrycode = "SRB" if country == "Serbia"
replace spicountrycode = "SSD" if country == "South Sudan"
replace spicountrycode = "STP" if country == "S. Tomé & Principe"
replace spicountrycode = "STP" if country == "SÃ£o TomÃ© and PrÃ­ncipe"
replace spicountrycode = "STP" if country == "S√É¬£o Tom√É¬© and Pr√É¬≠ncipe"
replace spicountrycode = "STP" if country == "SÃ£o TomÃ© och PrÃ­ncipe"
replace spicountrycode = "STP" if country == "Sao Tome"
replace spicountrycode = "STP" if country == "Sao Tome & Principe"
replace spicountrycode = "STP" if country == "São Tome & Principe"
replace spicountrycode = "STP" if country == "Sao Tome and Principe"
replace spicountrycode = "STP" if country == "São Tomé and Príncipe"
replace spicountrycode = "SUN" if country == "USSR"
replace spicountrycode = "SUR" if country == "Surinam"
replace spicountrycode = "SUR" if country == "Suriname"
replace spicountrycode = "SVK" if country == "Slovak Republic"
replace spicountrycode = "SVK" if country == "Slovakia"
replace spicountrycode = "SVN" if country == "Slovenia"
replace spicountrycode = "SWE" if country == "Sweden"
replace spicountrycode = "SWZ" if country == "Eswatini"
replace spicountrycode = "SWZ" if country == "Eswatini (Kingdom of)"
replace spicountrycode = "SWZ" if country == "Swaziland"
replace spicountrycode = "SXM" if country == "Sint Maarten"
replace spicountrycode = "SXM" if country == "Sint Maarten (Dutch part)"
replace spicountrycode = "SYC" if country == "Seychelles"
replace spicountrycode = "SYR" if country == "Syria"
replace spicountrycode = "SYR" if country == "Syrian A. R."
replace spicountrycode = "SYR" if country == "Syrian Arab Republic"
replace spicountrycode = "TCA" if country == "Turks & Caicos Is."
replace spicountrycode = "TCA" if country == "Turks and Caicos Islands"
replace spicountrycode = "TCD" if country == "Chad"
replace spicountrycode = "TGO" if country == "Togo"
replace spicountrycode = "THA" if country == "Thailand"
replace spicountrycode = "TJK" if country == "Tajikistan"
replace spicountrycode = "TKL" if country == "Tokelau"
replace spicountrycode = "TKL" if country == "Tokelau (Associated Member)"
replace spicountrycode = "TKM" if country == "Turkmenistan"
replace spicountrycode = "TLS" if country == "East Timor"
replace spicountrycode = "TLS" if country == "Timor Leste"
replace spicountrycode = "TLS" if country == "Timor-Leste"
replace spicountrycode = "TON" if country == "Tonga"
replace spicountrycode = "TTO" if country == "Trinidad"
replace spicountrycode = "TTO" if country == "Trinidad & Tobago"
replace spicountrycode = "TTO" if country == "Trinidad and Tobago"
replace spicountrycode = "TUN" if country == "Tunisia"
replace spicountrycode = "TUR" if country == "Turkey"
replace spicountrycode = "TUV" if country == "Tuvalu"
replace spicountrycode = "TWN" if country == "China, Taiwan Province of China"
replace spicountrycode = "TWN" if country == "Chinese Taipei"
replace spicountrycode = "TWN" if country == "Taiwan"
replace spicountrycode = "TWN" if country == "Taiwan Province of China"
replace spicountrycode = "TWN" if country == "Taiwan, China"
replace spicountrycode = "TWN" if country == "Taiwan, Province of China"
replace spicountrycode = "TWN" if country == "Taiwan (Province of China)"
replace spicountrycode = "TWN" if country == "Taiwan, Republic of China"
replace spicountrycode = "ZZB" if country == "Zanzibar"
replace spicountrycode = "TZA" if country == "Tanzania"
replace spicountrycode = "TZA" if country == "Tanzania (United Republic of)"
replace spicountrycode = "TZA" if country == "Tanzania, United Republic of"
replace spicountrycode = "TZA" if country == "U. R. Tanzania"
replace spicountrycode = "TZA" if country == "United Republic of Tanzania"
replace spicountrycode = "UGA" if country == "Uganda"
replace spicountrycode = "UKR" if country == "Ukraine"
replace spicountrycode = "URY" if country == "Uruguay"
replace spicountrycode = "USA" if country == "The United States Of America"
replace spicountrycode = "USA" if country == "United States"
replace spicountrycode = "USA" if country == "United States of America"
replace spicountrycode = "USA" if country == "USA"
replace spicountrycode = "USA" if country == "U.S."
replace spicountrycode = "UZB" if country == "Uzbekistan"
replace spicountrycode = "VAT" if country == "Holy See"
replace spicountrycode = "VAT" if country == "Holy See (Vatican City)"
replace spicountrycode = "VAT" if country == "Vatican"
replace spicountrycode = "VAT" if country == "Vatican City"
replace spicountrycode = "VAT" if country == "Holy See¬†(Vatican City State)"
replace spicountrycode = "VCT" if country == "Saint Vincent & Grenadines"
replace spicountrycode = "VCT" if country == "Saint Vincent and Grenadines"
replace spicountrycode = "VCT" if country == "Saint Vincent and the Grenadines"
replace spicountrycode = "VCT" if country == "Saint. Vincent and the Grenadines"
replace spicountrycode = "VCT" if country == "St Vincent & the Grenadines"
replace spicountrycode = "VCT" if country == "St Vincent and the Grenadines"
replace spicountrycode = "VCT" if country == "St. Vincent and the Grenadines"
replace spicountrycode = "VEN" if country == "Venezuela"
replace spicountrycode = "VEN" if country == "Venezuela "
replace spicountrycode = "VEN" if country == "Venezuela (Bolivarian Republic of)"
replace spicountrycode = "VEN" if country == "Venezuela, B. R."
replace spicountrycode = "VEN" if country == "Venezuela, Bolivarian Republic of"
replace spicountrycode = "VEN" if country == "Venezuela, RB"
replace spicountrycode = "VGB" if country == "British Virgin Islands"
replace spicountrycode = "VIR" if country == "United States Virgin Islands"
replace spicountrycode = "VIR" if country == "US Virgin Islands"
replace spicountrycode = "VIR" if country == "Virgin Islands (U.S.)"
replace spicountrycode = "VIR" if country == "Virgin Islands (US)"
replace spicountrycode = "VIR" if country == "Virgin Islands, U.S."
replace spicountrycode = "VNM" if country == "Democratic Republic of Vietnam"
replace spicountrycode = "VNM" if country == "Viet Nam"
replace spicountrycode = "VNM" if country == "Vietnam"
replace spicountrycode = "VNM" if country == "Vietnam_Democratic Republic of"
replace spicountrycode = "VUT" if country == "Vanuatu"
replace spicountrycode = "WBG" if country == "Israel/West Bank"
replace spicountrycode = "WBG" if country == "Occupied Palestinian Territory"
replace spicountrycode = "WBG" if country == "Palestina"
replace spicountrycode = "WBG" if country == "Palestine"
replace spicountrycode = "WBG" if country == "Palestine, State of"
replace spicountrycode = "WBGG" if country == "Palestine/Gaza"
replace spicountrycode = "WBGG" if country == "Gaza Strip"
replace spicountrycode = "WBGW" if country == "Palestine/West Bank"
replace spicountrycode = "WBGW" if country == "West Bank"
replace spicountrycode = "WBGP" if country == "Palestinian Authority Administered Territories*"
replace spicountrycode = "WBGI" if country == "Israeli-Occupied Territories"
replace spicountrycode = "WBGP" if country == "Palestinian Authority-Administered Territories"
replace spicountrycode = "WBG" if country == "Palestinian Authority or West Bank and Gaza Strip"
replace spicountrycode = "WBGP" if country == "Palestinian Territories"
replace spicountrycode = "WBGP" if country == "Palestinian Territory"
replace spicountrycode = "WBG" if country == "State of Palestine"
replace spicountrycode = "WBG" if country == "West Bank and Gaza"
replace spicountrycode = "WBG" if country == "West Bank and Gaza Strip"
replace spicountrycode = "WLF" if country == "Wallis and Futuna"
replace spicountrycode = "WLF" if country == "Wallis and Futuna Islands"
replace spicountrycode = "WLS" if country == "Wales"
replace spicountrycode = "WSM" if country == "Samoa"
replace spicountrycode = "YEM" if country == "Yemen"
replace spicountrycode = "YEM" if country == "Yemen, Rep."
replace spicountrycode = "YUG" if country == "Yugoslavia"
replace spicountrycode = "YUG2" if country == "Yugoslavia (Serbia & Montenegro)"
replace spicountrycode = "ZAF" if country == "South Africa"
replace spicountrycode = "ZMB" if country == "Zambia"
replace spicountrycode = "ZWE" if country == "Zimbabwe"
replace spicountrycode = "BES" if country == "Caribbean Netherlands"
replace spicountrycode = "CIV" if country == "CÙte d'Ivoire"
replace spicountrycode = "ALA" if country == "Åland Islands"
replace spicountrycode = "KNA" if country == "St Kitts and Nevis"
replace spicountrycode = "LCA" if country == "St Lucia"
replace spicountrycode = "CIV" if country == "CĂ´te d'Ivoire"
replace spicountrycode = "PRK" if country == "Korea (Democratic People's Rep. of)"
replace spicountrycode = "ASC" if country == "Ascension"
replace spicountrycode = "SBL" if country == "Saint Barthelemy"
replace spicountrycode = "VGB" if country == "Virgin Islands (British)"
replace spicountrycode = "COD" if country == "Democratic Republic Congo"
replace spicountrycode = "VAT" if country == "Vatican City State"
replace spicountrycode = "SSD" if country == "Republic of South Sudan"
replace spicountrycode = "SDN1" if country == "Sudan pre-secession"
replace spicountrycode = "TUR" if country == "Turkiye"
replace spicountrycode = "TUR" if country == "Türkiye"
replace spicountrycode = "TUR" if country == "TÃ¼rkiye"
replace spicountrycode = "NLD" if country == "Netherlands (Kingdom of the)"
replace spicountrycode = "TWN" if country == "China, Taiwan Province of"
replace spicountrycode = "TUR" if country == "TĂĽrkiye"
replace spicountrycode = "PRK" if country == "Korea, North"
replace spicountrycode = "LAO" if country == "Lao People's Dem. Republic"
replace spicountrycode = "CIV" if country == "CÃ´te dâIvoire"
}

order spicountrycode, after(country)
sort spicountrycode year
drop if spicountrycode == ""
**to be merged later using iso3c_r
ren spicountrycode iso3c_r 

save "data/FSI_reduced/fsi_reduced_all.dta", replace
clear
