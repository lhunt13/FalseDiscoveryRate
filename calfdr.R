#####################################################
########### FUNCTION TO CALCULATE SWFDR #############
#####################################################


calFDR <- function(df){
  library(stats4)
  #Get the code to calculate SWFDR
  source("https://raw.githubusercontent.com/jtleek/swfdr/master/calculateSwfdr.R")
  
  
  
  result = sapply(df, function(x)
    {
    
    #truncated or not
    tt = as.numeric(x[,2])
    
    #rounded or not
    rr = rep(0,length(tt)) 
    #for those that are not truncated check if their values equal after rounding
    rr[tt == 0] = (as.numeric(x[tt==0,1]) == round(as.numeric(x[tt==0,1]),2)) 
    
    #pvalues
    pp = as.numeric(x[,1])
    out = calculateSwfdr(pp,tt,rr)
    c("swfdr" = out$$pi0, unique(row.names(x)), unique(x[,4]))
  })
  
  plot.dat <- data.frame("swfdr" = result[1,], "journal" = result[2,],  "year" = result[3,])
  return(plot.dat)
}