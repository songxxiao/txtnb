####################
# Author: Song Xiao
####################

fluidPage(
  titlePanel('垃圾短信分类程序'),
  
  sidebarLayout(
    sidebarPanel(
     selectInput("model",label = "选择一种分类器",
                            choices = c("朴素贝叶斯", 
                                        "支持向量机",
                                        "CART决策树",
                                        "随机森林",
                                        "Logistic回归",
                                        " "),
                            selected = " "), # default选项
     
                helpText('目前支持朴素贝叶斯、支持向量机、CART决策树、随机森林和Logistic回归算法。'),
                helpText('R程序包支持：tm、e1071、rpart、randomForest'),
                textAreaInput("sms", 
                              '输入短信文本',
                              ' ', 
                              width = '335', 
                              height = '100'),
                helpText('由于训练集语言为英文，请输入英文文本。'),
                helpText('下方返回该文本分类结果'),
                verbatimTextOutput('value', 
                                   placeholder = F),
                uiOutput('resetable_input'),
                actionButton('reset_input','重置')),
    mainPanel(
      h4('作者：',a('宋骁',href='https://xsong.ltd/')),
      h5('本程序使用5567条',a('英文短信',href='https://www.kaggle.com/team-ai/spam-text-message-classification'),'作为训练集'),
      h4('将下边的短信文本复制到左边,并选一个模型试试！'),
      p('Did you catch the bus ? Are you buying an egg ? Did you make a coffee? 
        Are you eating your mom\'s left over lunch ?'),
      p('Yes. I will check all classes befor activities'),
      p('Jim and I are going to the NBA and having some guys. I mean games! Give me a call when ya finish.'),
      p('We tried to call you re your reply to our sms for a free nokia mobile. Please call now 08000930705 for delivery tomorrow'),
      p('BangBabes Ur order is on the way. U SHOULD receive a Service Msg 2 download UR content. If U do not, GoTo wap. bangb. tv on UR mobile internet/service menu'),
      p('Attention! Adult 18 Content Your PXXN video will go with you quickly'))
    )
)

