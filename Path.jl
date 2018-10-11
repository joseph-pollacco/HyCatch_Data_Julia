module path
   Home = "C:\\JOE\\Main\\MODELS\\HYDRO\\Distributed\\HyCatch\\Julia\\HyCatch_Data\\"
	Home_Data = "C:\\JOE\\DATAsim\\HydroPore\\HydroPore_1\\Input\\"
	Home_Output ="C:\\JOE\\Main\\MODELS\\HYDRO\\Distributed\\HyCatch\\Julia\\HyCatch_Model\\Input\\3D\\"

   # LOOK UP TABLES
   LookUpTable_Veg =   Home * "\\Input\\LookUpTable\\LookUpTable_Veg.csv"

   # 2D FIXED DATA
   Catchment_Input = Home_Data * "DEM\\SubCatchment_Catch.map"
   Catchment_Output = Home_Output  * "Output\\Catchment.ra"

   LCDB_Input = Home_Data * "LCDB\\LCDB.map"
   # LCDB_Output = Home * "Output\\LCDB\\LCDB2.ra"
   
   # 2D TIME SERIES DATA
   Climate_Date = Home_Data * "CLIMATE\\Spatial\\ClimateDates.csv"
   Climate_Pr_2D =  Home_Data * "CLIMATE\\Spatial\\Rain\\Rain_"
   Climate_Pet_2D =  Home_Data * "CLIMATE\\Spatial\\PET\\PET_"

   

end # path