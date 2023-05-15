#' Function to load in a specific variable
#' @param dir path to archive directory
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should the packages on which the dataset depends be attached? 
#' 
assignInNamespace("loadVar", 
	function(dir, verbose=FALSE, attach=TRUE){
        if(! requireNamespace("sf", quietly=TRUE)) stop("This dataset requires the 'sf' package to load.")
        if(! requireNamespace("via", quietly=TRUE)) stop("This dataset requires the 'via' package to load.")
	
	
		if(attach){
			library("sf")
			library("via")
		}

		# read all files in temporary directory - it is more robust to do it explicitly than tinkering 
		ages <- c(
			0,
			5,
			10,
			15,
			20,
			25,
			30,
			35,
			40,
			45,
			50,
			60,
			65,
			70,
			80,
			85,
			90,
			95,
			105,
			120,
			125,
			130,
			135,
			140,
			150,
			155,
			160,
			165,
			170,
			180,
			185,
			195,
			200,
			205,
			220,
			230,
			240,
			245,
			250,
			255,
			260,
			265,
			270,
			275,
			285,
			295,
			300,
			305,
			310,
			320,
			325,
			340,
			355,
			365,
			375,
			385,
			390,
			400,
			410,
			415,
			420,
			425,
			430,
			435,
			440,
			445,
			450,
			455,
			465,
			470,
			475,
			480,
			485,
			490,
			495,
			500,
			505,
			510,
			515,
			525,
			535
		)
		# 
		cs <- paste0(ages, "Ma_CS_v7.shx")
		cm <- paste0(ages, "Ma_CM_v7.shx")

		# actual paths
		csPath <- file.path("CS", cs)
		cmPath <- file.path("CM", cm)
		all <- c(cmPath, csPath)

		# look through all of these...
		listForm <- list()
		for(i in 1:length(all)){
			listForm[[i]] <- sf::st_read(file.path(dir, all[i]), quiet=!verbose)$geometry
		}

		# the elemtn list
		names(listForm) <- c(cm, cs)

		# index for the SfArray
		ind <- matrix(1:length(listForm), ncol=2, byrow=FALSE)
		colnames(ind) <- c("margin", "coast")
		rownames(ind) <- ages

		pc <- via::SfcArray(stack=listForm, index=ind)
		pc


	}, ns="chronosphere"
)
