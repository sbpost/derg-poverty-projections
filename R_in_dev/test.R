library(haven)
library(tidyverse)
proj_tbl <- read_dta("../data/projections/Projections.dta")

# Instructions from Daniel ---
# Note that whenever the column inPovcalNet equals no, we do not have any
# primary data for the country and the numbers you see are simply the
# regional average. Kindly do not use these numbers unless you want to
# aggregate up to a regional or global number. If you only need our baseline
# estimate for each country, this code should do the work:
# 
# keep if inlist(alpha,0,.)
# keep if inlist(extragrowth,0,.)
# keep if inlist(gic,"l","")
# keep if inlist(passthrough,"mbrp","")
# keep if inlist(growth,"2008-2018","")
# keep country code year pop inPovcalNet FGT0_19
#  
# I think the rest is all self-explanatory but let me know if anything doesn’t add up.



proj_tbl %>%
	filter(year == 2010) %>%
	filter(region_pcn == "ECA") %>%
	View()
	filter(alpha == 0 | is.na(alpha)) %>% # keep if inlist(alpha,0,.)
	filter(extragrowth == 0 | is.na(extragrowth))  %>% # keep if inlist(extragrowth,0,.)
	filter(gic == "l" | gic == "") %>% # keep if inlist(gic,"l","")
	filter(passthrough == "mbrp" | passthrough == "") %>% # keep if inlist(passthrough,"mbrp","")
	filter(growth == "2008-2018" | growth == "") %>% # keep if inlist(growth,"2008-2018","")
	filter(region_wb == "Sub-Saharan Africa") %>%
	filter(inPovcalNet != "No") %>%
	filter(year > 2025) %>%
	select(country, code, year, pop, inPovcalNet, FGT0_19) # keep country code year pop inPovcalNet FGT0_19 (FGT0_19 = $1.90)

proj_tbl$passthrough %>% unique()
proj_tbl$gic %>% unique()
proj_tbl$growth %>% unique()
proj_tbl$extragrowth %>% unique()
proj_tbl$alpha %>% unique()
proj_tbl$alpha %>% unique()
proj_tbl$region_wb %>% unique()


# Variables:
# FGT0_19 = forecast 0 (baseline?) % of pop under $1.90
# TODO:

# Questions: 
# Which are the T0, T1, T2 scenarios? 
# Which are the different GIC? (L) (c = concave, l = linear)
		
