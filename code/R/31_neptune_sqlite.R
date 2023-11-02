#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){

        if(! requireNamespace("RSQLite", quietly=TRUE)) stop("This dataset requires the 'RSQLite' package to load.")
        if(! requireNamespace("DBI", quietly=TRUE)) stop("This dataset requires the 'DBI' package to load.")
	
	
		if(attach){
			library("RSQLite")
			library("DBI")
		}

		# read in the data
		con <- DBI::dbConnect(RSQLite::SQLite(), file.path(dir, "nsb.sqlite"))

		# return
		return(con)
	}, 
	ns="chronosphere")
