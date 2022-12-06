# load libraries
library(tidyverse)
library(rspiro)
setwd("...") #set diretory to folders with pdf data

# Convert values such that z-scores can be calculated 
# ensure values are correct type after being scraped by tesseract - normally output is strings

#convert values where appropriate
height <-  as.numeric(height)
weight <-  as.numeric(weight)
exam_date <- as.Date(exam_date, format = "%d/%m/%Y")
date_of_birth <-  as.Date(date_of_birth, format = "(%d/%m/%Y)")

FEV1 <- as.numeric(FEV1)
FVC <- as.numeric(FVC)


#convert values for z equation as per Global Lung Intiative
#Gender (1 = male, 2 = female) or a factor with two levels (first = male) as per Global Lung Initiative
if (gender == "Male")
{
  gender <- 1
} else if (gender == "Female")
{
  gender <- 2
} else 
{
  gender <- 3
}

#height required in meters
height <-  height/100

# Ethnicity (1 = Caucasian, 2 = African-American, 3 = NE Asian, 4 = SE Asian, 5 = Other/mixed)
# again as per Global Lung Initiative
if (ethnic_origin == "Caucasian")
{
  ethnic_origin <- 1 
} else if (ethnic_origin == "African-American")
{
  ethnic_origin <-  2
}

# calculate patient age
pt_age <- as.numeric(difftime(exam_date, date_of_birth, units = "weeks") )/52.25 #note we set the number of weeks in year


# z-score calculate
z_score <- rspiro::zscore_GLI(pt_age, height, gender, ethnic_origin, FEV1, FVC)
z_score_FEV1 <- z_score[1]
z_score_FVC <-  z_score[2]

