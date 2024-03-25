#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){

		# read in the data
		dat <- read.csv("EJJudd-PhanSST-fce2476/PhanSST_v001.csv")

		# return
		return(dat)
	}, 
	ns="chronosphere")
