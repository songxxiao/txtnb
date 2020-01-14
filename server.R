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
train = readRDS("./classifiers/train.rds")

function(input, output, session) {
  
  output$value =  renderText({
    

    test_result = function(model,string){
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
    
    convert_dtm = function(string){ # 得到新数据的DTM
      ms_corpus = VCorpus(VectorSource(string)) 
      test_dtm = DocumentTermMatrix(ms_corpus, control = list(tolower = T,
                                             removeNumbers = T,
                                             stopwords = T,
                                             removePunctuation = T,
                                             stemming = T))
      test_dtm = as.matrix(test_dtm)
      
      smmat = train[1,]   # smsmat 为训练集DTM,提取第一行
      smmat = as.data.frame(smmat) # 将matrix转化为data.frame
      smmat[,1] = 0 # 将此列所有值设为0
      smmat = t(smmat) # 转置
      sp = colnames(smmat) %in% colnames(test_dtm) # 判断新数据集在训练集中出现的列
      sp2 = colnames(test_dtm) %in% colnames(smmat)
      smmat[,sp] = test_dtm[,sp2]  # 提取在训练集中出现的列，将对应的值重编码为频率
      smmat = as.data.frame(smmat) 
      smmat$Y = 'xxx'
      return(smmat)
    }
    
    
    if (input$model == '朴素贝叶斯'){
      result = test_result(naiveBayes,input$sms)
    }else if(input$model == '支持向量机'){
      result = test_result(svmc,input$sms)
      
    }else if(input$model == 'CART决策树'){
      sms1 = convert_dtm(input$sms)
      result = predict(rtree,sms1,type = 'class')
      
    }else if(input$model == '随机森林'){
      sms1 = convert_dtm(input$sms)
      result = predict(rtree,sms1,type = 'class')
      
    }else if(input$model == 'Logistic回归'){  
      sms1 = convert_dtm(input$sms)
      prob = predict(logit,sms1,type = "response")
      result = ifelse(prob >0.5,'spam','ham')
    }
    
    if (input$sms == ' ' | input$model == ' ' ){
      sprintf(' ') #无输入时不显示结果
    }else if(result== 'spam'){
      sprintf('分类结果: 垃圾短信')
    }else{
      sprintf('分类结果: 非垃圾短信')
    }
    
  })

  # 重置按钮
  observeEvent(input$reset_input, { 
    updateSelectInput(session, 
                      "model",
                      label = "选择一种模型",
                      choices = c("朴素贝叶斯", 
                                  "支持向量机",
                                  "CART决策树",
                                  "随机森林",
                                  "Logistic回归",
                                  " "),
                      selected = " ")
    updateTextAreaInput(session,"sms", '输入短信文本',' ')
  })

}