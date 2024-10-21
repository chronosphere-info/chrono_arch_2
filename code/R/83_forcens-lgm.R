#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){

		dat <- read.csv(file.path(dir, "LGM_foraminifera_assemblages_20240110.csv"))

		# return
		return(dat)
	}, 
	ns="chronosphere")
