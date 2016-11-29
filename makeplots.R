#--------Function to make longitudinal plot------#

makeplot < function(fdrdata)
{
  p <- ggplot(data = fdrdata, aes(x = year, y = swfdr, colour = journal, group = journal))
  return(p + geom_point() + geom_line())
}

makeplot(fdrdata) #---fdrdata <- calfdr(df)---#