module lookup

   using Distributed, SharedArrays

	function LOOKUPTABLE(Data, IdLCDB, LookUp, Catchment_X_True, Catchment_Y_True)


      N_X, N_Y = size(Data)
		N_Xy_True = length(Catchment_X_True[:])
  
		Output = zeros(Float64,  N_X, N_Y)

		for i = 1:N_Xy_True
         iX = Catchment_X_True[i] # Determening the X value which has data
			iY = Catchment_Y_True[i] # Determening the Y value which has data

         # Finding the position of Data[iX,iY] in the LookUpTable
			iFind = findfirst(isequal(Data[iX,iY]), IdLCDB[:])

			Output[iX, iY] = LookUp[iFind]
      end # for ix

      return Output
   end # function lookup



end