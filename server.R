####################
# Author: Song Xiao
####################


library(tm)
library(e1071)
library(rpart)
library(randomForest)

# load classifers
naiveBayes = readRDS("./classifiers/naiveBayes.rds") # relative directory
svmc = readRDS("./classifiers/svmc.rds")
rtree = readRDS("./classifiers/rtree.rds")
rforest = readRDS("./classifiers/rforest.rds")
logit = readRDS("./classifiers/logit.rds")
# load training data columns
train = readRDS("./data/train.rds")
translation = readRDS("./data/translation.rds")

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
    
    ## predict new string's class using machine learning
    ## param @model a classification algorithm
    ## param @string a message string to predict if it is a spam
    ## return Prediction, spam or ham.
    test_result = function(model,string){ # get result from a string
      ms_corpus  = VCorpus(VectorSource(string))
      test_dtm = DocumentTermMatrix(ms_corpus, control =
                                      list(tolower = T,
                                           removeNumbers = T,
                                           stopwords = T,
                                           removePunctuation = T,
                                           stemming = T))
      test_dtm = as.matrix(test_dtm)
      
      smmat = train[1,] 
      smmat = as.data.frame(smmat) 
      smmat[,1] = 0 
      smmat = t(smmat)
      sp = colnames(smmat) %in% colnames(test_dtm)
      sp2 = colnames(test_dtm) %in% colnames(smmat)
      smmat[,sp] = test_dtm[,sp2]
      result = predict(model,smmat)
      result = as.character(result)
      return(result)
    }
    
    ## get new string's DTM
    ## but it will delete columns do not contained in training data.
    ## param string: a message string to convert to DTM 
    ## return a DTM just has one row

    convert_dtm = function(string){ 
      ms_corpus = VCorpus(VectorSource(string)) 
      test_dtm = DocumentTermMatrix(ms_corpus, control = list(tolower = T,
                                                              removeNumbers = T,
                                                              stopwords = T,
                                                              removePunctuation = T,
                                                              stemming = T))
      test_dtm = as.matrix(test_dtm)
      
      smmat = train[1,]   # smsmat is training data DTM, get first row
      smmat = as.data.frame(smmat) # matrix --> data.frame
      smmat[,1] = 0 # set this columns to 0
      smmat = t(smmat) # transpose
      sp = colnames(smmat) %in% colnames(test_dtm) # identify if new data columns appear on training data.列
      sp2 = colnames(test_dtm) %in% colnames(smmat)
      smmat[,sp] = test_dtm[,sp2] # get columns appear on training data, recode to frequency
      smmat = as.data.frame(smmat) 
      smmat$Y = 'xxx'
      return(smmat)
    }
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
      sprintf(' ') #无输入时不显示结果
    }else if(result == 'spam'){
      sprintf(tr('spam1'))
    }else{
      sprintf(tr('ham1'))
    }
    
  })
  
  # 重置按钮
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