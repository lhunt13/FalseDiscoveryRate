makehist <- function(x)
{
  #d <- as.data.frame(d)
  no_row <- nrow(x)
  prob <- c(rep("Prior",no_row), rep("Posterior", no_row))
  a1 <- cbind(x$journal, x$pvalue)
  a2 <- cbind(x$journal, x$ppv)
  names(a2) <- names(a1)
  dat1 <- rbind(a1,a2)
  dat2 <- cbind(dat1,prob)
  dat3 <- as.data.frame(dat2)
  colnames(dat3) <- c("Journal","p-values","Type")
  dat3$Journal <- as.factor(dat3$Journal)
  #dat$Values <- as.numeric(dat$Values)
  dat3$Type<- as.factor(dat3$Type)
ggplot(dat3, aes(x=Values, fill=Type, color = Type)) + 
  geom_histogram(position="identity", alpha=0.5) + facet_grid(Journal ~ .) 
}