#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){

        if(! requireNamespace("openxlsx", quietly=TRUE)) stop("This dataset requires the 'openxlsx' package to load.")
	
		if(attach){
			library("openxlsx")
		}

		# read in the data
		dat <- openxlsx::read.xlsx(file.path(dir, "1-s2.0-S1342937X16304129-mmc1.xlsx"), sheet=1, startRow=2)

		# keep only the weathering ones
		dat <- dat[c(1, 5:7)]

		# return
		return(dat)
	}, 
	ns="chronosphere")
