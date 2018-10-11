cd("C:\\JOE\\Main\\MODELS\\HYDRO\\Distributed\\HyCatch\\Julia\\HyCatch_Data\\")
push!(LOAD_PATH, pwd())

include("Path.jl")
include("Option.jl")
include("Raster.jl")
include("Read.jl")
include("Catchment.jl")
include("Lookup.jl")

using  RawArray


function HYCATCH_DATA()
	Time_1 = time_ns()

   # CATCHEMENT
   # Reading catchement data from map format and deriving the catchement limits
	Catchment, N_X, N_Y = raster.IMAGE_2_JULIA(path.Catchment_Input)
   println("Catchment Cells X: $N_X, Cells Y: $N_Y, \n")

   # Determening which cells which fall in the catchement
	Catchment_X_True, Catchment_Y_True, N_Xy_True = catchment.CATCHMENT(Catchment, N_X, N_Y)
   println("Number of cells which are true = $N_Xy_True, \n")
	
	# Writting the output
	Catchment_Information = [N_X, N_Y, N_Xy_True]
	RawArray.rawrite(Catchment_Information, path.Home_Output * "Catchment\\Catchment_Information.ra", compress=false)
	RawArray.rawrite(Catchment_X_True, path.Home_Output * "Catchment\\Catchment_X_True.ra", compress=false)
	RawArray.rawrite(Catchment_Y_True, path.Home_Output * "Catchment\\Catchment_Y_True.ra", compress=false)


   # ========== LOOKUPTABLE OF LCDB data ========== 
   Lcdb, N_X, N_Y = raster.IMAGE_2_JULIA(path.LCDB_Input)
   println("LCDB Cells X: $N_X, Cells Y: $N_Y, \n")
   
	IdLCDB_LookUpTable_Veg , ~, ~ = read.READ_HEADER(path.LookUpTable_Veg, "IdLCDB")

	IsVegation_LookUpTable_Veg , ~, ~ = read.READ_HEADER(path.LookUpTable_Veg, "IsVegation")
   IsVegation = lookup.LOOKUPTABLE(Lcdb[1:N_X,1:N_Y], IdLCDB_LookUpTable_Veg[:],IsVegation_LookUpTable_Veg[:], Catchment_X_True[1:N_Xy_True], Catchment_Y_True[1:N_Xy_True])
   RawArray.rawrite(IsVegation, path.Home_Output * "Vegetation\\IsVegation.ra", compress=false)
   
   RootingDepth_LookUpTable_Veg, ~, ~ = read.READ_HEADER(path.LookUpTable_Veg, "RootingDepth_Max_cm")
   RootingDepth = lookup.LOOKUPTABLE(Lcdb[1:N_X,1:N_Y], IdLCDB_LookUpTable_Veg[:], RootingDepth_LookUpTable_Veg[:], Catchment_X_True[1:N_Xy_True], Catchment_Y_True[1:N_Xy_True])
   RawArray.rawrite(RootingDepth, path.Home_Output * "Vegetation\\RootingDepth.ra", compress=false)
   
   RootPerc_LookUpTable_Veg, ~, ~ = read.READ_HEADER(path.LookUpTable_Veg, "RootPerc30cm_%")
   RootPerc = lookup.LOOKUPTABLE(Lcdb[1:N_X,1:N_Y], IdLCDB_LookUpTable_Veg[:], RootPerc_LookUpTable_Veg[:], Catchment_X_True[1:N_Xy_True], Catchment_Y_True[1:N_Xy_True])
   RawArray.rawrite(RootPerc, path.Home_Output * "Vegetation\\RootPerc.ra", compress=false)
   
   StorageVegMaxLai_LookUpTable_Veg, ~, ~ = read.READ_HEADER(path.LookUpTable_Veg, "StorageVegMaxLai")
   StorageVegMaxLai = lookup.LOOKUPTABLE(Lcdb[1:N_X,1:N_Y], IdLCDB_LookUpTable_Veg[:], StorageVegMaxLai_LookUpTable_Veg[:], Catchment_X_True[1:N_Xy_True], Catchment_Y_True[1:N_Xy_True])
   RawArray.rawrite(StorageVegMaxLai, path.Home_Output * "Vegetation\\StorageVegMaxLai.ra", compress=false)

   # -------------------------------------------------------------------------------------------------


	# ========== TIME SERIES CLIMATE ========== 
	println("Writing climate")
   Year , N_Date, ~ = read.READ_HEADER(path.Climate_Date, "Year")
   Month , ~, ~ = read.READ_HEADER(path.Climate_Date, "Month")
   Day , ~, ~ = read.READ_HEADER(path.Climate_Date, "Day")
	Second , ~, ~ = read.READ_HEADER(path.Climate_Date, "Second")

	for i = 2:N_Date # We skip the 1 rst day which is to compute ΔT for the first time step
		FileName = string(Year[i]) * "_" * string(Month[i]) * "_" * string(Day[i]) * "_" * string(Second[i])
		Pr, ~, ~ = raster.IMAGE_2_JULIA(path.Climate_Pr_2D * FileName  * ".map")
		RawArray.rawrite(Pr, path.Home_Output * "\\Climate\\Pr\\Pr_" * FileName  * ".ra", compress=false)

		Path_Pet = path.Climate_Pet_2D * string(Year[i]) * "_" * string(Month[i]) * "_" * string(Day[i]) * "_" * string(Second[i]) * ".map" 
		Pet,  ~, ~ = raster.IMAGE_2_JULIA(Path_Pet)
		RawArray.rawrite(Pet, path.Home_Output * "\\Climate\\Etp\\Etp_" * FileName  * ".ra", compress=false)
	end

		Time_2 = time_ns()

		println("Time=", ((Time_2 - Time_1)/1.0e9))
		return
	end


HYCATCH_DATA()