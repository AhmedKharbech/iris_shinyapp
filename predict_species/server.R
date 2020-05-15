

library(shiny)
library(ggplot2)
library(caret)

data("iris")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    set.seed(1233214)
    intrain<-createDataPartition(y=iris$Species,p=0.7,list=FALSE)
    training<-iris[intrain,]
    testing<-iris[-intrain,]
    fit_lda<-train(Species~.,data = training,method="lda",
                   trainControl=trainControl(method="cv",number = 10))
    fit_rf<-train(Species~.,data = training,method="rf",
                   trainControl=trainControl(method="cv",number = 10))
    fit_svm<-train(Species~.,data = training,method="svmRadial",
                   trainControl=trainControl(method="cv",number = 10))
    

         output$predicted_specie<-renderText({
             if(input$models=="LDA"){
             model_pred_lda<-reactive({
                 predict(fit_lda, newdata=data.frame("Sepal.Length"=input$sepal_length,
                                                   "Sepal.Width"=input$sepal_width,
                                                   "Petal.Length"=input$petal_length,
                                                   "Petal.Width" =input$petal_width))
               
           })
           
             model_pred_lda()[1]
           }
             else if(input$models=="RF"){
                 model_pred_rf<-reactive({
                     predict(fit_rf, newdata=data.frame("Sepal.Length"=input$sepal_length,
                                                         "Sepal.Width"=input$sepal_width,
                                                         "Petal.Length"=input$petal_length,
                                                         "Petal.Width" =input$petal_width))
                     
                 })
                 
                 model_pred_rf()[1]
                 
                 
                 
             }
             else{
                 model_pred_svm<-reactive({
                     predict(fit_svm, newdata=data.frame("Sepal.Length"=input$sepal_length,
                                                        "Sepal.Width"=input$sepal_width,
                                                        "Petal.Length"=input$petal_length,
                                                        "Petal.Width" =input$petal_width))
                     
                 })
                 
                 model_pred_svm()[1]
                 
                 
                 
                 
             }
            
           })
       
              
    
    output$stats1<-renderPrint({
        if(input$models=="LDA"){
            (confusionMatrix(predict(fit_lda,newdata=testing[-5]),testing$Species))$overall
        }else if (input$models=="RF"){
            confusionMatrix(predict(fit_rf,newdata=testing[-5]),testing$Species)$overall
        }else if (input$models=="SVM") { confusionMatrix(predict(fit_svm,newdata=testing[-5]),testing$Species)$overall}
        
        
        
        
    })
    
    
})
