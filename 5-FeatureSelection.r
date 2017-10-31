# load the libraries
library(mlbench)
library(caret)
# load the dataset
data(PimaIndiansDiabetes)
# load the data
data(Sonar)



# Rank features by their importance.

# prepare training scheme
control <- trainControl(method="cv", number=10)
# train the model
model <- train(diabetes~., data=PimaIndiansDiabetes, method="lvq", preProcess="scale", trControl=control)
# estimate variable importance
importance <- varImp(model, scale=FALSE)
# summarize importance
print(importance)
# plot importance
plot(importance)



# Identify and remove highly correlated features

# calculate correlation matrix
correlationMatrix <- cor(PimaIndiansDiabetes[,1:8])
# find attributes that are highly corrected (ideally >0.75)
cutoff <- 0.50
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=cutoff)
# create a new dataset without highly corrected features
dataset <- PimaIndiansDiabetes[,-highlyCorrelated]



# Use Recursive Feature Elimination and to select features

# define the control using a random forest selection function
control <- rfeControl(functions=rfFuncs, method="cv", number=10)
# run the RFE algorithm
x <- Sonar[,1:60]
y <- Sonar[,61]
sizes <- c(10,20,30,40,50,60)
results <- rfe(x, y, sizes=sizes, rfeControl=control)
# summarize the results
print(results)
# list the chosen features
predictors(results)
# plot accuracy versus the number of features
plot(results, type=c("g", "o"))