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
				file.path(dir, "SM2_X","shapes_static_polygons_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","shapes_cratons_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","shapes_continents_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","shapes_coastlines_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","250-0_plate_boundaries_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","410-250_plate_boundaries_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","1000-410-Convergence_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","1000-410-Divergence_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","1000-410-Topologies_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","1000-410-Transforms_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","TopologyBuildingBlocks_Merdith_et_al.gpml"),
				file.path(dir, "SM2_X","1000-410_poles.gpml")),
			from=c(1000, 1000, 1000, 400, 250, 410, 1000, 1000, 1000, 1000, 1000, 1000),
			to=c(0, 0, 0, 0, 0, 250, 410, 410, 410, 410, 0, 410 )
		)
		rownames(features) <- c(
			"static_polygons",
			"cratons",
			"continents",
			"coastlines",
			"plate_boundaries_250",
			"plate_boundaries_410",
			"convergence",
			"divergence",
			"topologies",
			"transforms",
			"topology-building-blocks",
			"poles"
		)

		mod <- rgplates::platemodel(
			rotation = file.path(dir,"SM2_X","1000_0_rotfile_Merdith_et_al.rot"),
			features = features
		)
	
		return(mod)
	}, 
	ns="chronosphere"
)
