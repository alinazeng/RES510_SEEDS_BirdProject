# UBC Farm Bird Observation Data
# Data downloaded from https://dataverse.scholarsportal.info/dataset.xhtml?persistentId=doi:10.5683/SP2/Z9NOMS
# Alina Zeng
# November 2, 2021
# alina.zeng@ubc.ca


# packages



# Housekeeping ----
rm(list=ls()) 
options(stringsAsFactors = FALSE)

# Libraries needed for formatting and tidying data ----
library(dplyr)
library(tidyr)

# Set Working Directory ----
setwd("C:/Users/alina/Documents/git/RES510_SEEDS_BirdProject")

# Import UBC Farm NatureVancouverBirdRecords data and clean ----
d <- read.csv("input/NatureVancouverBirdRecords_csv.csv", header = TRUE)
# importing the csv file and calling it "d" for simplicity


# get rid of columns and rows that are not necessary
d <- dplyr::select(d, -c(station,count))
d <- unique(d)
unique(d$bird) # 141 species?

# count the number of observations made for each bird species ----
bird_species_obs <- d %>%
  group_by(bird) %>%
  summarise("count" = sum(total))

# get rid of rows with zero count
bird_species_obs
bird_species_obs_cleaned <- subset(bird_species_obs,bird_species_obs$count != "0")

# descend rows
bird_species_obs_cleaned  <- bird_species_obs_cleaned  %>% arrange(desc(bird_species_obs_cleaned$count))

# export
write.csv(bird_species_obs_cleaned,file = "output/UBCFarmBirdTotalCount.csv",row.names=FALSE)

