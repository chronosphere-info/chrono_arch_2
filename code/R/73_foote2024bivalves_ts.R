#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){
		# read in the data
		dat <- read.csv(file.path(dir,"rsbl20230475_si_001.csv"))

		# return
		return(dat)
	}, 
	ns="chronosphere")
