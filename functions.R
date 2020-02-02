## predict new string's class using machine learning
## param @model a classification algorithm
## param @string a message string to predict if it is a spam
## return Prediction, spam or ham.

train = readRDS("./data/train.rds")

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