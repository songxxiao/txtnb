
# 短文本分类：垃圾信息判别 R Shiny App程序

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


本程序的github地址：<https://github.com/songxxiao/txtnb>

## 简介

文本分类是一种比较基础的机器学习应用。常见的任务是垃圾邮件或手机短信分类。文本分类对于训练数据集的要求很高。比方说，你必须找到一个人工贴好标签数据集进行训练。而这将会耗费大量的人力成本。还好网上能找到很多出于教学目的的带标签数据。比如这个[英文短信数据集](https://www.kaggle.com/team-ai/spam-text-message-classification)。它包含5567条短信数据和标签。数据集长这样：

```
#   tag   message                                                          ID
# 1 ham   Go until jurong point, crazy.. Available only in bugis n gre~     1
# 2 ham   Ok lar... Joking wif u oni...                                     2
# 3 spam  Free entry in 2 a wkly comp to win FA Cup final tkts 21st Ma~     3
# 4 ham   U dun say so early hor... U c already then say...                 4
# 5 ham   Nah I don't think he goes to usf, he lives around here though     5
# 6 spam  FreeMsg Hey there darling it's been 3 week's now and no word~     6
```
tag为是否为垃圾信息的标签，message列为文本内容，ID为信息编号。

## Shiny App

[Shiny App](https://shiny.rstudio.com/)是RStudio开发的交互式Web应用。简单来说它可以将你的R代码和函数封装在一个有前端界面的程序中，使得不会使用R语言的用户可以通过点击运行程序。Shiny App甚至还可以挂到云平台上分享，这样即使不安装R语言，也能够运行。但很遗憾，真正能用的在线服务是付费的。我在我的RStudio提供的免费服务中上[上传了这个程序](https://xiaosong.shinyapps.io/spam_text/)。

想使用这个Shiny，你需要输入一段短信内容文本，并选择一个分类器，下方将返回该文本的分类结果。由于训练文本为英文，请输入英文文本。此外，考虑到用户的语言习惯，我加入了中英双语界面，可以点击上方的按钮切换。程序右侧提供了一些示例文本供用户尝试。你可以阅读并复制它们到左侧，看看程序的输出结果：

![](https://i.loli.net/2020/02/13/GBvS5XDcuMhTx9W.gif)

当然你也可以使用自己收集的英文信息文本拿来运行，考验一下机器学习对于人类语言的理解能力！

## 文件说明

| 文件名                     | 说明                      |
|----------------------------|---------------------------|
| README.md                  | 说明文档                  |
| server.R                   | Shiny程序源代码           |
| ui.R                       | Shiny用户界面前端代码     |
| SMS_spam.Rmd               | 模型训练过程RMarkdown文件 |
| classifiers/logit.rds      | Logistic回归模型结果保存  |
| classifiers/naiveBayes.rds | 朴素贝叶斯算法结果保存    |
| classifiers/rforest.rds    | 随机森林算法结果保存      |
| classifiers/rtree.rds      | CART决策树算法结果保存    |
| classifiers/svmc.rds       | 支持向量机算法结果保存    |
| data/train.rds             | 训练集列名数据            |
| data/translation.rds       | 中英文翻译对应词表        |
| rsconnect                  | Shiny远程部署文件         |

程序设计的基本思路是将训练好的分类器保存为`.rds`格式的R对象。运行本程序时加载对应的分类器。`SMS_spam.Rmd`和[我的blog](https://xsong.ltd/zh/sms/)记录了模型训练过程。为保证程序的稳健性，本程序放弃使用`magrittr`包的`%>%`操作符。私以为将大量的`%>%`写到自编函数中会让人头晕眼花。因此我使用了中间变量命名。


## 下载和使用？

使用前你需要在R中安装以下包：

```r
install.packages('shiny')
install.packages('e1071')
install.packages('randomForest')
install.packages('tm')
install.packages('SnowballC')
```

在Windows本地的R语言安装`shiny`包之后，键入如下代码即可下载和运行本App：

```r
library(shiny)
runGitHub( "txtnb", "songxxiao")
```
本程序由[宋骁](https://xsong.ltd/)编写。这是我的第一个Shiny App编程尝试，同时也是一次短文本机器学习分类器的尝试。

## 更新记录

+ 2020/1/15 从原来的2个分类器更新至5个

+ 2020/1/27 加入中英双语功能

+ 2020/4/02 修改前端CSS主题


----
# A text classification: Spam Message Dectection R Shiny App

github：<https://github.com/songxxiao/txtnb>

## Introduction

Text classification is a basic application of natural language processing and machine learning. Spam message dectection is an important task, which have some demand for training data. For example, training data must has tags that represent if a message is a spam or a ham. Tagging a dataset will cost a lot. However, it is easy to find tagged datasets. Our data is [downloaded from Kaggle](https://www.kaggle.com/team-ai/spam-text-message-classification), which contains 5567 messages:

```
#   tag   message                                                          ID
# 1 ham   Go until jurong point, crazy.. Available only in bugis n gre~     1
# 2 ham   Ok lar... Joking wif u oni...                                     2
# 3 spam  Free entry in 2 a wkly comp to win FA Cup final tkts 21st Ma~     3
# 4 ham   U dun say so early hor... U c already then say...                 4
# 5 ham   Nah I don't think he goes to usf, he lives around here though     5
# 6 spam  FreeMsg Hey there darling it's been 3 week's now and no word~     6
```
Column `tag` distinguishs classes of messages，`message` is text content，`ID` identifies different messages.

## Shiny App

[Shiny](https://shiny.rstudio.com/) is an interactive web app developed by RStudio, it could wrap your R code into a webpage, thus users who do not understand R code could use it. Even you have no web development skills, you could write shiny apps. Shiny Apps could be shared online because RStudio provide free service for users, and I publish it on [shinyapps.io](https://xiaosong.shinyapps.io/spam_text/).

To use this shiny, you need to input a text message , then choose a classifier. The classification result will appear immediately in box below. Attention that you must input English message because our training data is English. Furthermore, to internationalize it, I developed multilingual (Chinese and English) interface. Users could click a button above to switch language mode. On the right panel, I provide some example text to try. You could read it and copy it to left and see output of the program.

![](https://i.loli.net/2020/02/13/13K6jHmtB7geqsx.gif)

You could also input text message collected by yourself and test how deeply could computers understand human language!

## Files Description

| File                     | Description                      |
|----------------------------|---------------------------|
| README.md                  | Introduction file          |
| server.R                   | Shiny app source code           |
| ui.R                       | Shiny app user interface code     |
| SMS_spam.Rmd               | model training RMarkdown file |
| classifiers/logit.rds      | Logistic Regression result save  |
| classifiers/naiveBayes.rds | Naive Bayes result save     |
| classifiers/rforest.rds    | Random Forest result save     |
| classifiers/rtree.rds      | CART decision tree result save |
| classifiers/svmc.rds       | Support vector machine result save |
| data/train.rds             | training data columns name data|
| data/translation.rds       | Chinese-English translation dictionary list |
| rsconnect                  | Shiny deploy file         |

My basic idea for designing this shiny is to save trained classifiers as `.rds` files. Once the shiny is run, `.rds` files will be loaded. New text will be converted to DTM and fitted by loaded classifiers. Then result will be known. [My blog](https://xsong.ltd/zh/sms/) records how I trained algorithms. To keep my program to be robust, I did not use `magrittr::%>%` to write program.

## How to Download and Use it?

First off, you must install packages below:

```r
install.packages('shiny')
install.packages('e1071')
install.packages('randomForest')
install.packages('tm')
install.packages('SnowballC')
```
After installing `shiny` package, run this:

```r
library(shiny)
runGitHub( "txtnb", "songxxiao")
```

This app is written by [Xiao Song](https://xsong.ltd/). This is my first Shiny App.

## Update Record

+ 2020/1/15 Add 3 new algorithms.

+ 2020/1/27 Update multilingual mode.

+ 2020/4/02 Change UI css theme.
