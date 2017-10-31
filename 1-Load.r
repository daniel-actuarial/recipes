# Clean workspace
rm(list = ls())

# Set the working directory
setwd("C:/Users/daniy/Documents/R_machinelearning/recipes")


### Fastest loading method

## CSV or TXT

# load the library
library(data.table)

# Load data from a file in the local directory

# define the filename
filename <- "iris.csv"
# load the CSV file from the local directory
dataset <- fread(filename)


# Load From a URL

# load the library
library(curl)
dataset <- fread("https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data")


### Load multiple files of the same format
file.list <- list.files(pattern="*.csv")
df.list <- sapply(file.list, fread, simplify=FALSE) # Any other reading function can be used


### Other methods

## CSV
# Load data from a CSV file in the local directory

# define the filename
filename <- "iris.csv"
# load the CSV file from the local directory
dataset <- read.csv(filename, 
					header=FALSE, 
					sep=",", 
					na.strings = "EMPTY") # strings interpreted as NA


# Load CSV From a URL

# load the library
library(RCurl)
# specify the URL for the Iris data CSV
urlfile <- "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
# download the file
downloaded <- getURL(urlfile, ssl.verifypeer=FALSE)
# treat the text data as a steam so we can read from it
connection <- textConnection(downloaded)
# parse the downloaded data as CSV
dataset <- read.csv(connection, header=FALSE)


## TXT
# Load data from a TXT file in the local directory

# define the filename
filename <- "iris.txt"
# load the TXT file from the local directory
dataset <- read.table(filename, 
						header = FALSE, 
						sep="/",
						na.strings = "EMPTY")  # strings interpreted as NA


## EXCEL
library(readxl)
mydata <- read_excel("excelfile.xls", sheet = "sheet1")
mydata <- read_excel("excelfile.xlsx", sheet = 1, na = "99")


## SAS
library(haven)
read_sas("mtcars.sas7bdat")
write_sas(mtcars, "mtcars.sas7bdat")


## SPSS
library(haven)
read_sav("mtcars.sav")
write_sav(mtcars, "mtcars.sav")


## Stata
library(haven)
read_dta("mtcars.dta")
write_dta(mtcars, "mtcars.dta")


## SQL



### Split out the dataset

## Train/Validation
# create a list of 80% of the rows in the original dataset we can use for training
set.seed(7)
validation_index <- createDataPartition(BreastCancer$Class, p=0.80, list=FALSE)
# select 20% of the data for validation
validation <- BreastCancer[-validation_index,]
# use the remaining 80% of data to training and testing the models
dataset <- BreastCancer[validation_index,]

## Train/Blend/Validation
# create a list of 60% of the rows in the original dataset we can use for training
set.seed(7)
validation_index <- createDataPartition(BreastCancer$Class, p=0.60, list=FALSE)
# use the remaining 60% of data to training and testing the models
dataset <- BreastCancer[validation_index,]
# select 40% of the data for 2nd level train and validation
dataset2 <- BreastCancer[-validation_index,]
# create a list of 50% of the rows in the sub-dataset we can use for training again
set.seed(7)
validation_index <- createDataPartition(dataset2$Class, p=0.50, list=FALSE)
# use the remaining 50% of data to train again the models
dataset_train2 <- dataset2[validation_index,]
# select 50% of the data for validation
validation <- dataset2[-validation_index,]



