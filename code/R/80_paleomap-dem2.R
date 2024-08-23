
#' Function to load in a specific variable
#' @param dir path to archive directory
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should the packages on which the dataset depends be attached?
#' @param flipdiff Some files do not follow standards and are read in differently, should these be flipped?
assignInNamespace("loadVar",
	function(dir, verbose=FALSE, attach=TRUE, flipdiff=TRUE){
		if(! requireNamespace("ncdf4", quietly=TRUE)) stop("This dataset requires the 'ncdf4' package to load.")
		if(! requireNamespace("terra", quietly=TRUE)) stop("This dataset requires the 'terra' package to load.")
		if(! requireNamespace("via", quietly=TRUE)) stop("This dataset requires the 'via' package to load.")

		if(attach){
			library("terra")
			library("via")
		}

		all <- c(
			"000_v21144.nc",
			"005_v22032.nc",
			"010_v22030.nc",
			"015_v23219.nc",
			"020_v23219.nc",
			"025_v22032.nc",
			"030_v21046.nc",
			"035_v23219.nc",
			"040_v23219.nc",
			"045_v23219d.nc",
			"050_v23210.nc",
			"055_v23236d.nc",
			"060_v23219.nc",
			"065_v23219.nc",
			"070_v23219.nc",
			"075_v24085.nc",
			"080_v21037c.nc",
			"085_v21037c.nc",
			"090_v23220.nc",
			"095_v23220.nc",
			"100_v24087b.nc",
			"105_v23220.nc",
			"110_v23228d.nc",
			"115_v23220.nc",
			"120_v23220d.nc",
			"125_v23220.nc",
			"130_v23220.nc",
			"135_v23220d.nc",
			"140_v21037c.nc",
			"145_v23220.nc",
			"150_v23220d.nc",
			"155_v23220.nc",
			"160_v23228d.nc",
			"165_v23228d.nc",
			"170_v23228d.nc",
			"175_v23221.nc",
			"180_v23221.nc",
			"185_v21037c.nc",
			"190_v23221.nc",
			"195_v23221.nc",
			"200_v23228d.nc",
			"205_v23229d.nc",
			"210_v23221.nc",
			"215_v21037a.nc",
			"220_v23229d.nc",
			"225_v23221.nc",
			"230_v23230d.nc",
			"235_v21037a.nc",
			"240_v21037b.nc",
			"245_v23230d.nc",
			"250_v23221.nc",
			"255_v23230d.nc",
			"260_v23221.nc",
			"265_v21037b.nc",
			"270_v21037b.nc",
			"275_v21037b.nc",
			"280_v22236d.nc",
			"285_v21037b.nc",
			"290_v23221.nc",
			"295_v21037b.nc",
			"300_v23230d.nc",
			"305_v21037b.nc",
			"310_ARM_v23221.nc",
			"315_v21037a.nc",
			"320_v21037b.nc",
			"325_21037b.nc",
			"330_v23221.nc",
			"335_v23236d.nc",
			"340_v23221.nc",
			"345_21037a.nc",
			"350_v23221.nc",
			"355_v23221.nc",
			"360_v23222.nc",
			"365_v22022.nc",
			"370_v23222.nc",
			"375_v22022.nc",
			"380_v22022.nc",
			"385_v22022.nc",
			"390_v22022.nc",
			"395_v23222.nc",
			"400_v23222.nc",
			"405_v21037a.nc",
			"410_v22022.nc",
			"415_v22022.nc",
			"420_v22236d.nc",
			"425_v23237d.nc",
			"430_v23237d.nc",
			"435_v23237d.nc",
			"440_v23237d.nc",
			"445_v23237d.nc",
			"450_v23237d.nc",
			"455_v23237d.nc",
			"460_v23238d.nc",
			"465_v23237d.nc",
			"470_v23238d.nc",
			"475_v23237d.nc",
			"480_v23237d.nc",
			"485_v23237d.nc",
			"490_v23237d.nc",
			"495_v22023d.nc",
			"500_v21037bd.nc",
			"505_v22024d.nc",
			"510_v22024d.nc",
			"515_v23237d.nc",
			"520_v21037ad.nc",
			"525_v21037bd.nc",
			"530_v21037ad.nc",
			"535_v21037bd.nc",
			"540_v22024d.nc",
			"600_v23238d.nc",
			"630_v23238bd.nc",
			"690_v23238d.nc",
			"750_v23238d.nc")


		# somethign is off with rasters
		# the first
		pa <- terra::rast(paste0(dir,"/", all[1]))


		# target extent
		target <- terra::ext(pa)

		# read them in one-by-one to correct for the extent
		for(i in 2:length(all)){
			# load in one raster
			one <- suppressWarnings(terra::rast(paste0(dir, "/", all[i])))
#			newone <- terra::crop(one, target)
			pa <- c(pa, one)
		}
		names(pa) <- all


		if(flipdiff){
			pa[[16]] <- terra::flip(pa[[16]])
			pa[[21]] <- terra::flip(pa[[21]])
		}

		index <- 1:length(all)
		names(index) <- as.numeric(substr(all, 1,3))

		# the RasterArray
		ra <- via::RasterArray(stack=pa, index=index)

		# return
		return(ra)

	}, ns="chronosphere"
)
