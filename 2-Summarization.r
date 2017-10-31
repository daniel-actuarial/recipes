# load the library
library(mlbench)
# load the dataset
data(PimaIndiansDiabetes)
data(BostonHousing)
data(iris)


# Peek at raw data

# display first 20 rows of data
head(PimaIndiansDiabetes, n=20)



# Dimensions of the dataset

# display the dimensions of the dataset
dim(PimaIndiansDiabetes)



# Data Types

# list types for each attribute
sapply(PimaIndiansDiabetes, class)



# Class Distribution

# distribution of class variable
y <- PimaIndiansDiabetes$diabetes
percentage=prop.table(table(y))*100
cbind(freq=table(y), percentage=percentage)



# Summarize each attribute of a dataset using min, max, mean, 25%, 50% and 75%.

# summarize the dataset
summary(PimaIndiansDiabetes)



# Standard Deviation

# calculate standard deviation for all attributes
sapply(PimaIndiansDiabetes[,1:8], sd)



# Calculate Skewness

# load libraries
library(e1071)
# calculate skewness for each variable
skew <- apply(PimaIndiansDiabetes[,1:8], 2, skewness)
# display skewness, larger/smaller deviations from 0 show more skew
print(skew)



# Pair-wise correlations using pearson correlation coefficients (assumes constant variance and linearity)

# calculate a correlation matrix for numeric variables
correlations <- cor(PimaIndiansDiabetes[,1:8])
# display the correlation matrix
print(correlations)



# Pair-wise correlations using pearson spearman coefficients (for monotonic non-linear relationship)

# calculate a correlation matrix for numeric variables
correlations <- cor(PimaIndiansDiabetes[,1:8], method="spearman")
# display the correlation matrix
print(correlations)