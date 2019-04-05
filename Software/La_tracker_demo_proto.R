#=============================================================================
# La_tracker_demo_proto.R
# Chuck Burks, April 6, 2017
#
#=============================================================================

library(dplyr)

#-- 1. Demonstrate in principle ----------------------------------------------

# Read in the grid as a data frame
hoursin_df <- as.data.frame(read.csv("./Data/Payperiods-test-seq.csv", header=TRUE))
head(hoursin_df)
#   Year PP d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14
# 1 2018 10 NA  1  2  3  4  5  0  0  6   7   8   9  10  NA
# 2 2018 11 NA 11 12 13 14 15 -1 -3 16  17  18  19  20  NA
# 3 2018 12 NA 21 22 23 24 25 NA NA 26  27  28  29  30  NA
# 4 2018 13 NA 31 32 33 34 35 NA NA 36  37  38  39  40  NA
# 5 2018 14 NA 41 42 43 44 45 NA NA 46  47  48  49  50  NA
# 6 2018 15 NA 51 52 53 54 55 NA NA 56  57  58  59  60  NA

# Drop the first two columns (Year and PP)
hoursin_df <- select(hoursin_df, d1:d14)
head(hoursin_df) #Should be just d1-d14

# Convert the remaining 26 x 14 (r x c) grid to a matrix object
hoursmatrix <- t(matrix(as.numeric(unlist(hoursin_df)), nrow = nrow(hoursin_df)))
hoursmatrix # NB payperiods are now columns
#        [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14] [,15] [,16] [,17] [,18] [,19] [,20]
# [1,]    NA   NA   NA   NA   NA   NA   NA   NA   NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
# [2,]     1   11   21   31   41   51   61   71   81    91   101   111   121    NA    NA    NA    NA    NA    NA    NA
# [3,]     2   12   22   32   42   52   62   72   82    92   102   112   122    NA    NA    NA    NA    NA    NA    NA
# [4,]     3   13   23   33   43   53   63   73   83    93   103   113   123    NA    NA    NA    NA    NA    NA    NA
# [5,]     4   14   24   34   44   54   64   74   84    94   104   114   124    NA    NA    NA    NA    NA    NA    NA
# [6,]     5   15   25   35   45   55   65   75   85    95   105   115   125    NA    NA    NA    NA    NA    NA    NA
# [7,]     0   -1   NA   NA   NA   NA   NA   NA   NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
# [8,]     0   -3   NA   NA   NA   NA   NA   NA   NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
# [9,]     6   16   26   36   46   56   66   76   86    96   106   116   126    NA    NA    NA    NA    NA    NA    NA
# [10,]    7   17   27   37   47   57   67   77   87    97   107   117   127    NA    NA    NA    NA    NA    NA    NA
# [11,]    8   18   28   38   48   58   68   78   88    98   108   118   128    NA    NA    NA    NA    NA    NA    NA
# [12,]    9   19   29   39   49   59   69   79   89    99   109   119   129    NA    NA    NA    NA    NA    NA    NA
# [13,]   10   20   30   40   50   60   70   80   90   100   110   120   130    NA    NA    NA    NA    NA    NA    NA
# [14,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA

# Make the matrix into a vector
hoursvector <- as.vector(hoursmatrix)
hoursvector
# [1]  NA   1   2   3   4   5   0   0   6   7   8   9  10  NA  NA  11  12  13  14  15  -1  -3  16  17  18  19  20  NA
# [29]  NA  21  22  23  24  25  NA  NA  26  27  28  29  30  NA  NA  31  32  33  34  35  NA  NA  36  37  38  39  40  NA
# [57]  NA  41  42  43  44  45  NA  NA  46  47  48  49  50  NA  NA  51  52  53  54  55  NA  NA  56  57  58  59  60  NA
# [85]  NA  61  62  63  64  65  NA  NA  66  67  68  69  70  NA  NA  71  72  73  74  75  NA  NA  76  77  78  79  80  NA
# [113]  NA  81  82  83  84  85  NA  NA  86  87  88  89  90  NA  NA  91  92  93  94  95  NA  NA  96  97  98  99 100  NA
# [141]  NA 101 102 103 104 105  NA  NA 106 107 108 109 110  NA  NA 111 112 113 114 115  NA  NA 116 117 118 119 120  NA
# [169]  NA 121 122 123 124 125  NA  NA 126 127 128 129 130  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
# [197]  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
# [225]  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
# [253]  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
# [281]  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
# [309]  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
# [337]  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA

# Drop all elements with values that are NA, 0, or negative
hoursvector <-hoursvector[!is.na(hoursvector) & hoursvector > 0]
hoursvector
#   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28
#  [29]  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56
#  [57]  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84
#  [85]  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 109 110 111 112
# [113] 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130

# Add however many 0s to the end of the vector to attain a length of 182
hoursvector <- c(hoursvector, rep(0,182-length(hoursvector)))
hoursvector


# Reshape to LA tracker format of 7 columns of 26 rows each, 
# sequentially down then across
dim(hoursvector) <- c(26,7)
hoursvector

# Output as a csv file
write.table(hoursvector, file= "./Results/Hoursout.csv", row.names = FALSE, col.names = FALSE, sep = ",")
