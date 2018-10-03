#############################################################################
# Program:      Ratings.R
# Last revised: 2018-09-28
#
# OBJECTIVE
# Determine ratings for evaluations based on OPM rubric
#
#############################################################################

#-- 0. Declare libraries and functions --------------------------------------
library(tibble)
library(dplyr)
library(DescTools)
library(tidyr)

#-- 1. Infile data, and proof and characterize ------------------------------

input_df <- as_tibble(read.csv("./Data/ratings.csv"))

#-- 2. Proof and characterize -----------------------------------------------

### Look for NAs or duplications
Desc(input_df$Exceeds, plotit = FALSE)
Desc(input_df$Meets, plotit = FALSE)
Desc(input_df$NotMeets, plotit = FALSE)

### Be certain that the three rating columns add up to 1 for each row
input_df$Checksum <- input_df$Exceeds + input_df$Meets + input_df$NotMeets
input_df[input_df$Checksum != 1, ] # should be 0 obs
input_df$Checksum <- NULL # If it checks out, drop the variable


#-- 3. Apply weighting, collapse by RatingRec, and apply rubric -------------

### Applying weighting factor
df2 <- input_df %>%
  mutate(Exceeds = ElementWt*Exceeds,
         Meets = ElementWt*Meets,
         NotMeets = ElementWt*NotMeets)

df2$ElementWt <- NULL


### Group by RatingRec and Sum column by rating
df2 <- df2 %>% 
  group_by(RatingRec) %>%
  summarise(Exceeds = sum(Exceeds),
            Meets = sum(Meets),
            NotMeets = sum(NotMeets)
            )

### Generate total of the weighted sums
df2$Total <- df2$Exceeds + df2$Meets + df2$NotMeets

### Apply rubric and get rating
df2 <- df2 %>% 
  mutate(rating = ifelse(Exceeds == Total, "Outstanding", 
                         ifelse(NotMeets == 0 & Exceeds > Meets, "Superior",
                                ifelse(NotMeets == 1, "Minimally Satisfactory",
                                       ifelse(NotMeets > 1, "Unacceptable","Fully Successful")))))
df2
