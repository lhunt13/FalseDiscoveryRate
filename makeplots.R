#--------Function to make longitudinal plot------#

makeplot <- function(d)
{
  p <- ggplot(data = d, aes(x = year, y = swfdr, colour = journal, group = journal))
  p + geom_point() + geom_line()
}

