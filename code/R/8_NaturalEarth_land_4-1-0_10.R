#' @param na logical flag to trigger the removal of placeholder values - it also forces the dataset in the memory!

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=TRUE){
        if(! requireNamespace("sf", quietly=TRUE)) stop("This dataset requires the 'sf' package to load.")
	
		if(attach){
			library("sf")
		}

		sf <- sf::st_read(file.path(dir, "ne_10m_land.shx"), quiet=!verbose)
		return(sf)
	}, 
	ns="chronosphere")
