function(input, output) {
  output$value <- renderText({
    library(tm)
    library(e1071)
    naiveBayes <- readRDS("D:/txtnb/naiveBayes.rds")
    test_result <- function(model,string){
      ms_corpus <- VCorpus(VectorSource(string))
      test_dtm <- DocumentTermMatrix(ms_corpus, control =
                                       list(tolower = T,
                                            removeNumbers = T,
                                            stopwords = T,
                                            removePunctuation = T,
                                            stemming = T))
      test_dtmx <- as.matrix(test_dtm)
      result <- predict(model,test_dtmx)
      return(result)
    }
    
    result <- test_result(naiveBayes,input$sms)
    result <- as.character(result)
    
    if (result== 'spam'){
      sprintf('分类结果输出:垃圾短信')
    }
    else{
      sprintf('分类结果输出:非垃圾短信')
    }
  })
}