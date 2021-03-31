// clean data and graph before 
graph drop _all
clear
cls
clear all

// import data
cd /Users/sun/Desktop/Econ580Data/
import delimited 2000-2012_all.csv, varnames(1) encoding(UTF-8)


generate urban = 0 
replace urban = 1 if ruralpopulationshare < 0.7
replace urban = 2 if ruralpopulationshare < 0.5

gen lnRes = ln(resilience)
// describe

// check Heteroskedasticity
// reg lnRes gdppercapita villagenumber villagecommit~r yearendhouseh~r amongthemrura~r yearendpopula~n amongthemrura~n yearendindust~t ruralemployment amongthemagri~m totalpowerofa~r localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingsofurba~s yearendbalanc~i grainyield cottonyield gasyield  meatyield  numberofindus~o grossindustri~d completedcapi~e numberofstud~or numberofstud~ar numberofbedsi~h numberofsocia~n numberofbedsi~i earthquakeaff~y ruralpopulati~e, robust

// estat hettest, rhs fstat
// pwcorr, star(.05)


reg lnRes gdppercapita yearendhouseh~r amongthemrura~r yearendpopula~n yearendindust~t ruralemployment amongthemagri~m localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingsofurba~s yearendbalanc~i grainyield cottonyield gasyield  meatyield numberofstud~or numberofstud~ar numberofbedsi~h numberofsocia~n numberofbedsi~i earthquakeaff~y ruralpopulati~e , robust


// pwcorr, star(.05)


// group
// keep if urban == 1
// keep if urban == 0
keep if urban == 2
// reg resilience gdppercapita villagenumber villagecommit~r yearendhouseh~r amongthemrura~r yearendpopula~n yearendindust~t ruralemployment amongthemagri~m totalpowerofa~r localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingsofurba~s yearendbalanc~i grainyield cottonyield gasyield  meatyield  numberofstud~or numberofstud~ar numberofbedsi~h numberofsocia~n numberofbedsi~i earthquakeaff~y, robust

reg lnRes gdppercapita yearendhouseh~r amongthemrura~r yearendpopula~n yearendindust~t ruralemployment amongthemagri~m localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingsofurba~s yearendbalanc~i grainyield cottonyield gasyield  meatyield numberofstud~or numberofstud~ar numberofbedsi~h numberofsocia~n numberofbedsi~i earthquakeaff~y ruralpopulati~e, robust



