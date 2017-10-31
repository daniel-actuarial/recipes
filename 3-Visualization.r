## Univariate Visualization

### Numerical attributes
# load libraries
library(data.table)
# load the data
data(iris)
iris <- data.table(iris)
# sub-dataset of numerical variables
iris_num <- iris[, names(iris)[sapply(iris, is.numeric)], with=FALSE]


#### Histograms
# number of columns
n <- 4
# number of rows
m <- ceiling(ncol(iris_num)/n)
# attribute columns
atts <- c(1:ncol(iris_num))
# create histograms for each attribute
par(mfrow=c(m,n))
for(i in atts) {
	hist(iris_num[[i]], main=names(iris_num)[i])
}



#### Density Plots
# load libraries
library(lattice)
# number of columns
n <- 4
# number of rows
m <- ceiling(ncol(iris_num)/n)
# attribute columns
atts <- c(1:ncol(iris_num))
# create a panel of simpler density plots by attribute
par(mfrow=c(m,n))
for(i in atts) {
	plot(density(iris_num[[i]]), main=names(iris_num)[i])
}



#### Box And Whisker Plots

# number of columns
n <- 4
# number of rows
m <- ceiling(ncol(iris_num)/n)
# attribute columns
atts <- c(1:ncol(iris_num))
# Create separate boxplots for each attribute
par(mfrow=c(m,n))
for(i in atts) {
	boxplot(iris_num[[i]], main=names(iris_num)[i])
}



### Categorical attributes
# load libraries
library(data.table)
library(mlbench)
# load the dataset
data(BreastCancer)
# load the data
data(BreastCancer)
BreastCancer <- data.table(BreastCancer)
# strings to factor
BreastCancer = BreastCancer[,-1] %>% mutate_if(is.character,funs(factor(.)))
# sub-dataset of categorical variables
BreastCancer_cat <- BreastCancer[, names(BreastCancer)[sapply(BreastCancer, is.factor)], with=FALSE]

# Plot Factor

# number of rows
m <- 3 
# number of columns
n <- 3
# create a bar plot of each categorical attribute
par(mfrow=c(m,n))
for(i in 1:(ncol(BreastCancer_cat)-1)) {
	counts <- table(BreastCancer_cat[,i])
	name <- names(BreastCancer_cat)[i]
	barplot(counts, main=name)
}



### Plot missing data

# load libraries
library(Amelia)
library(mlbench)
# load dataset
data(Soybean)
# create a missing map
par(mfrow=c(1,1))
missmap(Soybean, col=c("black", "grey"), legend=FALSE)



## Multiivariate Visualization

### Correlation Plot

# load library
library(corrplot)
# load the data
data(iris)
# number of rows
m <- 1 
# number of columns
n <- 4
# attribute columns
atts <- c(m:n)
# calculate correlations
correlations <- cor(iris[,atts])
# create correlation plot
corrplot(correlations, method="circle")



### Multivariate Scatterplot Matrix

# load the data
data(iris)
# pair-wise scatterplots of all 4 attributes
pairs(iris)



### Multivariate Scatterplot Matrix By Class

# load the data
data(iris)
# pair-wise scatterplots colored by class
pairs(Species~., data=iris, col=iris$Species)



### Create a density plot for each variable-class combination.

# load the library
library(caret)
# load the data
data(iris)
# density plots for each attribute by class value
x <- iris[,1:4]
y <- iris[,5]
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)



### Create a box and whisker plots for each variable organized by class.

# load the caret library
library(caret)
# load the iris dataset
data(iris)
# box and whisker plots for each attribute by class value
x <- iris[,1:4]
y <- iris[,5]
featurePlot(x=x, y=y, plot="box")