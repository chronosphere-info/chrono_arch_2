#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?
assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE, rotate=FALSE){
        if(! requireNamespace("ncdf4", quietly=TRUE)) stop("This dataset requires the 'ncdf4' package to load.")
        if(! requireNamespace("terra", quietly=TRUE)) stop("This dataset requires the 'terra' package to load.")
        if(! requireNamespace("via", quietly=TRUE)) stop("This dataset requires the 'via' package to load.")
	
		if(attach){
			library("terra")
			library("via")
		}

		# has to rename file, because of the trailing whitespace...
		rename <- file.rename(
			file.path(dir, 'High_Resolution_Climate_Simulation_Dataset_540_Myr.nc '), 
			file.path(dir, 'High_Resolution_Climate_Simulation_Dataset_540_Myr.nc'))

		# the variable
		stack <- terra::rast(file.path(dir, 'High_Resolution_Climate_Simulation_Dataset_540_Myr.nc'))

		# the variable names
		vars <- c("T", "P","SALB","U", "V")
		months <- 0:11
		snapshots <- seq(0, 540, 10)
		names(snapshots) <- (length(snapshots)-1):0

		# the dimensions
		dims <- c(length(snapshots),  length(months), length(vars) )
		
		#the array to reorganize by
		ar <- array(1:prod(dims), dim=dims)

		# get the names to reorder
		ar2 <- ar
		for(i in 1:length(snapshots)){
			for(j in 1:length(months)){
				for(k in 1:length(vars)){
					ar2[i, j, k] <- paste0(vars[k], "_month=",months[j], "_simulation=", names(snapshots)[i])
				}
			}
		}

		
		# the new stack correct order for the monthly data
		newStack <- stack[[as.character(ar2)]]	

		# the names
		dimnames(ar) <- list(age=snapshots, month=months, variable=vars)

		if(rotate)  newStack <- rast::rotate(newStack)

		# the built rasterarray
		ra <- via::RasterArray(stack=newStack, index=ar)

		# return
		return(ra)
	}, 
	ns="chronosphere")
