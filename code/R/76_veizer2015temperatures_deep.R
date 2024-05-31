#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){

        if(! requireNamespace("readxl", quietly=TRUE)) stop("This dataset requires the 'readxl' package to load.")
	
		if(attach){
			library("readxl")
			if(verbose) message("Attaching the 'readxl' package")
		}

		# the tabs
		tabs <- c("Atlantic-North", "Atlantic-South", "Pacific", "Southern-North", "Southern-South")

		# read in the data
		allData <- list()

		# column names aggregator
		columns <- NULL
		
		# read in all the data
		for(i in 1:length(tabs)){
			allData[[i]] <- readxl::read_excel(file.path(dir, "1-s2.0-S0012825215000604-mmc1.xls"), sheet=i+1)
			allData[[i]] <- as.data.frame(allData[[i]])

			# column name aggregation
			columns <- unique(c(columns, colnames(allData[[i]])))
		}

		# the merged data
		merged <- data.frame()
		for(i in 1:length(allData)){
			# simplify
			current<- allData[[i]]
			present <- colnames(current)
			# missing
			missing <- columns[!columns%in%present]
			
			# if match is not possible
			# add empty columns
			if(length(missing)>0){
				for(j in 1:length(missing)){
					current[[missing[j]]] <- NA
				}
			}

			# force to same order
			merged <-rbind(merged, current[, columns])

		}

		# return
		return(merged)
	}, 
	ns="chronosphere")
