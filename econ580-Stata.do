// clean data and graph before 
graph drop _all
clear
cls
clear all

// import data
cd /Users/sun/Desktop/Econ580Data/
import delimited 2000-2012_all.csv, varnames(1) encoding(UTF-8)
		  
// correlation
// pwcorr, star(.05)

// drop variables that are not needed
drop villagenumber villagecommitteenumber yearendhouseholdnumber amongthemruralhouseholdnumber amongthemruralpopulation  grainyield cottonyield gasyield meatyield totalpowerofa~r

// employment rate change
gen empChange = (v2 - employment)/employmentrate * 100
gen empRes = (v6 - employment)/employmentrate * 100
gen empRec = (v6 - v2)/v2 * 100


// total employmentrate
gen totalEmp = (yearendindustryemployment + ruralemployment ) / yearendpopulation / 10000 * 100
gen indEmp = (yearendindustryemployment ) / yearendpopulation / 10000 * 100
gen ruralEmp = (ruralemployment ) / yearendpopulation / 10000 * 100


// definition of urban is not approprate, 
// should be three types of regions, but not necessarily rural, intermediate, or urban
generate urban = 0
replace urban = 1 if ruralpopulationshare < 90
replace urban = 2 if ruralpopulationshare < 80

// not used log of resilience
// gen lnRes = ln(resilience)

// gen x=_n
// graph twoway scatter ruralhouseshare x if ruralhouseshare < 1.01

// generate dumRes = 1 
// replace dumRes = 0 if resilience <= 0

// number to percentage
gen primaryPer = numberofstudentsenrolledinprimar / yearendpopulation * 100
gen juniorPer = numberofstudentsenrolledinjunior / yearendpopulation * 100
gen healthPer = numberofbedsinhospitalsandhealth / yearendpopulation * 100
gen welfarePer = numberofbedsinsocialwelfareinsti / yearendpopulation * 100
gen savingPer =  savingsofurbanandruralresidents / yearendpopulation
gen debtPer = yearendbalanceofvariousloansoffi / yearendpopulation
gen budgetPer = localgovernmentbudgetrevenue  /yearendpopulation
gen fiscalPer = localfiscalexpenditure / yearendpopulation


// get the data
describe
codebook

// on region groups
// keep if urban == 2

// check Heteroskedasticity
// reg empRec gdppercapita yearendpopula~n ruralEmp indEmp localphoneusers gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingPer debtPer primaryPer juniorPer healthPer welfarePer earthquakeaff~y ruralpopulationshare

// reg empChange gdppercapita yearendpopula~n ruralEmp indEmp localphoneusers gvaoffirstsec~r gvaofsecondse~r savingPer budgetPer savingPer debtPer primaryPer juniorPer healthPer welfarePer earthquakeaff~y ruralpopulationshare


// estat hettest, rhs fstat



// fwls
regress empRec gdppercapita yearendpopula~n totalEmp localphoneusers gvaofsecondse~r localgovernme~e localfiscalex~e savingPer debtPer primaryPer juniorPer healthPer welfarePer earthquakeaff~y ruralpopulationshare, robust

predict uhat, residuals
gen luhat2 = ln(uhat^2)
regress luhat2 gdppercapita yearendpopula~n totalEmp localphoneusers  gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingPer debtPer primaryPer juniorPer healthPer welfarePer earthquakeaff~y ruralpopulationshare

predict lhhat
gen hhat = exp(lhhat)

regress empRec gdppercapita yearendpopula~n totalEmp localphoneusers  gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingPer debtPer primaryPer juniorPer healthPer welfarePer  earthquakeaff~y ruralpopulationshare [aweight=1/hhat], robust


// // catagory
// regress empRec gdppercapita yearendpopula~n indEmp localphoneusers   gvaofsecondse~r localgovernme~e localfiscalex~e savingPer debtPer primaryPer juniorPer healthPer welfarePer earthquakeaff~y, robust

// predict uhat, residuals
// gen luhat2 = ln(uhat^2)
// regress luhat2 gdppercapita yearendpopula~n indEmp localphoneusers   gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingPer debtPer primaryPer juniorPer healthPer welfarePer earthquakeaff~y 

// predict lhhat
// gen hhat = exp(lhhat)

// regress empRec gdppercapita yearendpopula~n indEmp localphoneusers   gvaoffirstsec~r gvaofsecondse~r localgovernme~e localfiscalex~e savingPer debtPer primaryPer juniorPer healthPer welfarePer  earthquakeaff~y [aweight=1/hhat], robust


// store the txt file, replace all.txt to the name of the file to store, will replace the existing one
// translate @Results final_data/rec-all.txt, replace


