module catchment

   export CATCHMENT

   function CATCHMENT(Catchment, N_X, N_Y)

      Catchment_X_True = zeros(Int32, N_X * N_Y)
      Catchment_Y_True = zeros(Int32, N_X * N_Y)
      i = 0
      for iX in 1:N_X 
          for iY in 1 : N_Y
            if Catchment[iX,iY] > 0
               i+=1
               Catchment_X_True[i] = iX
               Catchment_Y_True[i] = iY
            end # if
         end # for iY
      end # for ix

      N_Xy_True = i # Number of cells which are true

      return Catchment_X_True, Catchment_Y_True, N_Xy_True
   end # CATCHEMENT

end # catchement