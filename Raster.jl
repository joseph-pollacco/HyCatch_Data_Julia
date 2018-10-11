module raster

   using ArchGDAL, GDAL 
   using RawArray

   export IMAGE_2_JULIA

   function IMAGE_2_JULIA(Path_Input)

      Data = [] # To inform that it is an array

      # Basic of reading an image file
      ArchGDAL.registerdrivers() do
         ArchGDAL.read(Path_Input) do Image

         N_X = ArchGDAL.width(Image) #the width pixels
         N_Y = ArchGDAL.height(Image) # the height pixels

         # Put format into JULIA format
         Data = ArchGDAL.read(Image, 1)

         return Data, N_X, N_Y

         end # ArchGDAL.read
      end # ArchGDAL.registerdrivers

   end # IMAGE_2_JULIA

end # module raster