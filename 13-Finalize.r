# Make predictions using caret model

# load libraries
library(caret)
library(mlbench)
# load dataset
data(PimaIndiansDiabetes)
# create 80%/20% for training and validation datasets
set.seed(9)
validation_index <- createDataPartition(PimaIndiansDiabetes$diabetes, p=0.80, list=FALSE)
validation <- PimaIndiansDiabetes[-validation_index,]
training <- PimaIndiansDiabetes[validation_index,]
# train a model and summarize model
set.seed(9)
control <- trainControl(method="cv", number=10)
fit.lda <- train(diabetes~., data=training, method="lda", metric="Accuracy", trControl=control)
print(fit.lda)
print(fit.lda$finalModel)
# estimate skill on validation dataset
set.seed(9)
predictions <- predict(fit.lda, newdata=validation)
confusionMatrix(predictions, validation$diabetes)



# Save and Load model

# load libraries
library(caret)
library(mlbench)
library(randomForest)
library(doParallel)
registerDoParallel(cores=4)
# load dataset
data(Sonar)
set.seed(7)
# create 80%/20% for training and validation datasets
validation_index <- createDataPartition(Sonar$Class, p=0.80, list=FALSE)
validation <- Sonar[-validation_index,]
training <- Sonar[validation_index,]
# create final standalone model using all training data
set.seed(7)
final_model <- randomForest(Class~., training, mtry=2, ntree=2000)
# save the model to disk
saveRDS(final_model, "./final_model.rds")

# later...

# load the model
super_model <- readRDS("./final_model.rds")
print(super_model)
# make a predictions on "new data" using the final model
final_predictions <- predict(super_model, validation[,1:60])
confusionMatrix(final_predictions, validation$Class)