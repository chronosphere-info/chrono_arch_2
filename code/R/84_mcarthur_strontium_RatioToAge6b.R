#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){

		message("This dataset is an unstable member of the chronosphere\nand is pending approval.")

        if(! requireNamespace("openxlsx", quietly=TRUE)) stop("This dataset requires the 'openxlsx' package to load.")
	
		if(attach){
			library("openxlsx")
		}

		# read in the data
		header <- openxlsx::read.xlsx(file.path(dir, "LOESS6B16032020.xlsx"), sheet=6, startRow=2)
		# transform to matrix, fill in NA
		headMat <- as.matrix(header[1:3,])
		headMat[is.na(headMat)] <- ""

		header <- as.character(apply(headMat, 2, function(x) paste0(x, collapse=" ")))
		header <- trimws(header)
		header[1:3] <- c("System", "Series", "Stage")


		# read in actual data
		dat <- openxlsx::read.xlsx(file.path(dir, "LOESS6B16032020.xlsx"), sheet=6, startRow=6, colNames=FALSE)

		# tidy up
		colnames(dat) <- header
		dat<- dat[,1:12]

		# return
		return(dat)
	}, 
	ns="chronosphere")
