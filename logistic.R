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
