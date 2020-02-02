####################
# Author: Song Xiao
####################

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
# load training data columns

translation = readRDS("./data/translation.rds")

source('functions.R')

shinyServer(
function(input, output, session) {
  tr = function(text){ # translates text into current language
    sapply(text,function(s) translation[[s]][[input$language]], USE.NAMES=F)
  }

  output$tit = renderUI({ # from language input to get title translation, pass prameter to UI
    titlePanel(tr('title'))
  })
  
  output$sup= renderUI({
    helpText(tr('support'))
  })
  
  output$pack= renderUI({
    helpText(tr('package'))
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
      sprintf(tr('spam1'))
    }else{
      sprintf(tr('ham1'))
    }
    
  })
  
  # Reset Button
  observeEvent(input$reset_input, { 
    updateSelectInput(session, 
                      "model",
                      label = tr("select:"),
                      choices = c("Naive Bayes", 
                                  "Support Vector Machine",
                                  "CART Decision Tree",
                                  "Random Forest",
                                  "Logistic Regression",
                                  " "),
                      selected = " ")
    updateTextAreaInput(session,"sms", tr('inpms'),' ')
  })
  
  output$althmodels = renderUI({
    selectInput("model",
                label = tr("select:"),
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
                  tr('inpms'), 
                  ' ',
                  width = '335', 
                  height = '100')
  })
  
  output$author = renderUI({
    h4(tr('author'),a(tr('xsong'),href='https://xsong.ltd/'))
  })
  
  output$mention = renderUI({
    h5(tr('use'),a(tr('eng'),href='https://www.kaggle.com/team-ai/spam-text-message-classification'),tr('train'))
  })
  
  output$select = renderUI({ 
    h4(tr('try'))
  })
  
}
)