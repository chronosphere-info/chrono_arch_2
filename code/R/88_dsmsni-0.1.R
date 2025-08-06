#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=TRUE){

		# uses chinese traditional encoding
		dat <- read.csv(file.path(dir,"DSMSNI_v0.1.csv"), fileEncoding="GB18030")

		# clean  up the file (empty column + apparent leftovers)
		dat$X <- NULL
		dat$X.1 <- NULL

		# return
		return(dat)
	}, 
ns="chronosphere")
