# check_stratch.R

library(tidyverse)

hoursin_df %>% 
  pivot_longer(cols = "",names_to = "Day")
