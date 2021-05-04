#=============================================================================
# La_tracker2.R
#
# In 2021 the mandated form for reporting L/A hours was changed, so a
# work-around to the spreadsheet had to be changed. 
#
#=============================================================================

library(readxl)

#-- 1. Directly import Excel to data frame ----------------------------------

hrs_df <- read_excel("./Data/La_hr_vangj_y20_pp12.xlsx",
           sheet = "Dataform",
           range = "A2:S28",
           col_types = c("numeric","numeric","date","date","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

### Specify data type for dates
hrs_df$Start <- as.Date(hrs_df$Start)
hrs_df$End <- as.Date(hrs_df$End)

head(hrs_df,2)
# A tibble: 2 x 19
#    Year    PP Start      End          Sum    d1    d2    d3    d4    d5    d6    d7    d8    d9   d10   d11   d12   d13   d14
#   <dbl> <dbl> <date>     <date>     <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
# 1  2020    13 2020-06-21 2020-07-04    62    NA     6     8     8     8    NA    NA    NA     8     8     8     8    NA    NA
# 2  2020    14 2020-07-05 2020-07-18    80    NA     8     8     8     8     8    NA    NA     8     8     8     8     8    NA

#-- 2. Obtain numeric grid from d columns and replace NA with 0 ---------------

hr_grid <- as.matrix(hrs_df[,6:19])
head(hr_grid,2)
#      d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14
# [1,] NA  6  8  8  8 NA NA NA  8   8   8   8  NA  NA
# [2,] NA  8  8  8  8  8 NA NA  8   8   8   8   8  NA

hr_vector <- as.vector(t(hr_grid)) 
  # reads column-wise, must transpose for intended order

hr_vector[is.na(hr_vector)] <- 0 # Replace NA with zero
hr_vector
#   [1] 0 6 8 8 8 0 0 0 8 8 8 8 0 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8 8 0 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8
#  [66] 8 8 8 8 0 0 0 8 8 8 8 0 0 0 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8
# [131] 8 8 0 0 8 8 8 8 8 0 0 0 8 0 8 8 0 0 8 8 8 8 8 0 0 0 8 8 0 8 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8 8 8 0 0 8 8 8 0 0 0 0 0 8 0 0 8
# [196] 0 0 0 8 0 8 0 0 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# [261] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 4 4 4 0 0 4 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0
# [326] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

#-- 3. Obtain a vector of dates for hr_vector and output both as df -----------

### All months and days in period of L/A appoint
Date <- seq(min(hrs_df$Start), max(hrs_df$End), "day")

### Output data frame
hrs_out <- data.frame(Date,Hours = hr_vector)
head(hrs_out,2)
#         Date Hours
# 1 2020-06-21     0
# 2 2020-06-22     6

#-- 4. Save data frame as csv --------------------------------------

write.csv(hrs_out,"./Results/tracker2_out.csv", row.names = FALSE)
