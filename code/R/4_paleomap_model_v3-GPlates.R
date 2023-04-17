#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach Should the required package be attached before the item is loaded? 

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){
		if(!requireNamespace("rgplates", quietly=TRUE)){
			stop("This item requires the rgplates package to run.")
		}
		if(attach){
			if(verbose) message("Attaching package 'rgplates'.")
			library(rgplates)
		}
	
		# read in the raster
		mod <- rgplates::platemodel(
			rotation = file.path(dir, "PALEOMAP_PlateModel.rot"),
			polygons = file.path(dir, "PALEOMAP_PlatePolygons.gpml")
		)
	
		return(mod)
	}, 
	ns="chronosphere"
)
