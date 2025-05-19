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
				file.path(dir, "1.8Ga_model_GSF","static_polygons.gpmlz"),
				file.path(dir, "1.8Ga_model_GSF","shapes_continents.gpmlz"),
				file.path(dir, "1.8Ga_model_GSF","shapes_coasts.gpmlz"),
				file.path(dir, "1.8Ga_model_GSF","250-0_plate_boundaries.gpml"),
				file.path(dir, "1.8Ga_model_GSF","410-250_plate_boundaries.gpml"),
				file.path(dir, "1.8Ga_model_GSF","1000-410_plate_boundaries.gpml"),
				file.path(dir, "1.8Ga_model_GSF","1800-1000_plate_boundaries.gpml"),
				file.path(dir, "1.8Ga_model_GSF","TopologyBuildingBlocks.gpml"),
				file.path(dir, "1.8Ga_model_GSF","Paleomagnetic_poles.gpml")),
			from=c(1800, 1800, 1800, 250, 410, 1000, 1800, 1800, 1800),
			to=c(0, 0, 0, 0, 250, 410, 1000, 0, 0)
		)
		rownames(features) <- c(
			"static_polygons",
			"continents",
			"coastlines",
			"plate_boundaries_250",
			"plate_boundaries_410",
			"plate_boundaries_1000",
			"plate_boundaries_1800",
			"topology-building-blocks",
			"paleomagnetic-poles"
		)

		mod <- rgplates::platemodel(
			rotation = file.path(dir,"1.8Ga_model_GSF",c("1800_1000_rotfile.rot", "1000_0_rotfile.rot")),
			features = features
		)

		if(verbose) message("Note that not all feature collections can be reconstructed yet. ")

		return(mod)
	}, 
	ns="chronosphere"
)

