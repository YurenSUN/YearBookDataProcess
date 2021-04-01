// clean data and graph before 
graph drop _all
clear
cls
clear all

// import data
cd /Users/sun/Desktop/Econ580Data/
import delimited 2000-2012_all.csv, varnames(1) encoding(UTF-8)

// describe
// definition of urban is not approprate, 
// should be three types of regions, but not necessarily rural, intermediate, or urban
generate urban = 0
replace urban = 1 if ruralpopulationshare < 0.9
replace urban = 2 if ruralpopulationshare < 0.8

gen lnRes = ln(resilience)

// gen x=_n
// graph twoway scatter ruralhouseshare x if ruralhouseshare < 1.01

generate dumRes = 1 
replace dumRes = 0 if resilience <= 0

// keep if urban == 2

// check Heteroskedasticity
// reg dumRes gdppercapita villagenumber villagecommit~r yearendhouseh~r amongthemrura~r yearendpopula~n amongthemrura~n yearendindust~t ruralemployment amongthemagri~m totalpowerofa~r localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingsofurba~s yearendbalanc~i grainyield cottonyield gasyield  meatyield  numberofindus~o grossindustri~d completedcapi~e numberofstud~or numberofstud~ar numberofbedsi~h numberofsocia~n numberofbedsi~i earthquakeaff~y ruralpopulati~e urban

// correlation
// pwcorr, star(.05)

// estat hettest, rhs fstat
// Get: 
// F(32 , 1495) =     2.94
// Prob > F     =   0.0000

// pwcorr, star(.05)


// robust
// three kinds of regression, the xs in the fwls below follow xs here.
// all regions, urban dummy
regress dumRes gdppercapita yearendpopula~n yearendindust~t localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingsofurba~s yearendbalanc~i numberofstud~or numberofstud~ar numberofbedsi~h numberofbedsi~i earthquakeaff~y urban, robust
// all regions, ruralpopulationshare
// regress dumRes gdppercapita yearendpopula~n yearendindust~t localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingsofurba~s yearendbalanc~i numberofstud~or numberofstud~ar numberofbedsi~h numberofbedsi~i earthquakeaff~y urban, robust
// only part of the regions based on urban
// regress dumRes gdppercapita yearendpopula~n yearendindust~t localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingsofurba~s yearendbalanc~i numberofstud~or numberofstud~ar numberofbedsi~h numberofbedsi~i earthquakeaff~y, robust


// fwls, 410 lec 17
reg dumRes gdppercapita yearendpopula~n localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingsofurba~s yearendbalanc~i numberofstud~or numberofstud~ar numberofbedsi~h numberofbedsi~i earthquakeaff~y, robust

predict uhat, residuals
gen luhat2 = ln(uhat^2)
regress luhat2 ruralpopulati~e

predict lhhat
gen hhat = exp(lhhat)

regress dumRes gdppercapita yearendpopula~n  localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingsofurba~s yearendbalanc~i numberofstud~or numberofstud~ar numberofbedsi~h numberofbedsi~i earthquakeaff~y[aweight=1/hhat], robust

// store the txt file, replace all.txt to the name of the file to store, will replace the existing one
translate @Results all.txt, replace


