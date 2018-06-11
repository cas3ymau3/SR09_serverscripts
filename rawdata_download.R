# Create list of `.tgz` files to download from Dropbox 
files <- drop_dir(path=drop.rawDataByYear)[,2]
files <- files$name[substr(files$name, 5, 8) %in% year.names]

# Loop over files, and: 
# (1) Download year-specific tarball
# (2) Unzip tarball (extract state-specific .dta files to disk)
# (3) Compute degree days using `ddaycompute`
# (4) Delete data from disk 
for (i in 1:length(files)){
  # download `.tgz' file from Dropbox 
  drop_download(path=paste(drop.rawDataByYear,"/",files[i],sep=""),
                local_path=data.rawDataByYear, 
                overwrite=TRUE, 
                progress=TRUE,
                verbose=TRUE,
                dtoken = token)
  
  # unzip tarball
  setwd(data.rawDataByYear)
  untar(files[i], exdir=data.rawDataByYear)
  
  # compute degree days 
  ddaycompute(year.list[i])
  
  # delete original `.tgz' file and extracted `.dta' files 
  file.remove(files[i]) 
  unlink(paste0("year",year.list[i],sep=""), recursive = TRUE)
}