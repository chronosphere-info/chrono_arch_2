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

		# read all files in temporary directory - it is more robust to do it explicitly than tinkering 
		files<- c(
			"Map01_PALEOMAP_1deg_Holocene_0Ma.nc",
			"Map03_PALEOMAP_1deg_Pliocene_5Ma.nc",
			"Map05_PALEOMAP_1deg_middle_Late_Miocene_10Ma.nc",
			"Map06_PALEOMAP_1deg_Middle_Miocene_15Ma.nc",
			"Map07_PALEOMAP_1deg_Early_Miocene_20Ma.nc",
			"Map08_PALEOMAP_1deg_Late_Oligocene_25Ma.nc",
			"Map09_PALEOMAP_1deg_Early_Oligocene_30Ma.nc",
			"Map10_PALEOMAP_1deg_Late_Eocene_35Ma.nc",
			"Map11_PALEOMAP_1deg_late_Middle_Eocene_40Ma.nc",
			"Map12_PALEOMAP_1deg_early_Middle_Eocene_45Ma.nc",
			"Map13_PALEOMAP_1deg_Early_Eocene_50Ma.nc",
			"Map14_PALEOMAP_1deg_Paleocene_Eocene_Boundary_55Ma.nc",
			"Map15_PALEOMAP_1deg_Paleocene_60Ma.nc",
			"Map16_PALEOMAP_1deg_KT_Boundary_65Ma.nc",
			"Map17_PALEOMAP_1deg_Late_Cretaceous_70Ma.nc",
			"Map18_PALEOMAP_1deg_Late_Cretaceous_75Ma.nc",
			"Map19_PALEOMAP_1deg_Late_Cretaceous_80Ma.nc",
			"Map20_PALEOMAP_1deg_Late_Cretaceous_85Ma.nc",
			"Map21_PALEOMAP_1deg_Mid-Cretaceous_90Ma.nc",
			"Map22_PALEOMAP_1deg_Mid-Cretaceous_95Ma.nc",
			"Map23_PALEOMAP_1deg_Early_Cretaceous_100Ma.nc",
			"Map24_PALEOMAP_1deg_Early Cretaceous_105Ma.nc",
			"Map25_PALEOMAP_1deg_Early_Cretaceous_110Ma.nc",
			"Map26_PALEOMAP_1deg_Early_Cretaceous_115Ma.nc",
			"Map27_PALEOMAP_1deg_Early_Cretaceous_120Ma.nc",
			"Map28_PALEOMAP_1deg_Early_Cretaceous_125Ma.nc",
			"Map29_PALEOMAP_1deg_Early_Cretaceous_130Ma.nc",
			"Map30_PALEOMAP_1deg_Early_Cretaceous_135Ma.nc",
			"Map31_PALEOMAP_1deg_Early_Cretaceous_140Ma.nc",
			"Map32_PALEOMAP_1deg_Jurassic_Cretaceous_Boundary_145Ma.nc",
			"Map33_PALEOMAP_1deg_Late_Jurassic_150Ma.nc",
			"Map34_PALEOMAP_1deg_Late_Jurassic_155Ma.nc",
			"Map35_PALEOMAP_1deg_Late_Jurassic_160Ma.nc",
			"Map36_PALEOMAP_1deg_Middle_Jurassic_165Ma.nc",
			"Map37_PALEOMAP_1deg_Middle_Jurassic_170Ma.nc",
			"Map38_PALEOMAP_1deg_Middle_Jurassic_175Ma.nc",
			"Map39_PALEOMAP_1deg_Early_Jurassic_180Ma.nc",
			"Map40_PALEOMAP_1deg_Early_Jurassic_185Ma.nc",
			"Map41_PALEOMAP_1deg_Early_Jurassic_190Ma.nc",
			"Map42_PALEOMAP_1deg_Early_Jurassic_195Ma.nc",
			"Map43_PALEOMAP_1deg_Late_Triassic_200Ma.nc",
			"Map43.5_PALEOMAP_1deg_Late_Triassic_205Ma.nc",
			"Map44_PALEOMAP_1deg_Late_Triassic_210Ma.nc",
			"Map44.5_PALEOMAP_1deg_Late_Triassic_215Ma.nc",
			"Map45_PALEOMAP_1deg_Late_Triassic_220Ma.nc",
			"Map45.5_PALEOMAP_1deg_Late_Triassic_225Ma.nc",
			"Map46_PALEOMAP_1deg_Late_Triassic_230Ma.nc",
			"Map46.5_PALEOMAP_1deg_Late_Triassic_235Ma.nc",
			"Map47_PALEOMAP_1deg_Middle_Triassic_240Ma.nc",
			"Map48_PALEOMAP_1deg_Middle_Triassic_245Ma.nc",
			"Map49_PALEOMAP_1deg_Permo-Triassic Boundary_250Ma.nc",
			"Map50_PALEOMAP_1deg_LatePermian_255Ma.nc",
			"Map51_PALEOMAP_1deg_Middle_Permian_260Ma.nc",
			"Map51.5_PALEOMAP_1deg_Middle_Permian_265Ma.nc",
			"Map52_PALEOMAP_1deg_Middle_Permian_270Ma.nc",
			"Map53_PALEOMAP_1deg_Early_Permian_275Ma.nc",
			"Map54_PALEOMAP_1deg_Early_Permian_280Ma.nc",
			"Map54.5_PALEOMAP_1deg_Early_Permian_285Ma.nc",
			"Map55_PALEOMAP_1deg_Early_Permian_290Ma.nc",
			"Map56_PALEOMAP_1deg_Early_Permian_295Ma.nc",
			"Map57_PALEOMAP_1deg_Late_Pennsylvanian_300Ma.nc",
			"Map58_PALEOMAP_1deg_Late_Pennsylvanian_305Ma.nc",
			"Map59_PALEOMAP_1deg_Middle_Pennsylvanian_310Ma.nc",
			"Map59.5_PALEOMAP_1deg_EarlyMiddleCarboniferous_315Ma.nc",
			"Map60_PALEOMAP_1deg_Early_Pennsylvanian_320Ma.nc",
			"Map61_PALEOMAP_1deg_Late_Mississippian_325Ma.nc",
			"Map62_PALEOMAP_1deg_Late_Mississippian_330Ma.nc",
			"Map62.5_PALEOMAP_1deg_Middle_Mississippian_335Ma.nc",
			"Map63_PALEOMAP_1deg_Middle_Mississippian_340Ma.nc",
			"Map63.5_PALEOMAP_1deg_Middle_Mississippian_345Ma.nc",
			"Map64_PALEOMAP_1deg_Early_Mississippian_350Ma.nc",
			"Map64.5_PALEOMAP_1deg_Early_Mississippian_355Ma.nc",
			"Map65_PALEOMAP_1deg_Devono-Carboniferous Boundary_360Ma.nc",
			"Map65.5_PALEOMAP_1deg_Late_Devonian_365Ma.nc",
			"Map66_PALEOMAP_1deg_Late_Devonian_370Ma.nc",
			"Map66.5_PALEOMAP_1deg_Late_Devonian_375Ma.nc",
			"Map67_PALEOMAP_1deg_Late_Devonian_380Ma.nc",
			"Map67.5_PALEOMAP_1deg_Middle_Devonian_385.2Ma.nc",
			"Map68_PALEOMAP_1deg_Middle_Devonian_390.5Ma.nc",
			"Map69_PALEOMAP_1deg_Early_Devonian_395Ma.nc",
			"Map70_PALEOMAP_1deg_Early_Devonian_400Ma.nc",
			"Map70.5_PALEOMAP_1deg_Early_Devonian_405Ma.nc",
			"Map71_PALEOMAP_1deg_Early_Devonian_410Ma.nc",
			"Map72_PALEOMAP_1deg_Early_Devonian_415Ma.nc",
			"Map73_PALEOMAP_1deg_Late_Silurian_420Ma.nc",
			"Map74_PALEOMAP_1deg_Late_Silurian_425Ma.nc",
			"Map75_PALEOMAP_1deg_Middle_Silurian_430Ma.nc",
			"Map75.5_PALEOMAP_1deg_Early_Silurian_435Ma.nc",
			"Map76_PALEOMAP_1deg_Early_Silurian_440Ma.nc",
			"Map77_PALEOMAP_1deg_Late_Ordovician_445Ma.nc",
			"Map78_PALEOMAP_1deg_Late_Ordovician_450Ma.nc",
			"Map79_PALEOMAP_1deg_Late_Ordovician_455Ma.nc",
			"Map80_PALEOMAP_1deg_Middle_Ordovician_460Ma.nc",
			"Map80.5_PALEOMAP_1deg_Middle_Ordovician_465Ma.nc",
			"Map81_PALEOMAP_1deg_Early_Ordovician_470Ma.nc",
			"Map81.5_PALEOMAP_1deg_Early_Ordovician_475Ma.nc",
			"Map82_PALEOMAP_1deg_Early_Ordovician_480Ma.nc",
			"Map82.5_PALEOMAP_1deg_Cambro-Ordovician_Boundary_485Ma.nc",
			"Map83_PALEOMAP_1deg_Late_Cambrian_490Ma.nc",
			"Map83.5_PALEOMAP_1deg_Late_Cambrian_495Ma.nc",
			"Map84_PALEOMAP_1deg_late_Middle_Cambrian_500Ma.nc",
			"Map84.1_PALEOMAP_1deg_late_Middle_Cambrian_505Ma.nc",
			"Map84.2_PALEOMAP_1deg_early_Middle_Cambrian_510Ma.nc",
			"Map85_PALEOMAP_1deg_early_Middle_Cambrian_515Ma.nc",
			"Map86_PALEOMAP_1deg_Early_Middle_Cambrian_boundary_520Ma.nc",
			"Map86.5_PALEOMAP_1deg_Early_Cambrian_525Ma.nc",
			"Map87_PALEOMAP_1deg_Early_Cambrian_530Ma.nc",
			"Map87.5_PALEOMAP_1deg_Early_Cambrian_535Ma.nc",
			"Map88_PALEOMAP_1deg_Cambrian_Precambrian boundary_540Ma.nc"
		)
		all <- file.path("Scotese_Wright_2018_Maps_1-88_1degX1deg_PaleoDEMS_nc_v2",files)
		
		# for the names of the files
		ageExt <- unlist(lapply(strsplit(files, "_"), function(x) x[length(x)]))
		ageExt <- unlist(lapply(strsplit(ageExt, "Ma"), function(x) x[1]))
		ageNum <- floor(as.numeric(ageExt))

		# the loop through all 
		for(i in 1:length(all)){
			one <- terra::rast(file.path(dir, all[i]))
			names(one) <- files[i]
			terra::varnames(one) <- "paleodem"
			if(i == 1){
				stack <- one
			}else{
				stack <- c(stack, one)
			}
		}

		# assign missing CRS
		terra::ext(stack) <- terra::ext(c(-180.5, 180.5, -90.5, 90.5))
		terra::crs(stack) <- "WGS84"

		# make a RasterArray
		ind <- 1:length(all)
		names(ind) <-  as.character(ageNum)
	
		# RasterArray
		via::RasterArray(stack=stack, index=ind)


	}, ns="chronosphere"
)
