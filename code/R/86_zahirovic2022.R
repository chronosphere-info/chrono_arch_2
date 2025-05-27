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
				file.path(dir, "PlateMotionModel_and_GeometryFiles/Zahirovic_etal_2022_GDJ/StaticGeometries/StaticPolygons","Global_EarthByte_GPlates_PresentDay_StaticPlatePolygons.shp"),
				file.path(dir, "PlateMotionModel_and_GeometryFiles/Zahirovic_etal_2022_GDJ/StaticGeometries/Coastlines","Global_coastlines_low_res.shp"),
				file.path(dir, "PlateMotionModel_and_GeometryFiles/Zahirovic_etal_2022_GDJ/StaticGeometries/ContinentalPolygons","Global_EarthByte_GPlates_PresentDay_ContinentalPolygons.shp")),
				#file.path(dir, "PlateMotionModel_and_GeometryFiles/Zahirovic_etal_2022_GDJ","Feature_Geometries.gpml")),
				#file.path(dir, "PlateMotionModel_and_GeometryFiles/Zahirovic_etal_2022_GDJ/StaticGeometries/SeafloorFabric","FractureZones.gpmlz")),
			from=c(410, 410, 410),
			to=c(0, 0,0)
		)
		rownames(features) <- c(
			"static_polygons",
			"coastlines",
			"continents"

		)

		mod <- rgplates::platemodel(
			rotation = file.path(dir, "PlateMotionModel_and_GeometryFiles/Zahirovic_etal_2022_GDJ","CombinedRotations.rot"),
			features = features
		)


		return(mod)
	}, 
	ns="chronosphere"
)

