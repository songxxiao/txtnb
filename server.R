# Author: Song Xiao

library(shiny)
library(tm)
library(e1071)
library(rpart)
library(randomForest)
library(SnowballC)

# load classifers
naiveBayes = readRDS("./classifiers/naiveBayes.rds") # relative directory
svmc = readRDS("./classifiers/svmc.rds")
rtree = readRDS("./classifiers/rtree.rds")
rforest = readRDS("./classifiers/rforest.rds")
logit = readRDS("./classifiers/logit.rds")
source('functions.R')


shinyServer(
function(input, output, session) {

  # from language input to get title translation, pass prameter to UI
  output$tit = renderUI({ 
    titlePanel(tr('title',input))
  })
  
  output$sup= renderUI({
    helpText(tr('support',input))
  })
  
  output$pack= renderUI({
    helpText(tr('package',input))
  })
  
  output$value =  renderText({
    # define some functions

    if (input$model == 'Naive Bayes'){
      result = test_result(naiveBayes,input$sms)
    }else if(input$model == 'Support Vector Machine'){
      result = test_result(svmc,input$sms)
      
    }else if(input$model == 'CART Decision Tree'){
      sms1 = convert_dtm(input$sms)
      result = predict(rtree,sms1,type = 'class')
      
    }else if(input$model == 'Random Forest'){
      sms1 = convert_dtm(input$sms)
      result = predict(rtree,sms1,type = 'class')
      
    }else if(input$model == 'Logistic Regression'){  
      sms1 = convert_dtm(input$sms)
      prob = predict(logit,sms1,type = "response")
      result = ifelse(prob >0.5,'spam','ham')
    }
    
    if (input$sms == ' ' | input$model == ' ' ){
      sprintf(' ') # No result if there is no input
    }else if(result == 'spam'){
      sprintf(tr('spam1',input))
    }else{
      sprintf(tr('ham1',input))
    }
})
  
  # Reset Button
  observeEvent(input$reset_input, { 
    updateSelectInput(session, 
                      "model",
                      label = tr("select:",input),
                      choices = c("Naive Bayes", 
                                  "Support Vector Machine",
                                  "CART Decision Tree",
                                  "Random Forest",
                                  "Logistic Regression",
                                  " "),
                      selected = " ")
    updateTextAreaInput(session,"sms", tr('inpms',input),' ')
  })
  
  output$althmodels = renderUI({
    selectInput("model",
                label = tr("select:",input),
                choices = c("Naive Bayes", 
                            "Support Vector Machine",
                            "CART Decision Tree",
                            "Random Forest",
                            "Logistic Regression",
                            " "),
                selected = " ")
  })
  
  output$txt = renderUI({
    textAreaInput("sms", 
                  tr('inpms',input), 
                  ' ',
                  height = '100')
  })
  
  output$author = renderUI({
    h5(tr('author',input),a(tr('xsong',input),href='https://xsong.ltd/'))
  })
  
  output$mention = renderUI({
    h5(tr('use',input),a(tr('eng',input),href='https://www.kaggle.com/team-ai/spam-text-message-classification'),tr('train',input))
  })
  
  output$select = renderUI({ 
    h5(tr('try',input))
  })
  
}
)