#' Function to load in a specific variable
#' @param dir path to archive directory
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should the packages on which the dataset depends be attached? 
#' @param resample The original file is a grid registered raster, making its extent beyond the nominal margins. 
#'' Setting this to TRUE will trigger a resampling to standard cell registration with method. 
#' @param method The resampling method passed to terra::resample()
assignInNamespace("loadVar", 
	function(dir, verbose=FALSE, attach=TRUE, resample=TRUE, method="bilinear"){
		if(! requireNamespace("ncdf4", quietly=TRUE)) stop("This dataset requires the 'ncdf4' package to load.")
		if(! requireNamespace("terra", quietly=TRUE)) stop("This dataset requires the 'terra' package to load.")
		if(! requireNamespace("via", quietly=TRUE)) stop("This dataset requires the 'via' package to load.")
	
		if(attach){
			library("terra")
			library("via")
		}

		all <- c(
			"000Ma_precip.nc",
			"005Ma_precip.nc",
			"010Ma_precip.nc",
			"015Ma_precip.nc",
			"020Ma_precip.nc",
			"025Ma_precip.nc",
			"030Ma_precip.nc",
			"035Ma_precip.nc",
			"040Ma_precip.nc",
			"045Ma_precip.nc",
			"050Ma_precip.nc",
			"055Ma_precip.nc",
			"060Ma_precip.nc",
			"065Ma_precip.nc",
			"070Ma_precip.nc",
			"075Ma_precip.nc",
			"080Ma_precip.nc",
			"085Ma_precip.nc",
			"090Ma_precip.nc",
			"095Ma_precip.nc",
			"100Ma_precip.nc",
			"105Ma_precip.nc",
			"110Ma_precip.nc",
			"115Ma_precip.nc",
			"120Ma_precip.nc",
			"125Ma_precip.nc",
			"130Ma_precip.nc",
			"135Ma_precip.nc",
			"140Ma_precip.nc",
			"145Ma_precip.nc",
			"150Ma_precip.nc",
			"155Ma_precip.nc",
			"160Ma_precip.nc",
			"165Ma_precip.nc",
			"170Ma_precip.nc",
			"175Ma_precip.nc",
			"180Ma_precip.nc",
			"185Ma_precip.nc",
			"190Ma_precip.nc",
			"195Ma_precip.nc",
			"200Ma_precip.nc",
			"205Ma_precip.nc",
			"210Ma_precip.nc",
			"215Ma_precip.nc",
			"220Ma_precip.nc",
			"225Ma_precip.nc",
			"230Ma_precip.nc",
			"235Ma_precip.nc",
			"240Ma_precip.nc",
			"245Ma_precip.nc",
			"250Ma_precip.nc",
			"255Ma_precip.nc",
			"260Ma_precip.nc",
			"265Ma_precip.nc",
			"270Ma_precip.nc",
			"275Ma_precip.nc",
			"280Ma_precip.nc",
			"285Ma_precip.nc",
			"290Ma_precip.nc",
			"295Ma_precip.nc",
			"300Ma_precip.nc",
			"305Ma_precip.nc",
			"310Ma_precip.nc",
			"315Ma_precip.nc",
			"320Ma_precip.nc",
			"325Ma_precip.nc",
			"330Ma_precip.nc",
			"335Ma_precip.nc",
			"340Ma_precip.nc",
			"345Ma_precip.nc",
			"350Ma_precip.nc",
			"355Ma_precip.nc",
			"360Ma_precip.nc",
			"365Ma_precip.nc",
			"370Ma_precip.nc",
			"375Ma_precip.nc",
			"380Ma_precip.nc",
			"385Ma_precip.nc",
			"390Ma_precip.nc",
			"395Ma_precip.nc",
			"400Ma_precip.nc",
			"405Ma_precip.nc",
			"410Ma_precip.nc",
			"415Ma_precip.nc",
			"420Ma_precip.nc",
			"425Ma_precip.nc",
			"430Ma_precip.nc",
			"435Ma_precip.nc",
			"440Ma_precip.nc",
			"445Ma_precip.nc",
			"450Ma_precip.nc",
			"455Ma_precip.nc",
			"460Ma_precip.nc",
			"465Ma_precip.nc",
			"470Ma_precip.nc",
			"475Ma_precip.nc",
			"480Ma_precip.nc",
			"485Ma_precip.nc",
			"490Ma_precip.nc",
			"495Ma_precip.nc",
			"500Ma_precip.nc",
			"505Ma_precip.nc",
			"510Ma_precip.nc",
			"515Ma_precip.nc",
			"520Ma_precip.nc",
			"525Ma_precip.nc",
			"530Ma_precip.nc",
			"535Ma_precip.nc",
			"540Ma_precip.nc")


		# the first
		pa <- terra::rast(paste0(dir,"/", all[1]))

		# target extent
		target <- terra::ext(pa)

		# read them in one-by-one to correct for the extent
		for(i in 2:length(all)){
			# load in one raster
			one <- suppressWarnings(terra::rast(paste0(dir, "/", all[i])))
			newone <- terra::crop(one, target)
			pa <- c(pa, newone)
		}
		names(pa) <- all

        if(resample){
            if(verbose) message("\n\nResampling grid to cell-registration.\nSet 'resample=FALSE' to skip and use original structure.\n\n")
            empty <- terra::rast()
            pa <- terra::resample(pa, empty, method=method)
        }


		index <- 1:length(all)
		names(index) <- as.numeric(gsub("Ma_precip.nc", "", all))

		# the RasterArray
		ra <- via::RasterArray(stack=pa, index=index)

		# return
		return(ra)

	}, ns="chronosphere"
)
