# load the libraries
library(caret)
# load the iris dataset
data(iris)




# Train/test split.

# load the libraries
library(klaR)
# define an 80%/20% train/test split of the dataset
split=0.80
trainIndex <- createDataPartition(iris$Species, p=split, list=FALSE)
data_train <- iris[ trainIndex,]
data_test  <- iris[-trainIndex,]
# train a naive bayes model
fit <- NaiveBayes(Species~., data=data_train)
# make predictions
x_test <- data_test[,1:4]
y_test <- data_test[,5]
predictions <- predict(fit, x_test)
# summarize results
confusionMatrix(predictions$class, y_test)



# Bootstrap (resampling with reselection).

# define training control
train_control <- trainControl(method="boot", number=100)
# train the model
fit <- train(Species~., data=iris, trControl=train_control, method="nb")
# summarize results
print(fit)



# K-fold cross validation.

# define training control
train_control <- trainControl(method="cv", number=10)
# train the model
fit <- train(Species~., data=iris, trControl=train_control, method="nb")
# summarize results
print(fit)



# Estimate accuracy using repeated k-fold cross validation.

# define training control
train_control <- trainControl(method="repeatedcv", number=10, repeats=3)
# train the model
fit <- train(Species~., data=iris, trControl=train_control, method="nb")
# summarize results
print(fit)



# Estimate accuracy using a leave one out cross validation.

# define training control
train_control <- trainControl(method="LOOCV")
# train the model
fit <- train(Species~., data=iris, trControl=train_control, method="nb")
# summarize results
print(fit)
