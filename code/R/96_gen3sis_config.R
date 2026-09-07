#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){

        if(! requireNamespace("gen3sis2", quietly=TRUE)) stop("This dataset requires the 'gen3sis2' package to load.")
	
		if(attach){
			library("gen3sis2")
		}

		# read in the data
		theFiles<- list.files(dir)
		configFile<- theFiles[grep("config", theFiles)]
		config <- gen3sis2::create_input_config(file.path(dir, configFile))

		# return
		return(config)
	}, 
	ns="chronosphere")
