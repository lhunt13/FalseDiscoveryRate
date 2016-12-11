
#####################################################
######### FUNCTION TO CALCULATE GET DATA ############
# This function uses the subsetted data from LH and 
# creates a list of where each element is the data
# subsetted by Journal and year the user selected
#####################################################
# Create data
# input_data <- pvalueData

my_pvalueData <- function(input_data){
  # Get the Journals
  data_list <- unique(row.names(input_data))
  
  # Subset the input_dat by Journal
  my_Data <- sapply(data_list, function(x)
  {
    input_data[row.names(input_data) == paste(x), ]
  }, simplify = "list")
  
  return(my_Data)
}





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
    rr[tt == 0] = (as.numeric(x[tt == 0,1]) == round(as.numeric(x[tt == 0,1]),2)) 
    
    #pvalues
    pp = as.numeric(x[,1])
    out = calculateSwfdr(pp,tt,rr)
    if(length(unique(x[,4])) == 1){
      fdr.stats <- c("swfdr" = out$pi0, unique(row.names(x)), unique(x[,4]))
    }
    else{
      years <- unique(x[,4])
      fdr.stats <- c("swfdr" = out$pi0, unique(row.names(x)), paste(min(years), "to", max(years)))
    }
    return(fdr.stats)
  })
  
  plot.dat <- data.frame("swfdr" = result[1,], "journal" = result[2,],  "range" = result[3,])
  
  #Data.table part
  result = lapply(df, function(x)
  {
    
    #truncated or not
    tt = as.numeric(x[,2])
    
    #rounded or not
    rr = rep(0,length(tt)) 
    #for those that are not truncated check if their values equal after rounding
    rr[tt == 0] = (as.numeric(x[tt == 0,1]) == round(as.numeric(x[tt == 0,1]),2)) 
    
    #pvalues
    pp = as.numeric(x[,1])
    out = calculateSwfdr(pp,tt,rr)
    
    re <- as_data_frame(x)
    re$journal <- row.names(x)
    re$ppv <- out$z #ppv is posterior pvalue
    re <- select(re,journal, pvalue, pvalueTruncated, 
                     pubmedID, year, abstract, title, ppv)
    return(re)
  })
  data.table <- plyr::ldply (result, data.frame) 
  
  
  # return(list(plot.data = plot.dat, data.table = data.table))
  out.results <- inner_join(data.table, plot.dat) %>%
    select(journal, swfdr, pvalue, ppv, pubmedID, year, range)
  out.results <- as.data.frame(out.results)
  return(out.results)
}