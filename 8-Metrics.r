# load libraries
library(caret)
library(mlbench)
# load the dataset
data(PimaIndiansDiabetes)
data(longley)



# Accuracy and Kappa metric

# prepare resampling method
traincontrol <- trainControl(method="cv", number=5)
set.seed(1)
fit <- train(diabetes~., data=PimaIndiansDiabetes, method="glm", metric="Accuracy", trControl=traincontrol)
# display results
print(fit)



# RMSE and Rsquared metric

# prepare resampling method
traincontrol <- trainControl(method="cv", number=5)
set.seed(1)
fit <- train(Employed~., data=longley, method="lm", metric="RMSE", trControl=traincontrol)
# display results
print(fit)



# ROC: AUC, sensitivity, specificity metrics (for binary clasification)

# prepare resampling method
traincontrol <- trainControl(method="cv", number=5, classProbs=TRUE, summaryFunction=twoClassSummary)
set.seed(1)
fit <- train(diabetes~., data=PimaIndiansDiabetes, method="glm", metric="ROC", trControl=traincontrol)
# display results
print(fit)



# MultiNomialLogLoss Metric (binary or multiclass classification)

# prepare resampling method
traincontrol <- trainControl(method="cv", number=5, classProbs=TRUE, summaryFunction=mnLogLoss)
set.seed(1)
fit <- train(Species~., data=iris, method="rpart", metric="logLoss", trControl=traincontrol)
# display results
print(fit)
