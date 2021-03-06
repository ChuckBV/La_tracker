#=============================================================================
# La_tracker_demo.R
#
# Only difference between this and the working script (La_tracker.R) is that
# this one 
#
#=============================================================================

#library(dplyr)
# Stay with base R

#-- 1. Demonstrate in principle ----------------------------------------------

# Read in the grid as a data frame
hoursin_df <- as.data.frame(read.csv("./Data/Payperiods-test-seq.csv", header=TRUE))

# Drop columns other then day 1 to day 14 of the payperiod (Year and PP)
hoursin_df <- select(hoursin_df, d1:d14)

# Make the 26-row x 14-column df with values of interest arranged from left 
# to right and top to bottm into a 26-row x 7 column matrix with the non-0,
# non-NA values from the dataframe arranged top to bottom and left to right.
# Convert the remaining 26 x 14 (r x c) grid to a matrix object

{
  hoursmatrix <- t(matrix(as.numeric(unlist(hoursin_df)), nrow = nrow(hoursin_df)))
  hoursvector <- as.vector(hoursmatrix)
  hoursvector <-hoursvector[!is.na(hoursvector) & hoursvector > 0]
  hoursvector <- c(hoursvector, rep(0,182-length(hoursvector)))
  dim(hoursvector) <- c(26,7)
}

# Output as a csv file
write.table(hoursvector, file= "./Results/Hoursout.csv", row.names = FALSE, col.names = FALSE, sep = ",")
