#--------Function to make longitudinal plot------#

makeplot <- function(d)
{
  d$year <- as.factor(d$year)
  p <- ggplot(data = d, aes(x = year, y = swfdr, colour = journal, group = journal))
  p + geom_point() + geom_line() + xlab("Year") + ylab("False Discovery Rate") + theme(axis.text=element_text(size=12), axis.title=element_text(size=14,face="bold"))
}

