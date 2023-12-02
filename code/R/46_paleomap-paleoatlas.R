#' Function to load in a specific variable
#' @param dir path to archive directory
#' @param verbose  Should feedback be output to the console?
#' @param attach  Should the packages on which the dataset depends be attached? 
#' 
assignInNamespace("loadVar", 
	function(dir, verbose=FALSE, attach=TRUE){
        if(! requireNamespace("ncdf4", quietly=TRUE)) stop("This dataset requires the 'ncdf4' package to load.")
        if(! requireNamespace("terra", quietly=TRUE)) stop("This dataset requires the 'terra' package to load.")
        if(! requireNamespace("via", quietly=TRUE)) stop("This dataset requires the 'via' package to load.")
	
		if(attach){
			library("terra")
			library("via")
		}

		all <- c(
			'Map1a PALEOMAP PaleoAtlas_000.jpg',
			'Map2a Last Glacial Maximum_001.jpg',
			'Map3a Pliocene_004.jpg',
			'Map4a Messinian Event_006.jpg',
			'Map5a Late Miocene_010.jpg',
			'Map6a  Middle Miocene_015.jpg',
			'Map7a  Early Miocene_020.jpg',
			'Map8a Late Oligocene_025.jpg',
			'Map9a  Early Oligocene_030.jpg',
			'Map10a Late Eocene_035.jpg',
			'Map11a MIddle Eocene_040.jpg',
			'Map12a early Middle Eocene_045.jpg',
			'Map13a Early Eocene_050.jpg',
			'Map14a PETM_055.jpg',
			'Map15a Paleocene_060.jpg',
			'Map16a KT Boundary_066.jpg',
			'Map17a LtK Maastrichtian_070.jpg',
			'Map18a LtK Late Campanian_075.jpg',
			'Map19a LtK Early Campanian_080.jpg',
			'Map21a LtK Turonian_090.jpg',
			'Map22a LtK Cenomanian_095.jpg',
			'Map23a EK Late Albian_100.jpg',
			'Map24a EK Middle Albian_105.jpg',
			'Map25a EK Early Albian_110.jpg',
			'Map26a EK Late Aptian_115.jpg',
			'Map27a EK Early Albian_120.jpg',
			'Map28a EK Barremian_125.jpg',
			'Map29a EK Hauterivian_130.jpg',
			'Map30a EK Valangian_135.jpg',
			'Map31a EK Berriasian_140.jpg',
			'Map32a Jurassic-Cretaceous Boundary_145.jpg',
			'Map33a LtJ Tithonian_150.jpg',
			'Map34a LtJ Kimmeridgian_155.jpg',
			'Map35a LtJ Oxfordian_160.jpg',
			'Map36a MJ Callovian_165.jpg',
			'Map37a MJ Bajocian&Bathonian_170.jpg',
			'Map38a MJ Aalenian_175.jpg',
			'Map39a EJ Toarcian_180.jpg',
			'Map40a EJ Pliensbachian_185.jpg',
			'Map41a EJ Sinemurian_190.jpg',
			'Map42a EJ Hettangian_195.jpg',
			'Map43a Triassic-Jurassic Boundary_200.jpg',
			'Map44a LtTr Norian_210.jpg',
			'Map45a LtTr Carnian_220.jpg',
			'Map46a MTr Ladinian_230.jpg',
			'Map47a MTr Anisian_240.jpg',
			'Map48a ETr Induan-Olenekian_245.jpg',
			'Map49a Permo-Triassic Boundary_250.jpg',
			'Map50a LtP Lopingian_255.jpg',
			'Map51a LtP Capitanian_260.jpg',
			'Map52a MP Roadian&Wordian_270.jpg',
			'Map53a EP Kungurian_275.jpg',
			'Map54a EP Artinskian_280.jpg',
			'Map55a EP Sakmarian_290.jpg',
			'Map56a EP Asselian_295.jpg',
			'Map57a LtCarb Gzhelian_300.jpg',
			'Map58a LtCarb Kasimovian_305.jpg',
			'Map59a LtCarb Moscovian_310.jpg',
			'Map60a LtCarb Bashkirian_315.jpg',
			'Map61a ECarb Serpukhovian_320.jpg',
			'Map62a ECarb Late Visean_330.jpg',
			'Map63a ECarb Early Visean_340.jpg',
			'Map64a ECarb Tournaisian_350.jpg',
			'Map65a Devono-Carboniferous Boundary_360.jpg',
			'Map66a LtD Famennian_370.jpg',
			'Map67a LtD Frasnian_380.jpg',
			'Map68a MD Givetian_390.jpg',
			'Map69a MD Eifelian_395.jpg',
			'Map70a ED Emsian_400.jpg',
			'Map71a ED Pragian_410.jpg',
			'Map72a ED Lochlovian_415.jpg',
			'Map73a LtS  Ludlow&Pridoli_420.jpg',
			'Map74a MS Wenlock_425.jpg',
			'Map75a ES late Llandovery_430.jpg',
			'Map76a ES early Llandovery_440.jpg',
			'Map77a LtO Hirnantian_445.jpg',
			'Map78a LtO Sandbian-Katian_450.jpg',
			'Map79a LtO Caradoc_460.jpg',
			'Map80a LtO Darwillian_461.jpg',
			'Map81a EO Floian-Dapingian_470.jpg',
			'Map82a EO Tremadoc_480.jpg',
			'Map83a Cambro-Ordovician Boundary_490.jpg',
			'Map84a LtC Furongian_500.jpg',
			'Map85a early Late Cambrian Series 3_510.jpg',
			'Map86a Middle Cambrian Series 2_520.jpg',
			'Map87a Early Cambrian Terreneuvian_530.jpg',
			'Map88a Precambrian-Cambrian Boundary_540.jpg',
			'Map90a Middle Ediacaran_600.jpg',
			'Map92a Late Cryogenian_690.jpg',
			'Map93a MIddle Cryogenian_750.jpg'
		)

		# paleoatlas load
		pa <- suppressWarnings(terra::rast(paste0(dir, "/Scotese PaleoAtlas_v3/PALEOMAP PaleoAtlas Rasters v3/", all)))
		terra::ext(pa) <- terra::ext(-180, 180, -90, 90)

		# the dimensions
		origDim <- dim(pa)

		# create index for rasterarray
		elements <- 1:origDim[3]
		index <- matrix(elements, ncol=3, nrow=origDim[3]/3, byrow=TRUE)

		# the attributes
		split <- strsplit(unlist(strsplit(all, ".jpg")), "_") 
		dimnames(index) <- list(
			"age" =as.numeric(unlist(lapply(split, function(x) x[length(x)] ))),
			"channel" = c("R", "G", "B")
		)
		
		# the RasterArray
		ra <- via::RasterArray(stack=pa, index=index)

		# return
		return(ra)


	}, ns="chronosphere"
)
