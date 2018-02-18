df=read.table("mpg.data.txt")
#Data Preprocessing
colnames(df)=c("mpg","cyl","disp","hpwr","wght","accl","yr","org","car")
head(df)
df=df[-1,]
head(df)
rownames(df)=1:nrow(df)
head(df)
tail(df)
str(df)
df$hpwr[df$hpwr=="?"]=NA
table(is.na(df$hpwr))
df=df[!(is.na(df$hpwr)),]
str(df)
df$mpg=as.numeric(as.character(df$mpg))
df$cyl=as.numeric(as.character(df$cyl))
df$disp=as.numeric(as.character(df$disp))
df$hpwr=as.numeric(as.character(df$hpwr))
df$wght=as.numeric(as.character(df$wght))
df$accl=as.numeric(as.character(df$accl))
df$yr=as.numeric(as.character(df$yr))
df$org=as.numeric(as.character(df$org))
str(df)

#Exploratory Analysis
pairs(df[1:8])
cor(df[1:8])
summary(df[1:8])

#Creating Box plots to identify symmetry & skewness
par(mfrow=c(2,2))
boxplot(df[1:2], main="Box plot for mpg & cyl")
boxplot(df[3:4], main="Box plot for disp & hpwr")
boxplot(df[5:6], main="Box plot for wght & accl")
boxplot(df[7:8], main="Box plot for yr & org")
#From above graphs, mpg, wght & hpwr are symmetric. disp & yr are skewed. 

#Scatter plot for above 5 variables
pairs(df[1:8])
cor(df[c(-9)])

#Identifying the Best Fit Model:
mod1= lm(mpg~disp+hpwr+wght+yr+org, data=df)
summary(mod1)

autofit1= lm(mpg~. -car, data=df)
summary(autofit1)
autofit2=lm(mpg~cyl+hpwr+accl, data=df)
summary(autofit2)
#Here R^2 dropped instead of increasing it.
autofit3=lm(mpg~cyl+disp+hpwr+wght+yr+org, data=df)
summary(autofit3)
autofit4=lm(mpg~cyl+disp+hpwr+wght+org, data=df)
summary(autofit4)
autofit5=lm(mpg~disp+wght+yr+org, data=df)
summary(autofit5)
autofit6=lm(mpg~I(cyl^2)+disp+I(hpwr^2)+wght+yr+org+I(accl^2), data=df)
summary(autofit6)
autofit7=lm(mpg~disp+I(hpwr^2)+wght+yr+org+I(accl^2), data=df)
summary(autofit7)
autofit8=lm(mpg~I(disp^2)+I(hpwr^2)+wght+yr+org+I(accl^2), data=df)
summary(autofit8)
autofit9=lm(mpg~I(disp^2)+I(hpwr^2)+I(hpwr^3)+wght+yr+org+I(accl^2), data=df)
summary(autofit9)
autofit10=lm(mpg~I(disp^2)+I(hpwr^2)+I(hpwr^3)+wght+yr+org, data=df)
summary(autofit10)
autofit11=lm(mpg~I(cyl^3)+I(disp^1)+I(disp^2)+I(hpwr^2)+I(hpwr^3)+wght+yr+org, data=df)
summary(autofit11)

#Among all above models, autofit11 seems to have greater R^2 which is 85.36% including all smallest P values.
#Therefore, this is assumed to be the best model.
par(mfrow=c(2,2))
plot(autofit11)
# Residuals vs fitted graph: We found equally spread residuals around a horizontal line without 
#distinct patterns, that is a good indication that we don't have non-linear relationships.

#Normal Q-Q graph: The residuals follow a straight line well & they dont deviate severely, then
# It is a good indication that we don't have non-linear relationships

#scale location graph: This plot shows if residuals are spread equally along the ranges of predictors.
#It helps to check  the assumption of equal variance (homoscedasticity).
#As there is horizontal line with equally (randomly) spread points, its good model.

#Residuals vs Leverage graph: In this model, there is no  influential case as we see cook's 
#distance line barely. It implies that all the cases are well inside of cook's distance.

set.seed(100)  # setting seed to reproduce results of random sampling
trainingRowIndex= sample(1:nrow(df), 0.8*nrow(df))  # row indices for training data
trainData= df[trainingRowIndex, ]  # model training data
str(trainData)
testData= df[-trainingRowIndex, ]
str(testData)

predTest= predict(autofit11,testData)
head(predTest)
actualsPreds= data.frame(cbind(actuals=testData$mpg, predicteds=predTest))
actualsPreds
correlationAccuracy=cor(actualsPreds)
correlationAccuracy
