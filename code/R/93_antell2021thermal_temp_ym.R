#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?
assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){
        if(! requireNamespace("ncdf4", quietly=TRUE)) stop("This dataset requires the 'ncdf4' package to load.")
        if(! requireNamespace("terra", quietly=TRUE)) stop("This dataset requires the 'terra' package to load.")
        if(! requireNamespace("via", quietly=TRUE)) stop("This dataset requires the 'via' package to load.")
	
		# dir <- "/home/adam/Desktop/chron/"

		if(attach){
			library("terra")
			library("via")
		}
		# list model files
		files <- list.files("Data/gcm_annual_mean")

		# get associated ages
		ages <- as.numeric(sapply(strsplit(files, "_"), function(x) x[2]))

		# order
		correct <- files[order(ages)]
		ages <- sort(ages)

		# loop through all
		for(i in 1:length(correct)){
			# the current raster
			current <- terra::rast(paste0("Data/gcm_annual_mean/", correct[i]))

			# add it to the rest
			if(i == 1){
				stack <- current
			}else{
				stack <- c(stack, current)
			}
		}

		# depths - inferred from an independent download from http://www.paleo.bristol.ac.uk/ummodel/data/teiUF/climate/teiUFo.pgclann.nc
		# NOTE the bottom layer is missing!
		depths <- c(5.00, 15.00, 25.00, 35.10, 47.85, 67.00, 95.75, 138.90, 203.70, 301.00, 447.05, 666.30, 995.55, 1500.85, 2116.15, 2731.40, 3346.65, 3961.90, 4577.15)

		# creat an index for the rasterarray
		layers <- dim(stack)[3]
		index <- 1:layers
		dim(index) <- c(layers/length(correct), length(correct))
		dimnames(index) <- list(
			depth_m=depths,
			age_ka=ages
		)

		ra <- via::RasterArray(stack=stack, index=index)

		# return
		return(ra)
	}, 
	ns="chronosphere")
