# 短文本分类：垃圾信息判别 R Shiny App程序

本程序的github地址：<https://github.com/ECSTA7Y/txtnb>   
English Version：<https://github.com/ECSTA7Y/txtnb_en>

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

[Shiny App](https://shiny.rstudio.com/)是RStudio开发的交互式Web应用。简单来说它可以将你的R代码和函数封装在一个有前端界面的程序中，使得不会使用R语言的用户可以通过点击运行程序。Shiny App甚至还可以挂到云平台上分享，这样即使不安装R语言，也能够运行。但很遗憾，真正能用的在线服务是付费的。我在我的RStudio提供的免费服务中上[上传了这个程序](https://xiaosong.shinyapps.io/txtnb/)，但它几乎一打开就崩溃。

想使用这个Shiny，你需要输入一段短信内容文本，并选择一个分类器，下方将返回该文本的分类结果。由于训练文本为英文，请输入英文文本。英文版点[这里](https://github.com/ECSTA7Y/txtnb_en)。程序右侧提供了一些示例文本供用户尝试。你可以阅读并复制它们到左侧，看看程序的输出结果：

![](https://i.loli.net/2019/12/25/lQ3mIj5iDNFzUMx.gif)

当然你也可以使用自己收集的英文信息文本拿来运行，考验一下机器学习对于人类语言的理解能力！

## 文件说明

| 文件名                     | 说明                      |
|----------------------------|---------------------------|
| README.md                  | 说明文档                  |
| serve.R                    | Shiny程序源代码           |
| ui.R                       | Shiny用户界面前端代码     |
| SMS_spam.Rmd               | 模型训练过程RMarkdown文件 |
| classifiers/logit.rds      | Logistic回归模型结果保存  |
| classifiers/naiveBayes.rds | 朴素贝叶斯算法结果保存    |
| classifiers/rforest.rds    | 随机森林算法结果保存      |
| classifiers/rtree.rds      | CART决策树算法结果保存    |
| classifiers/svmc.rds       | 支持向量机算法结果保存    |
| classifiers/train.rds      | 训练集列名数据            |
| rsconnect                  | Shiny远程部署文件         |

程序设计的基本思路是将训练好的分类器保存为`.rds`格式的R对象。运行本程序时加载对应的分类器。`SMS_spam.Rmd`和[我的blog](https://xsong.ltd/zh/sms/)记录了模型训练过程。为保证程序的稳健性，本程序放弃使用`magrittr`包的`%>%`操作符。私以为将大量的`%>%`写到自编函数中会让人头晕眼花。因此我使用了中间变量命名。


## 下载和使用？

使用前你需要在R中安装以下包：

```r
install.packages('shiny')
install.packages('e1071')
install.packages('randomForest')
install.packages('tm')
```

在Windows本地的R语言安装`shiny`包之后，键入如下代码即可下载和运行本App：

```r
library(shiny)
runGitHub( "txtnb", "ECSTA7Y")
```

经测试，在Ubuntu 18.04中无法安装`tm`包，因此无法运行本App。欢迎使用Mac系统的小伙伴分享测试结果。本程序由[宋骁](https://xsong.ltd/)编写。这是我的第一个Shiny App编程尝试，同时也是一次短文本机器学习分类器的尝试。


