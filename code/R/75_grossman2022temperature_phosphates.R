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
		dat <- openxlsx::read.xlsx(file.path(dir, "41598_2022_11493_MOESM2_ESM.xlsx"), sheet=2, startRow=2)

		# return
		return(dat)
	}, 
	ns="chronosphere")
