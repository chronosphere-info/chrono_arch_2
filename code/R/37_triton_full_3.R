#' Function to load in a specific variable

#' @param dir path to temporary directory.
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should feedback be output to the console?

assignInNamespace(
	"loadVar", 
	function(dir, verbose=FALSE, attach=FALSE){
		# read in the data
		thisEnv <- environment()
		# load and input
		load(file.path(dir, "triton_update_2023.RData"), envir=thisEnv)

		# return
		return(triton)
	}, 
	ns="chronosphere")
