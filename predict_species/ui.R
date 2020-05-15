
library(shiny)

shinyUI(fluidPage(
    

    titlePanel("Predict species based on iris dataset"),
    
    
    sidebarLayout(
        sidebarPanel(
            h3("Choose a Prediction Model:"),
            radioButtons(inputId="models",label="Prediction Models: ",choices = c("LDA","RF","SVM")),
           
            h3("Sepal Length in cm"),
            sliderInput(inputId = "sepal_length",label = "",
                        min = 4,max=9,step = 0.1,value = 5),
            
            h3("Sepal width in cm"),
            sliderInput(inputId = "sepal_width",label = "",
                        min = 1.9,max=5,step = 0.1,value = 3),
            
            h3("Petal length in cm"),
            sliderInput(inputId = "petal_length",label = "",
                        min = 0.9,max=8,step = 0.1,value = 3),
            
            h3("Petal width in cm"),
            sliderInput(inputId = "petal_width",label = "",
                        min = 0.08,max=4,step = 0.01,value = 1),
            
            h6("Predicted specie (1: setosa,2: versicolor,3: virginica"),
            textOutput("predicted_specie")
            
            
        ),
        
        
        mainPanel(
            textOutput("stats1")
        )
    )
))