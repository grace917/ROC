setwd("C:\\Users\\Desktop")
raw_data<-read.csv("NPP.csv")
head(raw_data)

set.seed(1)
n<-nrow(raw_data)
Indicator<-runif(n,0,1)>0.6 #generate n*1 random number between [0,1] and using 0.6 as threshold
train<-raw_data[Indicator==FALSE,] #random number <= 0.6 as train set
test<-raw_data[Indicator==TRUE,]   #random number > 0.6 as test set

##########
#fitting#
##########
install.packages("glmnet")
library(glmnet)
fit<-glm(Y~X1+X2+X3+X4,data=train,family=binomial()) 

############
#predicting#
############
pred<-predict(fit, newdata=test, type="response") 

##############
#plotting ROC#
##############
install.packages("ROCR")
library(ROCR)

predtrn<-prediction(pred, test$Y)
performance(predtrn, "auc")@y.values[[1]]
plot(perfromance(predtrn, "tpr", "fpr"), main="ROC")









#run on smaller sample
test<-raw_data[c(1:10),]
set.seed(1)
n<-nrow(test)   #number of test's number of row
Test<-runif(n,0,1)>0.6   #generate n random number using uniform[0,1], return "TRUE" if this random number>0.6 and "False" else, give this stream of "TRUE/FALSE" vector to Test 
#runif(10,0,1)>0.6
#>[1] FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE
#cannot add ":" in the y, like [Indicator==FALSE,:] 



 


