assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=TRUE){
        if(! requireNamespace("sf", quietly=TRUE)) stop("This dataset requires the 'sf' package to load.")
	
		if(attach){
			library("sf")
		}

		sf <- sf::st_read(file.path(dir, "hotspots_2016_1.shx"), quiet=!verbose)

		# limit to hotspot areas
		ha <- sf[sf$Type=="hotspot area", ]

		return(ha)
	}, 
	ns="chronosphere")
