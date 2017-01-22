# Data Preprocessing

# Importing the dataset
# setwd("C:\\Users\\Ran\\OneDrive\\job\\Udemy ML R Python\\R")
rm(list=ls(all=TRUE))
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[,2:3]

# Taking care of missing data
# dataset$Age = ifelse(is.na(dataset$Age),
#                      ave(dataset$Age, FUN = function(x) mean(x,na.rm = TRUE)),
#                      dataset$Age)
# dataset$Salary = ifelse(is.na(dataset$Salary),
#                      ave(dataset$Salary, FUN = function(x) mean(x,na.rm = TRUE)),
#                      dataset$Salary)

# Encoding categorical data
# dataset$State = factor(dataset$State,
#                        levels = c('New York','California','Florida'),
#                        labels = c(1,2,3))

# Splitting the dataset into the training set and test set
# library(caTools)
# set.seed(123)
# split = sample.split(dataset$Profit, SplitRatio = 4/5)
# training_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)

# Feature scaling
# training_set[, 2:3] = scale(training_set[, 2:3])
# test_set[, 2:3] = scale(test_set[, 2:3])

#fitting simple linear regressionto the training set
lin_reg = lm(formula = Salary ~ Level,
               data = dataset)

# Fitting polynomial regression to the training set
dataset$Level2 = dataset$Level^2
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
poly_reg = lm(formula = Salary ~ .,
              data = dataset)

# predict the test set results
y_pred = predict(poly_reg, newdata = dataset)

# Building the optimal model using backward elimination
# regressor1 = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
#                data = dataset)
# summary(regressor1)
# regressor1 = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
#                 data = dataset)
# summary(regressor1)
# regressor1 = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
#                 data = dataset)
# summary(regressor1)
# regressor1 = lm(formula = Profit ~ R.D.Spend,
#                 data = dataset)
# summary(regressor1)
# y_pred1 = predict(regressor1, newdata = dataset)

# # visualizing the polynomial fitting results (with high resolution)
library(ggplot2)
x_grid = seq(min(dataset$Level),max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y =predict(poly_reg, newdata = dataset)),
            colour='blue') +
  ggtitle('Salary vs Level')+
  xlab('Level')+
  ylab('Salary')

# visualizing the test set results
# ggplot() +
#   geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
#              colour = 'red') +
#   geom_line(aes(x = training_set$YearsExperience, y =predict(regressor, newdata = training_set)),
#             colour='blue') +
#   ggtitle('Salary vs Experience (Test set)')+
#   xlab('Years of experience')+
#   ylab('Salary')

# Predicting a new result with linear regression
y_pred_lin = predict(lin_reg, newdata = dataset[,1:2])
y_pred_lin = predict(lin_reg, newdata = data.frame(Level = 6.5))

# predicting a new result with polynomial regression
y_pred_poly = predict(poly_reg, newdata = dataset)
y_pred_poly = predict(poly_reg, newdata = data.frame(Level = 6.5,
                                                     Level2 = 6.5^2,
                                                     Level3 = 6.5^3,
                                                     Level4 = 6.5^4))
