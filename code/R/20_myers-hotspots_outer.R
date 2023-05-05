#' @param validate logical flag indicating whether sf::st_make_valid should be run on the output (default to TRUE)

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=TRUE, validate=TRUE){
        if(! requireNamespace("sf", quietly=TRUE)) stop("This dataset requires the 'sf' package to load.")
	
		if(attach){
			library("sf")
		}

		sf <- sf::st_read(file.path(dir, "hotspots_2016_1.shx"), quiet=!verbose)
		sfOuter <- sf[sf$Type=="outer limit", ]

		if(validate & verbose) {
			message("Running sf::st_make_valid(), use 'validate=FALSE' to skip.")
			sfOuter <- sf::st_make_valid(sfOuter)
		} 
		return(sfOuter)
	}, 
	ns="chronosphere")
