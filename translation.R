
translation = list(
  "title" = list("en" = "SMS Spam Text Classification", "zh"="垃圾短信分类程序"),
  "select:" = list("en" = "Select a Classifier", "zh"="选择一种分类器"),
  "nb" = list("en" = "Naive Bayes", "zh"="朴素贝叶斯"),
  "svm" = list("en" = "Support Vector Machine", "zh"="支持向量机"),
  "cart" = list("en" = "CART Decision Tree", "zh"="CART决策树"),
  "rf" = list("en" = "Random Forest", "zh"="随机森林"),
  "logr" = list("en" = "Logistic Regression", "zh"="Logistic回归"),
  " " = list("en" = " ", "zh"=" "),
  "support" = list("en" = "Now it supports Naive Bayes, SVM, CART, RF and Logistic Regression.", "zh"="目前支持朴素贝叶斯、支持向量机、CART决策树、随机森林和Logistic回归算法。"),
  "package" = list("en" = "R package support：tm, e1071, rpart, randomForest", "zh"="R程序包支持：tm、e1071、rpart、randomForest"),
  "inpms" = list("en" = "Input Message Text", "zh"="输入短信文本"),
  "reset" = list("en" = "Reset", "zh"="重置"),
  "author" = list("en" = "Author: ", "zh"="作者: "),
  "xsong" = list("en" = "Xiao Song", "zh"="宋骁"),
  "use" = list("en" = "This app uses 5567", "zh"="本程序使用5567条"),
  "eng" = list("en" = "English SMS text messages", "zh"="英文短信"),
  "train" = list("en" = "to train classifiers", "zh"="作为训练集"),
  "try" = list("en" = "Copy a message and select a model!", "zh"="将下边的短信文本复制到左边,并选一个模型试试！"),
  "spam1" = list("en" = "Spam Message", "zh"="分类结果: 垃圾短信"),
  "ham1" = list("en" = "Ham Message", "zh"="分类结果: 非垃圾短信")
)

saveRDS(translation,'E:/txtnb_new/data/translation.rds')


tr <- function(text){ # translates text into current language
  sapply(text,function(s) translation[[s]][[input$language]], USE.NAMES=F)
}

cc = c("youhaveselected","greetings")
tr(cc)




tr <- function(text){ # translates text into current language
  sapply(text,function(s) translation[[s]][[input$language]], USE.NAMES=FALSE)
}

tr('plotTitle')











