# load libraries
library(caret)
# load the dataset
data(iris)
# load libraries
library(mlbench)
# load libraries
#install.packages("CASdatasets", repos = "http://cas.uqam.ca/pub/R/", type="source")
library(CASdatasets)
# load the dataset
data(PimaIndiansDiabetes)
# load the dataset
data(freMTPL2freq)




# Data structure transformation

dataset <- freMTPL2freq

# change column name by reference name
colnames(dataframe)[which(names(dataframe) == "columnName")] <- "newColumnName"

# factor levels to binary variables
library(data.table)
setDT(dataset)[, c(levels(dataset$Area), "Area") := c(lapply(levels(Area), function(x) as.integer(x == Area)), .(NULL))]

# characters to binary variables
setDT(dataset)[, c(unique(dataset$VehGas), "VehGas") := c(lapply(unique(VehGas), function(x) as.integer(x == VehGas)), .(NULL))]

# extract integer from string
m <- gregexpr('[0-9]+',dataset$Region)
dataset$Region <- as.integer(unlist(regmatches(dataset$Region,m)))

# letters to numbers ordered
# lower case
letter2num <- function(x) {utf8ToInt(x) - utf8ToInt("a") + 1L}
unname(sapply(myletters, letter2num))
# upper case
LETTER2num <- function(x) {utf8ToInt(x) - utf8ToInt("A") + 1L}

# factor levels to numbers
levels(dataset$Region) <- 1:length(levels(dataset$Region))
dataset$Region <- as.numeric(dataset$Region)

# factor levels predict error with class probabilities

feature.names=names(train)

for (f in feature.names) {
  if (class(train[[f]])=="factor") {
    levels <- unique(c(train[[f]]))
    train[[f]] <- factor(train[[f]],
                   labels=make.names(levels))
  }
}



# Scale attributes by dividing by standard deviation (Useful with Gaussian distribution)

# summarize data
summary(iris[,1:4])
# calculate the pre-process parameters from the dataset
preprocessParams <- preProcess(iris[,1:4], method=c("scale"))
# summarize transform parameters
print(preprocessParams)
# transform the dataset using the parameters
transformed <- predict(preprocessParams, iris[,1:4])
# summarize the transformed dataset
summary(transformed)



# Center attributes by subtracting the mean

# summarize data
summary(iris[,1:4])
# calculate the pre-process parameters from the dataset
preprocessParams <- preProcess(iris[,1:4], method=c("center"))
# summarize transform parameters
print(preprocessParams)
# transform the dataset using the parameters
transformed <- predict(preprocessParams, iris[,1:4])
# summarize the transformed dataset
summary(transformed)



# Standardize numeric attributes so they have zero mean and unit variance.

# summarize data
summary(iris[,1:4])
# calculate the pre-process parameters from the dataset
preprocessParams <- preProcess(iris[,1:4], method=c("center", "scale"))
# summarize transform parameters
print(preprocessParams)
# transform the dataset using the parameters
transformed <- predict(preprocessParams, iris[,1:4])
# summarize the transformed dataset
summary(transformed)



# Normalize numeric attributes to the range [0,1]

# summarize data
summary(iris[,1:4])
# calculate the pre-process parameters from the dataset
preprocessParams <- preProcess(iris[,1:4], method=c("range"))
# summarize transform parameters
print(preprocessParams)
# transform the dataset using the parameters
transformed <- predict(preprocessParams, iris[,1:4])
# summarize the transformed dataset
summary(transformed)



## Shift skewed Gaussian

# Box-Cox Transform (attributes must be numeric and >0)

# summarize pedigree and age
summary(PimaIndiansDiabetes[,7:8])
# calculate the pre-process parameters from the dataset
preprocessParams <- preProcess(PimaIndiansDiabetes[,7:8], method=c("BoxCox"))
# summarize transform parameters
print(preprocessParams)
# transform the dataset using the parameters
transformed <- predict(preprocessParams, PimaIndiansDiabetes[,7:8])
# summarize the transformed dataset (note pedigree and age)
summary(transformed)



# Yeo-Johnson Transform (attributes must be numeric)

# load the dataset
data(PimaIndiansDiabetes)
# summarize pedigree and age
summary(PimaIndiansDiabetes[,7:8])
# calculate the pre-process parameters from the dataset
preprocessParams <- preProcess(PimaIndiansDiabetes[,7:8], method=c("YeoJohnson"))
# summarize transform parameters
print(preprocessParams)
# transform the dataset using the parameters
transformed <- predict(preprocessParams, PimaIndiansDiabetes[,7:8])
# summarize the transformed dataset (note pedigree and age)
summary(transformed)


##



# Principal Component Analysis Pre-processing, keeps thoose componentes above the variance threshold (default=0.95), useful for linear and generalized linear regression

# summarize dataset
summary(iris)
# calculate the pre-process parameters from the dataset
preprocessParams <- preProcess(iris, method=c("center", "scale", "pca"))
# summarize transform parameters
print(preprocessParams)
# transform the dataset using the parameters
transformed <- predict(preprocessParams, iris)
# summarize the transformed dataset
summary(transformed)



# Independent Component Analysis Pre-processing (useful for Naive Bayes,...)

# summarize dataset
summary(PimaIndiansDiabetes[,1:8])
# calculate the pre-process parameters from the dataset
preprocessParams <- preProcess(PimaIndiansDiabetes[,1:8], method=c("center", "scale", "ica"), n.comp=5)
# summarize transform parameters
print(preprocessParams)
# transform the dataset using the parameters
transformed <- predict(preprocessParams, PimaIndiansDiabetes[,1:8])
# summarize the transformed dataset
summary(transformed)