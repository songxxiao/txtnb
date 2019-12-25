# A text classification [Shiny App](https://shiny.rstudio.com/) Program

+ [English Version](https://github.com/ECSTA7Y/txtnb_en)

+ 垃圾短信分类 [Shiny App](https://shiny.rstudio.com/) 

本程序由[宋骁](https://xsong.ltd/)编写。  

本程序使用5567条[英文短信 ](https://www.kaggle.com/team-ai/spam-text-message-classification)作为训练集生成朴素贝叶斯分类器。  

用户需要输入一段短信内容文本。下方将返回该文本的分类结果。
由于训练文本为英文，请输入英文文本。英文版点[这里](https://github.com/ECSTA7Y/txtnb_en)

如:

+ Did you catch the bus ? Are you frying an egg ? Did you make a tea? Are you eating your mom's left over dinner ?（非垃圾短信）

+ We tried to call you re your reply to our sms for a free nokia mobile. Please call now 08000930705 for delivery tomorrow.（垃圾短信）

注：

程序包支持：`tm`、`e1071`

文件夹中的`naiveBayes.rds`为预先训练好的朴素贝叶斯模型；
`svmc.rds`为支持向量机模型；`naiveBayes.rds`为训练数据集。

+ 如何使用？

在你的本地的R语言安装`shiny`包之后，键入如下代码：

```
library(shiny)
runGitHub( "txtnb", "ECSTA7Y")
```

即可下载和运行本App。

后续我会将APP挂在网上。
