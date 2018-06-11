# Load `cropArea.dta` file and create lat/lon
setwd(data.metaData)
cropArea <- read.dta13("cropArea.dta")
cropArea$longitude <- -125 + ((cropArea$gridNumber-1) %% 1405)/24
cropArea$latitude <- 49.9375+1/48 - (ceiling(cropArea$gridNumber/1405))/24

# Merge to `linkGridnumberFIPS.dta' and save `grid.info` as .Rds
linkGridnumberFIPS <- read.dta13("linkGridnumberFIPS.dta")
grid.info <- merge.data.frame(cropArea,linkGridnumberFIPS,all=TRUE)
saveRDS(grid.info, file="grid.info.rds")