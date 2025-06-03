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

		# based on a data.frame
		features<-data.frame(
			feature_collection=c(
				file.path(dir, "SupplementaryMaterial/1_Phanerozoic_Plate_Motions_GPlates","Phanerozoic_EarthByte_ContinentalRegions.gpml"),
				file.path(dir, "SupplementaryMaterial/1_Phanerozoic_Plate_Motions_GPlates","Phanerozoic_EarthByte_Coastlines.gpml")),
			from=c(550),
			to=c(0)
		)
		rownames(features) <- c(
			"static_polygons",
			"coastlines"
		)

		mod <- rgplates::platemodel(
			rotation = file.path(dir, "SupplementaryMaterial/1_Phanerozoic_Plate_Motions_GPlates","Phanerozoic_EarthByte.rot"),
			features = features
		)

		return(mod)
	}, 
	ns="chronosphere"
)

