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
				file.path(dir, "StaticPolygons","shapes_static_polygons_Merdith_etal.gpml"),
				file.path(dir, "Continents","shapes_continents.gpml"),
				file.path(dir, "Coastlines","shapes_coastlines_Merdith_etal.gpmlz"),
				file.path(dir, "Cratons","shapes_cratons_Merdith_etal.gpml"),
				file.path(dir, "COB_Coasts","COB_polygons_and_coastlines_combined_1000_0_Merdith_etal.gpml"),
				file.path(dir, "Topologies","250-0_plate_bounds.gpml"),
				file.path(dir, "Topologies","410-250_plate_bounds.gpml"),
				file.path(dir, "Topologies","1000-410-Convergence.gpml"),
				file.path(dir, "Topologies","1000-410-Divergence.gpml"),
				file.path(dir, "Topologies","1000-410-Transforms.gpml"),
				file.path(dir, "Topologies","1000-410-Topologies.gpml"),
				file.path(dir, "Topologies","TopologyBuildingBlocks.gpml"),
				file.path(dir, "PaleomagneticData","1000-410_poles.gpml")),
			from=c(1000, 1000, 1000, 1000, 1000, 250, 410, 1000, 1000, 1000, 1000, 1000, 1000),
			to=c(0, 0, 0, 0, 0, 0, 250, 410, 410, 410, 410, 0, 0)
		)
		rownames(features) <- c(
			"static_polygons",
			"continents",
			"coastlines",
			"cratons",
			"COB-coasts",
			"plate_boundaries_250",
			"plate_boundaries_410",
			"convergence-zones_1000",
			"divergence-zones_1000",
			"transform-zones_1000",
			"topologies_1000",
			"topology-building-blocks",
			"paleomagnetic-poles"
		)

		mod <- rgplates::platemodel(
			rotation = file.path(dir,"optimisation/1000_0_rotfile_MantleOpt.rot"),
			features = features
		)

		if(verbose) message("Note that not all feature collections can be reconstructed yet. ")

		return(mod)
	}, 
	ns="chronosphere"
)


