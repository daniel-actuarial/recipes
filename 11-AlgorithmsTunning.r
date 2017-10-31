# load libraries
library(mlbench)
library(caret)
# load the dataset
data(iris)
# load the dataset
data(PimaIndiansDiabetes)
# Load Dataset
data(Sonar)



# Select the best tuning configuration

# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# CART
set.seed(7)
tunegrid <- expand.grid(.cp=seq(0,0.1,by=0.01))
fit.cart <- train(diabetes~., data=PimaIndiansDiabetes, method="rpart", metric="Accuracy", tuneGrid=tunegrid, trControl=control)
# display the best configuration
print(fit.cart$bestTune)



# Randomly search algorithm parameters

# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3, search="random")
# train the model
model <- train(Species~., data=iris, method="lvq", trControl=control, tuneLength=25)
# summarize the model
print(model)
# plot the effect of parameters on accuracy
plot(model)



# Tune algorithm parameters using an automatic grid search.

# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# train the model
model <- train(Species~., data=iris, method="lvq", trControl=control, tuneLength=5)
# summarize the model
print(model)
# plot the effect of parameters on accuracy
plot(model)



# Manually search parametres

# load the packages
library(randomForest)
# Load Dataset
dataset <- Sonar
x <- dataset[,1:60]
y <- dataset[,61]
seed <- 7
metric <- "Accuracy"
# Manual Search
trainControl <- trainControl(method="repeatedcv", number=10, repeats=3, search="grid")
tunegrid <- expand.grid(.mtry=c(sqrt(ncol(x))))
modellist <- list()
for (ntree in c(1000, 1500, 2000, 2500)) {
	set.seed(seed)
	fit <- train(Class~., data=dataset, method="rf", metric=metric, tuneGrid=tunegrid, trControl=trainControl, ntree=ntree)
	key <- toString(ntree)
	modellist[[key]] <- fit
}
# compare results
results <- resamples(modellist)
summary(results)
dotplot(results)



# Tune algorithm parameters using a manual grid search.

# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# design the parameter tuning grid
grid <- expand.grid(size=c(5,10,20,50), k=c(1,2,3,4,5))
# train the model
model <- train(Species~., data=iris, method="lvq", trControl=control, tuneGrid=grid)
# summarize the model
print(model)
# plot the effect of parameters on accuracy
plot(model)



# Custom Parameter Search

# load the packages
library(randomForest)
# configure multi-core (on Windows)
library(doParallel)
registerDoParallel(cores=4)

# define the custom caret algorithm (wrapper for Random Forest)
customRF <- list(type="Classification", library="randomForest", loop=NULL)
customRF$parameters <- data.frame(parameter=c("mtry", "ntree"), class=rep("numeric", 2), label=c("mtry", "ntree"))
customRF$grid <- function(x, y, len=NULL, search="grid") {}
customRF$fit <- function(x, y, wts, param, lev, last, weights, classProbs, ...) {
  randomForest(x, y, mtry=param$mtry, ntree=param$ntree, ...)
}
customRF$predict <- function(modelFit, newdata, preProc=NULL, submodels=NULL)
   predict(modelFit, newdata)
customRF$prob <- function(modelFit, newdata, preProc=NULL, submodels=NULL)
   predict(modelFit, newdata, type = "prob")
customRF$sort <- function(x) x[order(x[,1]),]
customRF$levels <- function(x) x$classes

# Load Dataset
dataset <- Sonar
seed <- 7
metric <- "Accuracy"

# train model
trainControl <- trainControl(method="repeatedcv", number=10, repeats=3)
tunegrid <- expand.grid(.mtry=c(1:15), .ntree=c(1000, 1500, 2000, 2500))
set.seed(seed)
custom <- train(Class~., data=dataset, method=customRF, metric=metric, tuneGrid=tunegrid, trControl=trainControl)
print(custom)
plot(custom)