# load libraries
library(mlbench)
library(caret)
# load the dataset
data(PimaIndiansDiabetes)
# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# CART
set.seed(7)
fit.cart <- train(diabetes~., data=PimaIndiansDiabetes, method="rpart", trControl=control)
# LDA
set.seed(7)
fit.lda <- train(diabetes~., data=PimaIndiansDiabetes, method="lda", trControl=control)
# SVM
set.seed(7)
fit.svm <- train(diabetes~., data=PimaIndiansDiabetes, method="svmRadial", trControl=control)
# kNN
set.seed(7)
fit.knn <- train(diabetes~., data=PimaIndiansDiabetes, method="knn", trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(diabetes~., data=PimaIndiansDiabetes, method="rf", trControl=control)
# collect resamples
results <- resamples(list(CART=fit.cart, LDA=fit.lda, SVM=fit.svm, KNN=fit.knn, RF=fit.rf))




# Compare models using a table summary

# summarize differences between modes
summary(results)



# Compare models using box and whisker plots

# box and whisker plots to compare models
scales <- list(x=list(relation="free"), y=list(relation="free"))
bwplot(results, scales=scales)



# Compare models using density plots plots

# density plots of accuracy
scales <- list(x=list(relation="free"), y=list(relation="free"))
densityplot(results, scales=scales, pch = "|")



# Compare models using dotplots (mean and the 95% confidence interval)

# dot plots of accuracy
scales <- list(x=list(relation="free"), y=list(relation="free"))
dotplot(results, scales=scales)



# Compare models using parallel plots (within cross-validation trials)

# parallel plots to compare models 
parallelplot(results)



# Compare models using scatterplot matrix (uncorrelated better for combining)

# pair-wise scatterplots of predictions to compare models
splom(results)
# pair-wise scatterplots of accuracy measures to compare models
splom(results, variables="metrics")



# Compare models using xyplot (zoom one in scatterplot)

# xyplot plots to compare models
xyplot(results, models=c("LDA", "SVM"))



# Calculate statistical significance of difference between model predictions

# difference in model predictions
diffs <- diff(results)
# summarize p-values for pair-wise comparisons
summary(diffs)
# plot of differences
scales <- list(x=list(relation="free"), y=list(relation="free"))
bwplot(diffs, scales=scales)
# t-test between two models
compare_models(fit.svm, fit.lda)