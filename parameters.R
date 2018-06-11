# Define degree-day bins (create `boundList`)
bound.list <- c(0,5,8,10,12,15,20,25,29,30,31,32,33,34)

# Set the sample of years to use (1950-2017)
yearMin <- 2012
yearMax <- 2014
year.list <- c(yearMin:yearMax)
year.names <- as.character(year.list)

# Define growing season
monthBegin <- 4
dayMonthBegin <- 1 
monthEnd <- 9 
dayMonthEnd <- 30 

# Define states to be included in analysis 
state.list <- c(1,4,5,6,8,9,10,11,12,13,16,
                17,18,19,20,21,22,23,24,25,
                26,27,28,29,30,31,32,33,34,
                35,36,37,38,39,40,41,42,44,
                45,46,47,48,49,50,51,53,54,
                55,56)
# States Key: ----
# 1 - Alabama 
# 4 - Arizona 
# 5 - Arkansas 
# 6 - California 
# 8 - Colorado 
# 9 - Connecticut 
# 10 - Delaware 
# 11 - District of Columbia 
# 12 - Florida 
# 13 - Georgia 
# 16 - Idaho 
# 17 - Illinois 
# 18 - Indiana 
# 19 - Iowa 
# 20 - Kansas 
# 21 - Kentucky 
# 22 - Louisiana 
# 23 - Maine 
# 24 - Maryland 
# 25 - Massachusetts 
# 26 - Michigan 
# 27 - Minnesota 
# 28 - Mississippi 
# 29 - Missouri 
# 30 - Montana 
# 31 - Nebraska 
# 32 - Nevada 
# 33 - New Hampshire 
# 34 - New Jersey 
# 35 - New Mexico 
# 36 - New York 
# 37 - North Carolina 
# 38 - North Dakota 
# 39 - Ohio 
# 40 - Oklahoma 
# 41 - Oregon 
# 42 - Pennsylvania 
# 44 - Rhode Island 
# 45 - South Carolina 
# 46 - South Dakota 
# 47 - Tennessee 
# 48 - Texas 
# 49 - Utah 
# 50 - Vermont 
# 51 - Virginia 
# 53 - Washington 
# 54 - West Virginia 
# 55 - Wisconsin 
# 56 - Wyoming 
# ----