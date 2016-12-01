#--------Function to make longitudinal plot------#

makeplot <- function(d)
{
  d$year <- as.factor(d$year)
  p <- ggplot(data = d, aes(x = year, y = swfdr, colour = journal, group = journal))
  p + geom_point() + geom_line()
}

