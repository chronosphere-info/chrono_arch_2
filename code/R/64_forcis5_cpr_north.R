#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){
		ver <- "v05"
		date <- "14092023"
		thing <- "cpr_north"
		# read in the data
		dat <- read.csv(file.path(dir,paste0("FORCIS_", thing, "_", ver, "_", date, ".csv" )), sep=";")

		# return
		return(dat)
	}, 
	ns="chronosphere")
