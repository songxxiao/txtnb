
translation = list(
  "title" = list("en" = "SMS Spam Text Classification", "zh"="垃圾短信分类程序"),
  "select:" = list("en" = "Select a Classifier", "zh"="选择一种分类器"),
  "nb" = list("en" = "Naive Bayes", "zh"="朴素贝叶斯"),
  "svm" = list("en" = "Support Vector Machine", "zh"="支持向量机"),
  "cart" = list("en" = "CART Decision Tree", "zh"="CART决策树"),
  "rf" = list("en" = "Random Forest", "zh"="随机森林"),
  "logr" = list("en" = "Logistic Regression", "zh"="Logistic回归"),
  " " = list("en" = " ", "zh"=" "),
  "support" = list("en" = "Support Naive Bayes, SVM, CART, RF and Logistic Regression. The results of different algorithms are different.", "zh"="支持朴素贝叶斯、支持向量机、CART决策树、随机森林和Logistic回归算法。不同算法的分类结果有差异。"),
  "package" = list("en" = "R package support：tm, e1071, rpart, randomForest", "zh"="R程序包支持：tm、e1071、rpart、randomForest"),
  "inpms" = list("en" = "Input Message Text", "zh"="输入短信文本(必须是英文)"),
  "reset" = list("en" = "Reset", "zh"="重置"),
  "author" = list("en" = "Author: ", "zh"="作者: "),
  "xsong" = list("en" = "Xiao Song", "zh"="宋骁"),
  "use" = list("en" = "This app uses 5567", "zh"="本程序使用5567条"),
  "eng" = list("en" = "English SMS text messages", "zh"="英文短信"),
  "train" = list("en" = "to train classifiers", "zh"="作为训练集"),
  "try" = list("en" = "Copy a message and select a classifier!", "zh"="将下边的短信文本复制到左边,并选一个模型试试！"),
  "spam1" = list("en" = "Spam Message", "zh"="分类结果: 垃圾短信"),
  "ham1" = list("en" = "Ham Message", "zh"="分类结果: 非垃圾短信"),
  "intro" = list("en" = "Introduction", "zh"="简介"),
  "instruc" = list("en" = "Instruction", "zh"="使用方法"),
  "example" = list("en" = "Examples", "zh"="实验例子"),
  "intropage" = list("en" = "Spam Email detection is the first application of machine learning algorithms. With the continuous improvement of the classification algorithm's prediction ability, programs' power to recognize spam has become stronger. They could also been transfered to other tasks, including Spam Message Detection, Spam Comment Detection, etc. This program uses multiple algorithms trained on a English message dataset.Several methods have been used to construct features, the most simple one is Document-Term Matrix, which convert text data into vectors. In DTM, every row represents a document, while every column represents a word, the value means frequency the word appears in documents. To emphasize the portability of ML algorithms, I deploy trained algorithms in R shiny. Anyone could call the program over the Internet.", "zh"="垃圾邮件识别任务是机器学习算法的最初应用场景，具体的方式是将文本转化为向量来预测邮件的类别。随着分类算法预测能力的不断提升，程序对于垃圾邮件的识别能力变得更强，而且可以迁移到类似任务中去，如：垃圾短信分类、垃圾评论识别等等。本程序使用多种不同算法在一个英文短信数据集上进行训练。本程序使用文档-词语矩阵的方法构建特征，其中每行代表一个文档，每列代表一个词语，数值代表词在文档中出现的频次。为了强调机器学习算法的可移植性，我将训练好的算法封装在R shiny中进行部署，任何人都可以通过网络调用程序。"),
  "instpage" = list("en" = "Users could copy a message given by the 'Example' tab, paste it on the left board, and select an algorithm. The classification result will appear below. You could also input text collected by yourself. The button in the upper left can switch the interface language. Try it and have fun!", "zh"="使用者可以复制一条实验例子一栏中给出的文本，粘贴到左侧文本框中，并选择一个算法观察输出结果。也可以使用自己收集的英文短信文本进行预测。左上角的按钮可以切换界面语言。")
  )

saveRDS(translation,'./data/translation.rds')










