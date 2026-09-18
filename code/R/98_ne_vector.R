#' @param verbose logical flag to indicate whether verbose output is required.
#' @param attach logical flag to indicate whether the required package(s) should be attached.

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=TRUE){
        if(! requireNamespace("sf", quietly=TRUE)) stop("This dataset requires the 'sf' package to load.")
	
		if(attach){
			library("sf")
		}
		# list out the files in the directory
		allFiles <- list.files(dir) 
		indexFile <- allFiles[grep(".shx", allFiles)]

		sf <- sf::st_read(file.path(dir, indexFile), quiet=!verbose)
		return(sf)
	}, 
	ns="chronosphere")
