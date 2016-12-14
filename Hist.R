makehist <- function(x)
{
  no_row <- nrow(x)
  Values <- c(rep("Observed p -values",no_row), rep("Local FDR", no_row))
  xj <- x$journal
  xj[xj == "New England Journal of Medicine"] = "NEJM"
  xj[xj == "American Journal of Epidemiology"] = "AJE"
  a1 <- c(xj, xj)
  a2 <- c(as.numeric(x$pvalue), as.numeric(x$ppv))
  dat1 <- data.frame(Journal = factor(a1), Probability = a2, Values = factor(Values))
  p <- ggplot(dat1, aes(x=Probability, fill=Values, color=Values)) +
   geom_histogram(position="identity", alpha=0.5) + facet_grid(Journal ~ .) + xlab("Probability") + ylab("Frequency")
  p +  theme(axis.text = element_text(face = "bold", size = 16), axis.title = element_text(face = "bold", size = 16),
             legend.title = element_text(face = "bold", size = 16), legend.text = element_text(face = "bold", size = 16),
             strip.text = element_text(face = "bold", size = 16)) 
}