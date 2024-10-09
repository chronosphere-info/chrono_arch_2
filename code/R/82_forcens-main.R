#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){

		# read in the data
		rawRead <- readLines(file.path(dir,"ForCenS.txt"))
		header <- unlist(strsplit(rawRead[1], "\t"))
		attributes <- unlist(strsplit(rawRead[2], "\t"))

		# if there is nothing meaningful there
		attributes[attributes=="[]"] <-""

		# new header
		newHead <- trimws(paste(header, attributes))

		if(verbose){
			message(
				paste0(
					"HINT: you can use:\n\n",
					"  gsub(\" \\\\[.*$\", \"\", colnames(<objectname>))\n\n",
					"to remove header attribues in square brackets. ")
			)
		}

		# read in actual data
		dat <- read.delim(file.path(dir,"ForCenS.txt"), skip=2, header=FALSE, na.strings="N/A")
		colnames(dat) <- newHead

		# return
		return(dat)
	}, 
	ns="chronosphere")
