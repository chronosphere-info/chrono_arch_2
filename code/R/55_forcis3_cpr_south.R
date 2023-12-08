#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){
		ver <- "v03"
		date <- "14062023"
		thing <- "cpr_south"
		# read in the data
		dat <- read.csv(file.path(dir,paste0("FORCIS_", thing, "_", ver, "_", date, ".csv" )), sep=";")

		# return
		return(dat)
	}, 
	ns="chronosphere")
