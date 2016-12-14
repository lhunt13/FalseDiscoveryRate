#--------Function to make longitudinal plot------#

makeplot <- function(d)
{
  d$year <- as.factor(d$year)
  dj <- as.character(d$journal)
  dj[dj == "New England Journal of Medicine"] = "NEJM"
  dj[dj == "American Journal of Epidemiology"] = "AJE"
  d$journal <- as.factor(dj)
  dark_col <- c("red", "blue", "darkgreen", "brown","orange")
  p <- ggplot(data = d, aes(x = year, y = swfdr, colour = journal, group = journal))
  p + geom_point() + geom_line() + xlab("Year") + ylab("False Discovery Rate") + 
    theme(axis.text = element_text(face = "bold", size = 16), axis.title = element_text(face = "bold", size = 16),
          legend.title = element_text(face = "bold", size = 16), legend.text = element_text(face = "bold", size = 16),
          strip.text = element_text(face = "bold", size = 16)) +
    scale_colour_manual("Journal", values = c("AJE" = dark_col[1], "BMJ" = dark_col[2], "JAMA" = dark_col[3], "NEJM" = dark_col[4], "Lancet" = dark_col[5]))
}

