#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){

        if(! requireNamespace("openxlsx", quietly=TRUE)) stop("This dataset requires the 'openxlsx' package to load.")
	
		if(attach){
			library("openxlsx")
		}

		# read in the data
		dat <- openxlsx::read.xlsx(file.path(dir, "Part 4. Phanerozoic_Paleotemperature_Summaryv4.xlsx"), sheet=1, startRow=2)

		colnames(dat)[1] <- "Age"
		colnames(dat)[2] <- "ChronoTemp Number"
		colnames(dat)[3] <- "ChronoTemp Name"
		colnames(dat)[4] <- "ChronoTemp Abbrev."
		colnames(dat)[6] <- "Northern Hemisphere"
		colnames(dat)[7] <- "Southern Hemisphere"
		colnames(dat)[8] <- paste("Average", colnames(dat)[8])
		colnames(dat)[13] <- paste("North", colnames(dat)[13])
		colnames(dat)[14] <- paste("South", colnames(dat)[14])
		colnames(dat)[15] <- paste("Average", colnames(dat)[15])

		# omit the last bit
		dat<- dat[1:(nrow(dat)-1),]

		# return
		return(dat)
	}, 
	ns="chronosphere")
