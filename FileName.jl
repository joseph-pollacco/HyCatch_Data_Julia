# using Dates

function  FILENAME()
   Path_Lai_Input = "C:\\JOE\\DATAraw\\RS\\LAIrs\\DataProcess\\NZsouth\\LAIrs_"
   Path_Lai_Output = "C:\\JOE\\DATAsim\\HydroPore\\HydroPore_1\\Input\\LAIrs2\\LAIrs_"
   Year_Start = 2002
   Year_End =2017
   Month_Start= 7
   Month_End = 8
   Day_Start = 4
   Day_End = 9

   Date_Start = Dates.DateTime(Year_Start, Month_Start, Day_Start) 
   Date_End = Dates.DateTime(Year_End, Month_End, Day_End)

   println(Date_Start)
   println(Date_Start)

   N = Float32( Dates.DateTime(Year_End, Month_End, Day_End) - Dates.DateTime(Year_Start, Month_Start, Day_Start)) / 1000 / 24 / 60 / 60 # Convert from ms -> seconds -> days
   N = Int64(N)
   println(N)

   
   
   Date = Date_Start
   for iDay in 1:N
      Date2 = Date_Start + Dates.Day(iDay)

      Year = Dates.year(Date2)
      Month = Dates.month(Date2)
      Day = Dates.day(Date2)
      Second = 1

      Month_0 = ""
      if Month < 10
         Month_0 =  "0" * string(Month)
      else 
         Month_0 = string(Month)
      end

      Day_0 = ""
      if Day < 10
         Day_0 =  "0" * string(Day)
      else
         Day_0 = string(Day)
      end

      DateInput  = Path_Lai_Input * string(Year) * Month_0 * Day_0  * ".map"
      println(DateInput)
     

      DateJulia =  Path_Lai_Output * string(Year) * "_" * string(Month) *  "_" * string(Day) * "_" * string(Second) * ".map"

      cp(DateInput, DateJulia; remove_destination=false, follow_symlinks=false)
      # println(DateJulia)
      
   end
end

FILENAME()