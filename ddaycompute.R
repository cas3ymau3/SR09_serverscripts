# Create function `ddaycompute`
ddaycompute <- function(t) {
  # Loop over states in `state.list`
  for (s in state.list) { 
    
    # read in Stata .dta file 
    year.path <- paste0(data.rawDataByYear,"/","year",t)
    setwd(year.path)
    assign("data",read.dta13(paste0("state",s,"_","year",t,".dta"),convert.dates=TRUE))
    
    # select subset of observations in growing season, and compute `tAvg`
    mindate <- as.numeric(as.Date(as.character(paste(monthBegin,dayMonthBegin,t,sep="/")),format="%m/%d/%Y"))
    maxdate <- as.numeric(as.Date(as.character(paste(monthEnd,dayMonthEnd,t,sep="/")),format="%m/%d/%Y"))
    data <- subset(data, dateNum >= mindate & dateNum <= maxdate)
    data$dateNum <- as.numeric(data$dateNum)
    data$tAvg <- (data$tMin + data$tMax)/2 
    
    # merge to `grid.info` and keep obs w/non-zero weights
    setwd(data.metaData)
    data <- merge.data.frame(data,grid.info,all=FALSE)
    data <- subset(data, data$cropArea >0)
    
    # generate degree days 
    if (nrow(data)>0){
      for (b in bound.list) {
        if (b<0){ 
          b2 <- abs(b)
          blabel <- paste0("Minus",b2,sep="")
        }
        else {
          blabel <- paste0(b)
        }
        # default case 1: `tMax`<=b
        data$dday <- 0
        # case 2: b <= tMin
        index1 <- data$tMin >= b
        data$dday[index1] <-  data$tAvg[index1] - b
        # case 3: tMin < bound < tMax
        index2 <- data$tMin<b & data$tMax>b
        data$tempsave <- 0 
        data$tempsave[index2] <- acos((2*b-data$tMax[index2]-data$tMin[index2])/(data$tMax[index2]-data$tMin[index2]))
        data$dday[index2] <- ((data$tAvg[index2]-b)*data$tempsave[index2] + 
                                (data$tMax[index2]-data$tMin[index2])*sin(data$tempsave[index2])/2 )/pi
        # rename `dday' column 
        colnames(data)[colnames(data)=="dday"] <- paste0("dday",blabel,"C",sep="")
      }
      
      # remove `tempsave` column 
      data <- data[colnames(data)!="tempsave"] 
      
      # aggregate tMin, tMax, tAvg, prec, and dday vars using weighted mean (weights=cropArea)
      data <- data.table(data)
      data <- data[, lapply(.SD, FUN=weighted.mean, w=cropArea), by=c("fips","dateNum")]
      
      # aggregate data to fips-year level 
      data$year <- t 
      sum.list <- c("prec",colnames(data)[grep("dday",colnames(data))])
      mean.list <- c("dateNum", "gridNumber",
                     "tMin","tMax","tAvg", 
                     "cropArea", "gridArea",
                     "longitude","latitude")
      data.1 = data[, lapply(.SD,sum), by = c("fips","year"), .SDcols = sum.list]
      data.2 = data[, lapply(.SD,mean), by = c("fips","year"), .SDcols = mean.list]
      setkeyv(data.1, c("fips","year"))
      setkeyv(data.2, c("fips","year"))
      data <- merge(data.1, data.2, by = c("fips","year"))
      rm(data.1)
      rm(data.2)
      
      # set working directory to `output` folder 
      setwd(output)
      
      # if output file doesn't exist, then save 
      if (!file.exists("ddayByYearandFips_cropAreaWeighted.rds")){
        saveRDS(data, file="ddayByYearandFips_cropAreaWeighted.rds")
      }
      
      # if output file already exist, then : 
      # (1) load the previously created data 
      # (2) append new data
      # (3) save/replace the output file 
      if (file.exists("ddayByYearandFips_cropAreaWeighted.rds")){
        data2 <- readRDS("ddayByYearandFips_cropAreaWeighted.rds")
        data <- rbind(data,data2)
        saveRDS(data, file="ddayByYearandFips_cropAreaWeighted.rds")
        rm(data2)
      }
    }
    
    # remove `data` from local environment and reset working directory
    rm(data)
    setwd(data.rawDataByYear)
  }
}