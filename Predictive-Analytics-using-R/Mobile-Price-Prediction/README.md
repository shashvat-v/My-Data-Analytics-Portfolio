# Objective
The objective of this project is to find the best machine learning algorithm to accurately classify mobile phone into the following categories:
1. 0 - indicating low cost category
2. 1 - medium cost category
3. 2 - high cost category
4. 3 - very high cost category
Based on certain attributes like memory, screen size, number of cores etc.

# Understanding the Dataset ‘MobilePrices’
The dataset ‘MobilePrices’ contains the details and data regarding the various features and specifications of a mobile phone.
The dataset consists of 20 variables in total - including 19 features of a mobile phone and 1 class label i.e., Price Range. The dataset contains 2001 entries in each column/ variable.
The variables can be classified into 2 types:
Continuous variables: -
1.	Battery_power
2.	Clock_speed
3.	Int_memory
4.	M_dep
5.	Mobile_wt
6.	N_cores
7.	Pc
8.	Px_height
9.	Px_weight
10.	Ram
11.	Sc_h
12.	Sc_w
13.	talk_time
Categorical variables: -
1.	Blue
2.	Dual_sim
3.	Four_g
4.	Three_g
5.	Touch_screen
6.	Wifi
7.	Price_range


# Data Cleaning Tasks and Techniques
Normality testing:
For testing the normality of data, the skewness and kurtosis approach was followed. The skewness and kurtosis was tested for the 13 continuous variables (as listed above). It was noticed that the values of skewness and kurtosis were in range for all 13 variables (skewness 1 & -1 , kurtosis 4 & -4). Considering these values, no technique of data transformation was applied here.
Checking for outliers:
By applying the boxplot function, it was observed that the variable px_height (pixel height) contains outliers. However, these outliers were not serious. No process of treating the outliers was conducted in this case.
Checking the data set for missing values:
After applying the map function, no missing values were found in the data. Hence, the process of imputing missing values was not applicable in this dataset.

# Algorithms used for creating the ML Models
From the dataset, I identified that the dependent variable i.e., price range, was categorical and had four categories namely, Low Cost, Medium Cost, High Cost and Very High Cost, denoted by 0, 1, 2 and 3 respectively. Given these facts, I concluded that I could not use Linear regression method, because it is used when the DV is continuous and I could also not use Logistic Regression Method as there were more than two categories for the DV. Therefore, for creating the predictive models I have used three different algorithms. These are:
1.	Naive Bayes Classifier
2.	Decision Tree
3.	Random Forest

# Naive Bayes Classifier:
Naive Bayes Classifier is a machine learning algorithm that is used for classification tasks, such as determining whether a given input belongs to a certain category or not. It is based on the Bayes' theorem, which states that the probability of a hypothesis (category) given the evidence (input data) is proportional to the probability of the evidence given the hypothesis, multiplied by the prior probability of the hypothesis.
The "naive" assumption of Naive Bayes Classifier is that the features (attributes) of the input are independent of each other, which simplifies the computation of probabilities. The algorithm calculates the probability of each possible category based on the probability of each feature given that category, and then selects the category with the highest probability as the output.
For Naive Bayes I have created the following model:

Model1 <- train(data=training, price_range~., method="naive_bayes")

Using the summary(Model1) function the following was the output:

For making the confusion matrix for model 1 I first generated predictions on the testing data set using the predict function and confusion matrix.

p<-predict(Model1, newdata = testing)
confusionMatrix(p, testing$price_range)

# Result
Out of the total 400 values in the testing dataset, 88 are correctly predicted in category 0 (Low Cost), 77 are correctly predicted in Category 1 (Medium Cost), 72 are correctly predicted in Category 2 (High Cost) and 85 are correctly predicted in Category 3 (Very High Cost),
- Overall model accuracy is 80.5%
- The sensitivity is highest for Category 0.
- The specificity is highest for Category 0.

# Decision Tree
# Gini Index
For Decision Tree, I have created two models:
The first, using the Gini Index technique. We have named this model, Model 2 and the R - code is as follows:

Model2 <- train(price_range~., data=training, method="rpart")

For creating the Decision Tree diagram:

rpart.plot(Model2$finalModel)

The attribute ‘ram’ is selected automatically based on the Gini Index method.
The threshold values of attributes are 2247 for the first node and 1107 for the second node, which are automatically determined by the rpart method.
Interpretation: If ram is greater than 2247 the mobile phone lies in category 3 i.e. Very High Cost. If it is less than 2247 then we go to the second node. If ram is greater than 1107 then the mobile phone lies in category 1 i.e. Medium Cost and if it is less than 1107 then the mobile phone lies in category 0 or Low Cost.

