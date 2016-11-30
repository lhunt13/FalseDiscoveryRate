load("pvalueData.rda")
library(stats4)

data_list <- unique(cbind(row.names(pvalueData), pvalueData[,4]))

my_pvalueData <- mapply(function(x,y) {
  pvalueData[row.names(pvalueData) == paste(x) & pvalueData[,4] == paste(y), ]
},data_list[,1], data_list[,2], SIMPLIFY = "list")

source("calfdr.R")
fdrdata <- calFDR(my_pvalueData)
write.csv(fdrdata, "fdrdata.csv")
system( paste("gzip", "fdrdata.csv") )

