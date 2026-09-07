#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){

        if(! requireNamespace("gen3sis2", quietly=TRUE)) stop("This dataset requires the 'gen3sis2' package to load.")
	
		# read in the data
		# return
		return(file.path(getwd(), dir))
	}, 
	ns="chronosphere")