For making the confusion matrix for model 2 I first generated predictions on the testing data set using the predict function.

predpr2<-predict(Model2, newdata = testing)

And then I created the confusion matrix.

confusionMatrix(predpr2, testing$price_range)

Out of the total 400 values in the testing dataset, 85 are correctly predicted in category 0 (Low Cost), 79 are correctly predicted in Category 1 (Medium Cost), 0 are correctly predicted in Category 2 (High Cost) and 100 are correctly predicted in Category 3 (Very High Cost),
Overall model accuracy is 66%
The sensitivity is highest for Category 3.
The specificity is highest for Category 2.

# Information Gain
The second decision tree model has been created using the Information Gain Technique and we have named this model, Model 3. The R - code is as follows:

Model3 <- train(price_range~., data=training, method="rpart", parms = list(split = "information"))

For creating the Decision Tree diagram:

rpart.plot(Model3$finalModel)

The attribute ‘ram’ is selected automatically based on the Information 
Gain method.
The threshold values of attributes are 2247 for the first node and 1184 for the second node, which are automatically determined by the rpart method.
Interpretation: If ram is greater than 2247 the mobile phone lies in category 3 i.e. Very High Cost. If it is less than 2247 then we go to the second node. If ram is greater than 1184 then the mobile phone lies in category 1 i.e. Medium Cost and if it is less than 1184 then the mobile phone lies in category 0 or Low Cost.

For making the confusion matrix for model 3 I first generated predictions on the testing data set using the predict function.

predpr3<-predict (Model3, newdata = testing)

And then I created the confusion matrix.

confusionMatrix(predpr3, testing$price_range)

Out of the total 400 values in the testing dataset, 86 are correctly predicted in category 0 (Low Cost), 73 are correctly predicted in Category 1 (Medium Cost), 0 are correctly predicted in Category 2 (High Cost) and 100 are correctly predicted in Category 3 (Very High Cost),
Overall model accuracy is 64.75%
The sensitivity is highest for Category 3.
The specificity is highest for Category 2.

# Random Forest
# First RF Model
The model is created by dividing the training and testing data in 80 percent and 20 percent split and taking all the variables.
Number of trees = 500 (Default)
No. of variables in each split = 10 
The model tested mtry values for 2 , 10 and 19 out of which the final value used in the model was 10 with an accuracy of 87.9%.

Model Accuracy
For making the confusion matrix for model 4 I first generated predictions on the testing data set using the predict function.

predpr4<-predict(Model4, newdata = testing)

And then created the confusion matrix.

confusionMatrix(predpr4, testing$price_range)

Out of the total 400 values in the testing dataset, 97 are correctly predicted in category 0 (Low Cost), 93 are correctly predicted in Category 1 (Medium Cost), 86 are correctly predicted in Category 2 (High Cost) and 94 are correctly predicted in Category 3 (Very High Cost),
Overall model accuracy is 92.5%
The sensitivity is highest for Category 0 . 
The specificity is highest for Category 0 very closely followed by category 3. 

# Second RF Model
After model 4 , by using function varimp(), I determined the variables with most importance in the model and created various models by taking different 
combinations.
Code:

Model5 <- train(price_range~ ram + battery_power + px_height + px_width + mobile_wt, data=training, method="rf")

I observed that by using 5 variables i.e. ram, battery power , pixel height , pixel width and 
mobile weight. The accuracy of the model increased to 94 %.
Number of Trees = 500
No. of variables in each split = 2
The model tested mtry values for 2 , 3 and 5 out of which the final value used was mtry = 2 with accuracy of 90 percent. 

Model Accuracy
For making the confusion matrix for model 5 I first generated predictions on the testing data set using the predict function.

predpr5<-predict(Model5, newdata = testing)

And then we created the confusion matrix.

confusionMatrix(predpr5, testing$price_range)

Out of the total 400 values in the testing dataset, 96 are correctly predicted in category 0 (Low Cost), 95 are correctly predicted in Category 1 (Medium Cost), 89 are correctly predicted in Category 2 (High Cost) and 96 are correctly predicted in Category 3 (Very High Cost)
Overall model accuracy is 94%
The sensitivity is highest for Category 0 and Category 4 . 
The specificity is highest for Category 0 very closely followed by category 3.
