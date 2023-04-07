#' Function to load in a specific variable
#' @param dir path to archive directory
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should the packages on which the dataset depends be attached? 
#' 
assignInNamespace("loadVar", 
	function(dir, verbose=FALSE, attach=TRUE){
        if(! requireNamespace("ncdf4", quietly=TRUE)) stop("This dataset requires the 'ncdf4' package to load.")
        if(! requireNamespace("terra", quietly=TRUE)) stop("This dataset requires the 'terra' package to load.")
        if(! requireNamespace("via", quietly=TRUE)) stop("This dataset requires the 'via' package to load.")
	
		if(attach){
			library("terra")
			library("via")
		}

		# read all files in temporary directory - it is more robust to do it explicitly than tinkering 
		files<- c(
			"sst_inter_1deg_0.nc",
			"sst_inter_1deg_5.nc",
			"sst_inter_1deg_10.nc",
			"sst_inter_1deg_15.nc",
			"sst_inter_1deg_20.nc",
			"sst_inter_1deg_25.nc",
			"sst_inter_1deg_30.nc",
			"sst_inter_1deg_35.nc",
			"sst_inter_1deg_40.nc",
			"sst_inter_1deg_45.nc",
			"sst_inter_1deg_50.nc",
			"sst_inter_1deg_60.nc",
			"sst_inter_1deg_65.nc",
			"sst_inter_1deg_70.nc",
			"sst_inter_1deg_80.nc",
			"sst_inter_1deg_85.nc",
			"sst_inter_1deg_90.nc",
			"sst_inter_1deg_95.nc",
			"sst_inter_1deg_105.nc",
			"sst_inter_1deg_120.nc",
			"sst_inter_1deg_125.nc",
			"sst_inter_1deg_130.nc",
			"sst_inter_1deg_135.nc",
			"sst_inter_1deg_140.nc",
			"sst_inter_1deg_150.nc",
			"sst_inter_1deg_155.nc",
			"sst_inter_1deg_160.nc",
			"sst_inter_1deg_165.nc",
			"sst_inter_1deg_170.nc",
			"sst_inter_1deg_180.nc",
			"sst_inter_1deg_185.nc",
			"sst_inter_1deg_195.nc",
			"sst_inter_1deg_200.nc",
			"sst_inter_1deg_205.nc",
			"sst_inter_1deg_220.nc",
			"sst_inter_1deg_230.nc",
			"sst_inter_1deg_240.nc",
			"sst_inter_1deg_245.nc",
			"sst_inter_1deg_250.nc",
			"sst_inter_1deg_255.nc",
			"sst_inter_1deg_260.nc",
			"sst_inter_1deg_265.nc",
			"sst_inter_1deg_270.nc",
			"sst_inter_1deg_275.nc",
			"sst_inter_1deg_285.nc",
			"sst_inter_1deg_295.nc",
			"sst_inter_1deg_300.nc",
			"sst_inter_1deg_305.nc",
			"sst_inter_1deg_310.nc",
			"sst_inter_1deg_320.nc",
			"sst_inter_1deg_325.nc",
			"sst_inter_1deg_340.nc",
			"sst_inter_1deg_355.nc",
			"sst_inter_1deg_365.nc",
			"sst_inter_1deg_375.nc",
			"sst_inter_1deg_385.nc",
			"sst_inter_1deg_390.nc",
			"sst_inter_1deg_400.nc",
			"sst_inter_1deg_410.nc",
			"sst_inter_1deg_415.nc",
			"sst_inter_1deg_420.nc",
			"sst_inter_1deg_425.nc",
			"sst_inter_1deg_430.nc",
			"sst_inter_1deg_435.nc",
			"sst_inter_1deg_440.nc",
			"sst_inter_1deg_445.nc",
			"sst_inter_1deg_450.nc",
			"sst_inter_1deg_455.nc",
			"sst_inter_1deg_465.nc",
			"sst_inter_1deg_470.nc",
			"sst_inter_1deg_475.nc",
			"sst_inter_1deg_480.nc",
			"sst_inter_1deg_485.nc",
			"sst_inter_1deg_490.nc",
			"sst_inter_1deg_495.nc",
			"sst_inter_1deg_500.nc",
			"sst_inter_1deg_505.nc",
			"sst_inter_1deg_510.nc",
			"sst_inter_1deg_515.nc",
			"sst_inter_1deg_525.nc",
			"sst_inter_1deg_535.nc"
		)
		all <- file.path("sst_inter_1deg", files)
		
		# for the names of the files
		ageExt <- unlist(lapply(strsplit(all, "_"), function(x) x[6]))
		ageNum <- as.numeric(unlist(lapply(strsplit(ageExt, "\\."), function(x) x[1])))

		# resolution names have to be here, otherwise they will be overwritten here and the links to the 
		# to make a stack in memory, make a list first
		listForm <- list()

		# netCDF files (raster data - two dimensions)
		for(i in 1:length(all)){
			one <- terra::rast(file.path(dir, all[i]))
			names(one) <- files[i]
			terra::varnames(one) <- "sst"
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
