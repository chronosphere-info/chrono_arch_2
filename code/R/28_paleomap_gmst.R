#' Function to load in a specific variable
#' @param dir path to archive directory
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should the packages on which the dataset depends be attached? 
#' @param rmrange The first two values of the rasters include placeholders for the range of values. Should these be removed?
#
assignInNamespace("loadVar", 
	function(dir, verbose=FALSE, attach=TRUE, rmrange=TRUE){
        if(! requireNamespace("ncdf4", quietly=TRUE)) stop("This dataset requires the 'ncdf4' package to load.")
        if(! requireNamespace("terra", quietly=TRUE)) stop("This dataset requires the 'terra' package to load.")
        if(! requireNamespace("via", quietly=TRUE)) stop("This dataset requires the 'via' package to load.")
	
	
		if(attach){
			library("terra")
			library("via")
		}

		# read all files in temporary directory - it is more robust to do it explicitly than tinkering 
		files<- c(
			"000_tas_scotese02a_v21321.nc",
			"005_tas_scotese02a_v21321.nc",
			"010_tas_scotese02a_v21321.nc",
			"015_tas_scotese02a_v21321.nc",
			"020_tas_scotese02a_v21321.nc",
			"025_tas_scotese02a_v21321.nc",
			"030_tas_scotese02a_v21321.nc",
			"035_tas_scotese02a_v21321.nc",
			"040_tas_scotese02a_v21321.nc",
			"045_tas_scotese02a_v21321.nc",
			"050_tas_scotese02a_v21321.nc",
			"055_tas_scotese02a_v21321.nc",
			"060_tas_scotese02a_v21321.nc",
			"065_tas_scotese02a_v21321.nc",
			"070_tas_scotese02a_v21321.nc",
			"075_tas_scotese02a_v21321.nc",
			"080_tas_scotese02a_v21321.nc",
			"085_tas_scotese02a_v21321.nc",
			"090_tas_scotese02a_v21321.nc",
			"095_tas_scotese02a_v21321.nc",
			"100_tas_scotese02a_v21321.nc",
			"105_tas_scotese02a_v21321.nc",
			"110_tas_scotese02a_v21321.nc",
			"115_tas_scotese02a_v21321.nc",
			"120_tas_scotese02a_v21321.nc",
			"125_tas_scotese02a_v21321.nc",
			"130_tas_scotese02a_v21321.nc",
			"135_tas_scotese02a_v21321.nc",
			"140_tas_scotese02a_v21321.nc",
			"145_tas_scotese02a_v21321.nc",
			"150_tas_scotese02a_v21321.nc",
			"155_tas_scotese02a_v21321.nc",
			"160_tas_scotese02a_v21321.nc",
			"165_tas_scotese02a_v21321.nc",
			"170_tas_scotese02a_v21321.nc",
			"175_tas_scotese02a_v21321.nc",
			"180_tas_scotese02a_v21321.nc",
			"185_tas_scotese02a_v21321.nc",
			"190_tas_scotese02a_v21321.nc",
			"195_tas_scotese02a_v21321.nc",
			"200_tas_scotese02a_v21321.nc",
			"205_tas_scotese02a_v21321.nc",
			"210_tas_scotese02a_v21321.nc",
			"215_tas_scotese02a_v21321.nc",
			"220_tas_scotese02a_v21321.nc",
			"225_tas_scotese02a_v21321.nc",
			"230_tas_scotese02a_v21321.nc",
			"235_tas_scotese02a_v21321.nc",
			"240_tas_scotese02a_v21321.nc",
			"245_tas_scotese02a_v21321.nc",
			"250_tas_scotese02a_v21321.nc",
			"255_tas_scotese02a_v21321.nc",
			"260_tas_scotese02a_v21321.nc",
			"265_tas_scotese02a_v21321.nc",
			"270_tas_scotese02a_v21321.nc",
			"275_tas_scotese02a_v21321.nc",
			"280_tas_scotese02a_v21321.nc",
			"285_tas_scotese02a_v21321.nc",
			"290_tas_scotese02a_v21321.nc",
			"295_tas_scotese02a_v21321.nc",
			"300_tas_scotese02a_v21321.nc",
			"305_tas_scotese02a_v21321.nc",
			"310_tas_scotese02a_v21321.nc",
			"315_tas_scotese02a_v21321.nc",
			"320_tas_scotese02a_v21321.nc",
			"325_tas_scotese02a_v21321.nc",
			"330_tas_scotese02a_v21321.nc",
			"335_tas_scotese02a_v21321.nc",
			"340_tas_scotese02a_v21321.nc",
			"345_tas_scotese02a_v21321.nc",
			"350_tas_scotese02a_v21321.nc",
			"355_tas_scotese02a_v21321.nc",
			"360_tas_scotese02a_v21321.nc",
			"365_tas_scotese02a_v21321.nc",
			"370_tas_scotese02a_v21321.nc",
			"375_tas_scotese02a_v21321.nc",
			"380_tas_scotese02a_v21321.nc",
			"385_tas_scotese02a_v21321.nc",
			"390_tas_scotese02a_v21321.nc",
			"395_tas_scotese02a_v21321.nc",
			"400_tas_scotese02a_v21321.nc",
			"405_tas_scotese02a_v21321.nc",
			"410_tas_scotese02a_v21321.nc",
			"415_tas_scotese02a_v21321.nc",
			"420_tas_scotese02a_v21321.nc",
			"425_tas_scotese02a_v21321.nc",
			"430_tas_scotese02a_v21321.nc",
			"435_tas_scotese02a_v21321.nc",
			"440_tas_scotese02a_v21321.nc",
			"445_tas_scotese02a_v21321.nc",
			"450_tas_scotese02a_v21321.nc",
			"460_tas_scotese02a_v21321.nc",
			"470_tas_scotese02a_v21321.nc",
			"480_tas_scotese02a_v21321.nc",
			"490_tas_scotese02a_v21321.nc",
			"500_tas_scotese02a_v21321.nc",
			"510_tas_scotese02a_v21321.nc",
			"520_tas_scotese02a_v21321.nc",
			"530_tas_scotese02a_v21321.nc",
			"540_tas_scotese02a_v21321.nc"
		)
		all <- file.path(files)
		
		# for the names of the files
		ageExt <- unlist(lapply(strsplit(files, "_"), function(x) x[1]))
		ageNum <- floor(as.numeric(ageExt))

		# the loop through all 
		for(i in 1:length(all)){
			
			suppressWarnings(one <- terra::rast(file.path(dir, all[i])))
			
			if(!all(suppressWarnings(terra::values(one))[1:2]==c(50, -55))) suppressWarnings(one <- terra::flip(one))
			
			names(one) <- files[i]
			terra::varnames(one) <- "tas"
			if(rmrange) suppressWarnings(terra::values(one)[1:2] <- NA)
			if(i == 1){
				stack <- one
			}else{
				stack <- c(stack, one)
			}
		}

		# make a RasterArray
		ind <- 1:length(all)
		names(ind) <-  as.character(ageNum)
	
		# RasterArray
		via::RasterArray(stack=stack, index=ind)


	}, ns="chronosphere"
)
