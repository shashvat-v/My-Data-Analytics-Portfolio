# Predictive Analytics Component 4
# Group 9
# Reference file - MobilePrices
# Group Members:
# Shashvat Vishnoi - 20021021488
# Vansh Hablani - 20021021567
# Tanvi Verma - 20021021603
# Skand Sharma - 20021021249

#############################################################

# Packages Used

library(moments)
library(caret)
library(purrr)
library(imputeMissings)
library(naivebayes)
library(rpart.plot)
library(randomForest)

#############################################################

MP<-MobilePrices
str(MP)
MP<-as.data.frame(MP) #Converted to Dataframe

#############################################################

# Testing for Normality

skewness(MP$battery_power)
skewness(MP$clock_speed)
skewness(MP$int_memory)
skewness(MP$m_dep)
skewness(MP$mobile_wt)
skewness(MP$n_cores)
skewness(MP$pc)
skewness(MP$px_height)
skewness(MP$px_width)
skewness(MP$ram)
skewness(MP$sc_h)
skewness(MP$sc_w)
skewness(MP$talk_time) #Skewness normal in all variable

kurtosis(MP$battery_power)
kurtosis(MP$clock_speed)
kurtosis(MP$int_memory)
kurtosis(MP$m_dep)
kurtosis(MP$mobile_wt)
kurtosis(MP$n_cores)
kurtosis(MP$pc)
kurtosis(MP$px_height)
kurtosis(MP$px_width)
kurtosis(MP$ram)
kurtosis(MP$sc_h)
kurtosis(MP$sc_w)
kurtosis(MP$talk_time) #Kurtosis normal in all variables

#############################################################

# Changing categorical variables to factors

MP$blue<-as.factor(MP$blue)
MP$dual_sim<-as.factor(MP$dual_sim)
MP$four_g<-as.factor(MP$four_g)
MP$three_g<-as.factor(MP$three_g)
MP$touch_screen<-as.factor(MP$touch_screen)
MP$four_g<-as.factor(MP$four_g)
MP$wifi<-as.factor(MP$wifi)
MP$price_range<-as.factor(MP$price_range)

#############################################################

# Data Cleaning

# Duplicated Values
MP[duplicated(MP),] #No Duplicate values found

# Identifying Outliers
boxplot(MP)
boxplot(MP$px_height) #Non-serious outliers, no treatment required

# Missing Values
map(MP, ~sum(is.na(.))) #No Missing values


#############################################################

# Data Partition

set.seed(100)
Train <- createDataPartition(MP$price_range, p=0.8, list=FALSE)
training <- MP[ Train, ]
testing <- MP[ -Train, ]

#############################################################
# Model creation using Naive Bayes Classifier - Model 1

Model1 <- train(data=training, price_range~., method="naive_bayes")
summary(Model1)

# Confusion Matrix
p<-predict(Model1, newdata = testing)
confusionMatrix(p, testing$price_range)

#############################################################
# Model creation using Decision Tree - Models 2&3

Model2 <- train(price_range~., data=training, method="rpart")

Model3 <- train(price_range~., data=training, method="rpart", parms = list(split = "information"))

# Plotting Decision Trees
rpart.plot(Model2$finalModel)
rpart.plot(Model3$finalModel)

# Prediction for test data
predpr2<-predict(Model2, newdata = testing)
predpr3<-predict(Model3, newdata = testing)

# Fitness metrics for validation
confusionMatrix(predpr2, testing$price_range)
confusionMatrix(predpr3, testing$price_range)

#############################################################

# Model creation using Random Forest - Models 4&5

Model4 <- train(price_range~., data=training, method="rf")
Model4
Model4$finalModel
varImp(Model4)

# Prediction for test data
predpr4<-predict(Model4, newdata = testing)

# Fitness metrics for validation
confusionMatrix(predpr4, testing$price_range)

# Random Forest model after removing insignificant attributes.
Model5 <- train(price_range~ ram + battery_power + px_height + px_width + mobile_wt, data=training, method="rf")
Model5
Model5$finalModel
varImp(Model5)

# Prediction for test data
predpr5<-predict(Model5, newdata = testing)

# Fitness metrics for validation
confusionMatrix(predpr5, testing$price_range)

# END
#############################################################
