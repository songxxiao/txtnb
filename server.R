library(tm)
library(e1071)
naiveBayes = readRDS("naiveBayes.rds")
svmc = readRDS("svmc.rds")
train = readRDS("train.rds")

function(input, output, session) {
  
  output$value =  renderText({
    

    
    test_result = function(model,string){
      ms_corpus = VCorpus(VectorSource(string))
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
    
    if (input$model == '朴素贝叶斯'){
      result = test_result(naiveBayes,input$sms)
    }else{
      result = test_result(svmc,input$sms)
    }
    
    if (input$sms == ' ' | input$model == ' ' ){
      sprintf(' ')
    }else if(result== 'spam'){
      sprintf('分类结果: 垃圾短信')
    }else{
      sprintf('分类结果: 非垃圾短信')
    }
    
  })

  observeEvent(input$reset_input, { # 重置按钮
    updateSelectInput(session, 
                      "model",
                      label = "选择一种模型",
                      choices = c("朴素贝叶斯", 
                                  "支持向量机",
                                  " "),
                      selected = " ")
    updateTextAreaInput(session,"sms", '输入短信文本',' ')
  })

}