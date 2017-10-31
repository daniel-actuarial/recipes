# load the libraries
library(mlbench)
# load the dataset
data(iris)
# load the dataset
data(BreastCancer)




# Remove rows with NA

# summarize dimensions of dataset
dim(BreastCancer)
# Remove all incomplete rows
dataset <- BreastCancer[complete.cases(BreastCancer),]
# summarize dimensions of resulting dataset
dim(dataset)



# Remove duplicate instances

# summarize dimensions of dataset
dim(iris)
# remove duplicates
clean <- unique(iris)
dim(clean)



# Impute missing values

# load the libraries
library(Hmisc)
# mark a pressure of 0 as N/A, it is impossible
invalid <- 0
PimaIndiansDiabetes$pressure[PimaIndiansDiabetes$pressure==invalid] <- NA
# impute missing pressure values using the mean
PimaIndiansDiabetes$pressure <- with(PimaIndiansDiabetes, impute(pressure, mean))



# Mark missing values as N/A

# mark a pressure of 0 as N/A, it is impossible
invalid <- 0
PimaIndiansDiabetes$pressure[PimaIndiansDiabetes$pressure==invalid] <- NA



# Update data frame to remove outliers

# calculate stats for pregnant (number of times pregnant)
pregnant.mean <- mean(PimaIndiansDiabetes$pregnant)
pregnant.sd <- sd(PimaIndiansDiabetes$pregnant)
# max reasonable value is within 99.7% of the data (if Gaussian)
pregnant.max <- pregnant.mean + (3*pregnant.sd)
# mark outlier pregnant values as N/A
PimaIndiansDiabetes$pregnant[PimaIndiansDiabetes$pregnant>pregnant.max] <- NA



# Rebalance a dataset using Synthetic Minority Over-sampling Technique (SMOTE)

# load the libraries
library(DMwR)
# display count of instances of each class (unbalanced)
table(PimaIndiansDiabetes$diabetes)
# use SMOTE to created a "more balance" version of the dataset
balanced <- SMOTE(diabetes~., PimaIndiansDiabetes, perc.over=300, perc.under=100)