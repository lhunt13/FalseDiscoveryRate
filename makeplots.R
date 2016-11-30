#--------Function to make longitudinal plot------#

makeplot <- function(fdrdata)
{
  p <- ggplot(data = fdrdata, aes(x = year, y = swfdr, colour = journal, group = journal))
  p + geom_point() + geom_line()
}

