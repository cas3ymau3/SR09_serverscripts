# Generate and save Dropbox authorization token
setwd(data.dir)
# token <- drop_auth() # generates token and authorizes app on Dropbox (run if using code for the first time)
# saveRDS(token, "droptoken.rds") # saves token for future use (run if using code for the first time) 
token<-readRDS("droptoken.rds")
# drop_acc(dtoken=token) # prints account details