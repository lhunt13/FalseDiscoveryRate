makehist <- function(x)
{
  #x <- as.data.frame(x)
  no_row <- nrow(x)
  #hist(as.numeric(x$ppv))
  prob <- c(rep("Prior",no_row), rep("Posterior", no_row))
  a1 <- c(x$journal, x$journal)
  a2 <- c(as.numeric(x$pvalue), as.numeric(x$ppv))
  dat1 <- data.frame(Journal = factor(a1), pvalues = a2, pvalue_type = factor(prob))
  #dat3 <- as.data.frame(dat2)
  #colnames(dat2) <- c("Journal","pvalues","Type")
  #dat2$Journal <- as.factor(dat2$Journal)
  #dat2$pvalues <- as.numeric(dat2$pvalues)
  #hist(dat1$pvalues)
  #dat2$Type<- as.factor(dat2$Type)
 ggplot(dat1, aes(x=pvalues, fill=pvalue_type, color=pvalue_type)) +
   geom_histogram(position="identity", alpha=0.5) + facet_grid(Journal ~ .)
}