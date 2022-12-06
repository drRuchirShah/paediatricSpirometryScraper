# load libraries
library(tidyverse)
library(tesseract)
setwd("...") #set diretory to folders with pdf data

# 1. 
# Setup tesseract
# https://cran.r-project.org/web/packages/tesseract/vignettes/intro.html

eng <- tesseract("eng") # tesseract reads english

# 2. 
# List all pdf files within directory that contains spirometery data
wd <- " working / directory " # working directory

files_to_test <- list.files(wd, pattern = ".pdf$", recursive = T, include.dirs = T)

# 3. 
# Create table or dataframe to input data into

df <- tibble(ID = NULL, 
             date_of_birth = NULL,
             exam_date = NULL,
             gender = NULL,
             ethnic_origin = NULL,
             height = NULL,
             weight = NULL,
             FEV1 = NULL,
             FVC = NULL,
             FeNO = NULL,
             )

# this_row is new row that will be appended to total dataframe each loop

this_row <- tibble(ID = NULL, 
                   date_of_birth = NULL,
                   exam_date = NULL,
                   gender = NULL,
                   ethnic_origin = NULL,
                   height = NULL,
                   weight = NULL,
                   FEV1 = NULL,
                   FVC = NULL,
                   FeNO = NULL,
                   )

# 4. 
# Run tesseract on each pdf (in a loop)
# This creates a vector called text_loop each loop

# We are intrested in first column of text_lop which contains text tesseract has extracted/read
# For each type of data we are intrested in we have to locate this
# This is a case of identifying common patterns
# For example date of birth often is the next element in our vector after the word "DOB:"
# Our index is the element number that "DOB:" takes in the vector

# loop over each of the files to test extract text as vector
for (val in files_to_test){
  text_loop <- tesseract::ocr_data(val, engine = eng)
  text_loop <- text_loop[,1] # extracts first column from tibble
  
  #find index for DOB
  dob_index <- (which(text_loop == "DOB:", arr.ind =T))
  dob <- text_loop[(dob_index[1] + 1),1]
  
  
  #find index for ID
  ID_index <- (which(text_loop == "ID:", arr.ind =T))
  ID <- text_loop[(ID_index[1] + 1),1]
  
  
  #find index for exam date
  index <- (which(text_loop == "Date:", arr.ind =T))
  exam_date <- text_loop[(index[1] + 1),1]
  
  
  #find index for gender
  index <- (which(text_loop == "Gender:", arr.ind =T))
  gender <- text_loop[(index[1] + 1),1]
  
  
  #find index for ethinic origin
  index <- (which(text_loop == "Origin:", arr.ind =T))
  ethnic_origin <- text_loop[(index[1] + 1),1]
  
  
  #find index for height (should be cm)
  index <- (which(text_loop == "Height:", arr.ind =T))
  height <- text_loop[(index[1] + 1),1]
  
  
  #find index for weight
  index <- (which(text_loop == "Weight:", arr.ind =T))
  weight <- text_loop[(index[1] + 1),1]
  
  
  #find index for FEV1
  index <- (which(text_loop == "SD", arr.ind =T)) # I have made index sd which relies on +2
  FEV1 <- text_loop[(index[1] + 2),1]
  
  
  #find index for FVC
  index <- (which(text_loop == "FVC", arr.ind =T))
  
  if (nrow(index) > 1)
    {
    FVC <- text_loop[(index[2] + 1),1]
  } 
  else 
    {
      FVC <- text_loop[(index[1] + 1),1]
    }
  
  
# find index for FeNO
# serach for ppb, this was often freetext
index <- (which(text_loop == "ppb.", arr.ind = T)) # gets index
FeNO <- text_loop[(index[1]-1),1] # the element prior to 2ppb" was the value

  
  
  #combine data into df
  this_row <- tibble(ID = ID, 
                     date_of_birth = dob,
                     exam_date = exam_date,
                     gender = gender,
                     ethnic_origin = ethnic_origin,
                     height = height,
                     weight = weight,
                     FEV1 = FEV1,
                     FVC = FVC,
                     FeNO = FeNO)
  
  df <- bind_rows(df, this_row) #append to main dataframe
  
  
}
### end loop