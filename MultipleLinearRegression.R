# Data Preprocessing

# Importing the dataset
# setwd("C:\\Users\\Ran\\OneDrive\\job\\Udemy ML R Python\\R")
rm(list=ls(all=TRUE))
dataset = read.csv('50_Startups.csv')
# dataset = dataset(,2;3)

# Taking care of missing data
# dataset$Age = ifelse(is.na(dataset$Age),
#                      ave(dataset$Age, FUN = function(x) mean(x,na.rm = TRUE)),
#                      dataset$Age)
# dataset$Salary = ifelse(is.na(dataset$Salary),
#                      ave(dataset$Salary, FUN = function(x) mean(x,na.rm = TRUE)),
#                      dataset$Salary)

# Encoding categorical data
dataset$State = factor(dataset$State,
                       levels = c('New York','California','Florida'),
                       labels = c(1,2,3))

# Splitting the dataset into the training set and test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 4/5)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature scaling
# training_set[, 2:3] = scale(training_set[, 2:3])
# test_set[, 2:3] = scale(test_set[, 2:3])

#fitting simple linear regressionto the training set
# regressor = lm(formula = Salary ~ YearsExperience,
#                data = training_set)

# Fitting multiple linear regression to the training set
regressor = lm(formula = Profit ~ .,
               data = training_set)
# regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State, 
#                data = training_set)

# predict the test set results
y_pred = predict(regressor, newdata = test_set)

# Building the optimal model using backward elimination
regressor1 = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = dataset)
summary(regressor1)
regressor1 = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
                data = dataset)
summary(regressor1)
regressor1 = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
                data = dataset)
summary(regressor1)
regressor1 = lm(formula = Profit ~ R.D.Spend,
                data = dataset)
summary(regressor1)
y_pred1 = predict(regressor1, newdata = dataset)

# # visualizing the training set results
# library(ggplot2)
# ggplot() +
#   geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
#              colour = 'red') +
#   geom_line(aes(x = training_set$YearsExperience, y =predict(regressor, newdata = training_set)), 
#             colour='blue') +
#   ggtitle('Salary vs Experience (Training set)')+
#   xlab('Years of experience')+
#   ylab('Salary')
# 
# # visualizing the test set results
# ggplot() +
#   geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
#              colour = 'red') +
#   geom_line(aes(x = training_set$YearsExperience, y =predict(regressor, newdata = training_set)), 
#             colour='blue') +
#   ggtitle('Salary vs Experience (Test set)')+
#   xlab('Years of experience')+
#   ylab('Salary')
