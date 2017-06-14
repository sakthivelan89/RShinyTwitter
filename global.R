library(shiny)
library(xtable)

  if (!require(twitteR)) {
	stop("This app requires the twitteR package. To install it, run 'install.packages(\"twitteR\")'.\n")
}
