# La_tracker.R
# Chuck Burks, April 6, 2017

# OBJECTIVE
# Re-shape work data (hours per day) from the format used 
# (<= 26 pay periods, 14 days per pay period, 0s included, 
# so a 26 x 14 (r x c) matrix. The form required from us
# by "L-A Appt Tracker.xls" is a matrix of 26 rows and 7
# columns. We are to ignore days with 0 work hours and enter
# days works serially, days 1-26 in column 1, days 27-52
# in column 2, etc. The objective of this program is to 
# automate the reshaping of these data, thereby increasing
# efficiency and reducing transcription errors.

# APPROACH
# Data are collected in an Excel spreadsheet that is an
# succinct version of the data collected for WebTA (i.e.,
# 26 rows representing Pay Periods with 14 columns representing
# the days within the pay periods. The first sheet, "Dataform"
# is a more human-friendly version that facilitate a running
# sum of hours in the appointment. The second sheet, "Grid",
# is a more computer-friendly grid that is saved as a 
# CSV file and read in by R to reshape the data


#RESHAPING THE DATA

# Read in the grid as a data frame
hoursin_df <- as.data.frame(read.csv("./Data/Hoursin.csv", header=TRUE))
head(hoursin_df)


# Drop the first two columns (Year and PP)
hoursin_df <- hoursin_df[ , c(3:16)]
head(hoursin_df)

# Convert the remaining 26 x 14 (r x c) grid to a matrix object
hoursmatrix <- matrix(as.numeric(unlist(hoursin_df)), nrow = nrow(hoursin_df))
hoursmatrix

# Transpose the matrix from 26 x 14 to 14 x 26. 
hoursmatrix <-t(hoursmatrix)
hoursmatrix

# Make the matrix into a vector
hoursvector <- as.vector(hoursmatrix)

# Drop all elements with a na value
hoursvector <-hoursvector[!is.na(hoursvector)]

# Add however many 0s to the end of the vector to attain a length of 182
hoursout <- c(hoursvector, rep(0,182-length(hoursvector)))


# Reshape to LA tracker format of 7 columns of 26 rows each, 
# sequentially down then across
dim(hoursout) <- c(26,7)

# Output as a csv file
write.table(hoursout, file= "./Results/Hoursout.csv", row.names = FALSE, col.names = FALSE, sep = ",")
