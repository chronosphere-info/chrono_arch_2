
#' Function to load in a specific variable
#' @param dir path to archive directory
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should the packages on which the dataset depends be attached?
#' @param resample The original file is a grid registered raster, making its extent beyond the nominal margins.
#'' Setting this to TRUE will trigger a resampling to standard cell registration with method.
#' @param method The resampling method passed to terra::resample()
assignInNamespace("loadVar",
	function(dir, verbose=FALSE, attach=TRUE, resample=TRUE, method="bilinear"){
		if(! requireNamespace("terra", quietly=TRUE)) stop("This dataset requires the 'terra' package to load.")
		if(! requireNamespace("via", quietly=TRUE)) stop("This dataset requires the 'via' package to load.")

		if(attach){
			library("terra")
			library("via")
		}

		all <- c(
			"000_v21144d_361.csv",
			"005_v22032d_361.csv",
			"010_v22030d_361.csv",
			"015_v23219d_361.csv",
			"020_v23219d_361.csv",
			"025_v22032d_361.csv",
			"030_v21046d_361.csv",
			"035_v23219d_361.csv",
			"040_v23219d_361.csv",
			"045_v23219d_361.csv",
			"050_v23210d_361.csv",
			"055_v23236d_361.csv",
			"060_v23219d_361.csv",
			"065_v23219d_361.csv",
			"070_v23219d_361.csv",
#			"075_v23219d_361.csv",
			"075_v24210_361.csv",
			"080_v21037cd_361.csv",
			"085_v21037cd_361.csv",
			"090_v23220d_361.csv",
			"095_v23220d_361.csv",
#			"100_v21037ad_361.csv",
			"100_v24210_361.csv",
			"105_v23220d_361.csv",
			"110_v23228d_361.csv",
			"115_v23220d_361.csv",
			"120_v23220d_361.csv",
			"125_v23220d_361.csv",
			"130_v23220d_361.csv",
			"135_v23220d_361.csv",
			"140_v21037cd_361.csv",
			"145_v23220d_361.csv",
			"150_v23220d_361.csv",
			"155_v23220D_361.csv",
			"160_v23228d_361.csv",
			"165_v23228d_361.csv",
			"170_v23228d_361.csv",
			"175_v23221d_361.csv",
			"180_v23221d_361.csv",
			"185_v21037cd_361.csv",
			"190_v23221d_361.csv",
			"195_v23221d_361.csv",
			"200_v23228d_361.csv",
			"205_v23229d_361.csv",
			"210_v23221d_361.csv",
			"215_v21037ad_361.csv",
			"220_v23229d_361.csv",
			"225_v23221d_361.csv",
			"230_v23230d_361.csv",
			"235_v21037ad_361.csv",
			"240_v21037bd_361.csv",
			"245_v23230d_361.csv",
			"250_v23221d_361.csv",
			"255_v23230d_361.csv",
			"260_v23221d_361.csv",
			"265_v21037bd_361.csv",
			"270_v21037bd_361.csv",
			"275_v21037bd_361.csv",
			"280_v22236d_361.csv",
			"285_v21037bd_361.csv",
			"290_v23221d_361.csv",
			"295_v21037bd_361.csv",
			"300_v23230d_361.csv",
			"305_v21037bd_361.csv",
			"310_ARM_v23221d_361.csv",
			"315_v21037ad_361.csv",
			"320_v21037bd_361.csv",
			"325_21037bd_361.csv",
			"330_v23221_361.csv",
			"335_v23236d_361.csv",
			"340_v23221d_361.csv",
			"345_21037a_361.csv",
			"350_v23221_361.csv",
			"355_v23221_361.csv",
			"360_v23222_361.csv",
			"365_v22022_361.csv",
			"370_v23222_361.csv",
			"375_v22022_361.csv",
			"380_v22022_361.csv",
			"385_v22022_361.csv",
			"390_v22022_361.csv",
			"395_v23222_361.csv",
			"400_v23222d_361.csv",
			"405_v21037ad_361.csv",
			"410_v22022d_361.csv",
			"415_v22022d_361.csv",
			"420_v22236d_361.csv",
			"425_v23237d_361.csv",
			"430_v23237d_361.csv",
			"435_v23237d_361.csv",
			"440_v23237d_361.csv",
			"445_v23237d_361.csv",
			"450_v23237d_361.csv",
			"455_v23237d_361.csv",
			"460_v23238d_361.csv",
			"465_v23237d_361.csv",
			"470_v23238d_361.csv",
			"475_v23237d_361.csv",
			"480_v23237d_361.csv",
			"485_v23237d_361.csv",
			"490_v23237d_361.csv",
			"495_v22023d_361.csv",
			"500_v21037bd_361.csv",
			"505_v22024d_361.csv",
			"510_v22024d_361.csv",
			"515_v23237d_361.csv",
			"520_v21037ad_361.csv",
			"525_v21037bd_361.csv",
			"530_v21037ad_361.csv",
			"535_v21037bd_361.csv",
			"540_v22024d_361.csv",
			"600_v23238d_361.csv",
			"630v23238bd_361.csv",
			"690_v23238d_361.csv",
			"750_v23238d_361.csv")


		# template for the extent
		template <- terra::ext(-180.5, 180.5, -90.5, 90.5)

		# declare
		pa <- NULL
		for(i in 1:length(all)){
			# a matrix of values
			one <- as.matrix(read.csv(file.path(dir,all[i]), header=FALSE))
			# make it a raster
			oneRast <- terra::rast(one)

			# force extent and crs
			terra::ext(oneRast) <- template
			terra::crs(oneRast) <- "WGS84"

			if(i==1){
				pa <- oneRast

			}else{
				pa <- c(pa, oneRast)
			}
		}


		# names of the individual layers
		names(pa) <- gsub("_361.csv", "", all)

        if(resample){
            if(verbose) message("\n\nResampling grid to cell-registration.\nSet 'resample=FALSE' to skip and use original structure.\n\n")
            empty <- terra::rast()
            pa <- terra::resample(pa, empty, method=method)
        }

		# index
		index <- 1:length(all)
		names(index) <- as.numeric(substr(all, 1,3))

		# the RasterArray
		ra <- via::RasterArray(stack=pa, index=index)

		# return
		return(ra)

	}, ns="chronosphere"
)
