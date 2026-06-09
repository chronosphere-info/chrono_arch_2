#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?

assignInNamespace(
	"loadVar",
	function(dir, verbose=FALSE, attach=TRUE){

		# uses chinese traditional encoding
		dat <- read.delim(file.path(dir,"supplementary_data_file.txt "))

		# return
		return(dat)
	},
ns="chronosphere")
