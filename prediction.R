
bitcoin<-read.csv(file.choose(),header = T)
bitcoin$Date<-as.Date(bitcoin$Date)

training<-bitcoin[bitcoin$Date<='2016-05-31',]
test<-bitcoin[bitcoin$Date>'2016-05-31',]

arModel<-ar(training$Close.Price)
arModelPrediction<-predict(arModel,n.ahead = 29)


plot(test$Close.Price,type="b",ylim = c(1,1000),xlab = "Hours",
     ylab = "USD", main = "Prediction for July 2016")
lines(as.numeric(arModelPrediction$pred),pch=2,type = "b")


arModel<-ar(training$Close.Price,model="yule-walker")
arModelPrediction<-predict(arModel,n.ahead = 29)
lines(as.numeric(arModelPrediction$pred),pch=3,type = "b")

arModel<-ar(training$Close.Price,model="burg")
arModelPrediction<-predict(arModel,n.ahead = 29)
lines(as.numeric(arModelPrediction$pred),pch=4,type = "b")
?ar

arModel<-ar(training$Close.Price,model="ols")
arModelPrediction<-predict(arModel,n.ahead = 29)
lines(as.numeric(arModelPrediction$pred),pch=5,type = "b")

arModel<-ar(training$Close.Price,model="mle")
arModelPrediction<-predict(arModel,n.ahead = 29)
lines(as.numeric(arModelPrediction$pred),pch=6,type = "b")

arModel<-ar(training$Close.Price,model="yw")
arModelPrediction<-predict(arModel,n.ahead = 29)
lines(as.numeric(arModelPrediction$pred),pch=7,type = "b")


legend("bottom",c("Actual","AR prediction",
                  "AR-yule-walker","AR-Burg","AR-ols","AR-mle",
                  "AR-yw"),pch=c(1,2,3,4,5,6,7))


rmse<-function(x,y)
{
  sqrt(sum((x-y)^2)/length(x))
}

rmse(test$Close.Price,as.numeric(arModelPrediction$pred))

