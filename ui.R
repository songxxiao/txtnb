####################
# Author: Song Xiao
####################

fluidPage(
  uiOutput("tit"),
  radioButtons(inputId = "language", label = "Select a language/选择一种语言",
               choices = c("中文" = "zh","English" = "en"),
               selected = "zh"),
  
  sidebarLayout(
    
    sidebarPanel(
      uiOutput("althmodels"),
      uiOutput("sup"),
      uiOutput("pack"),
      uiOutput("txt"),
      #helpText('由于训练集语言为英文，请输入英文文本。'),
      #helpText('下方返回该文本分类结果'),
      verbatimTextOutput('value', 
                         placeholder = F),
      uiOutput('resetable_input'),
      actionButton('reset_input','Reset/重置')),
    mainPanel(
      uiOutput('author'),
      uiOutput('mention'),
      uiOutput('select'),
      #h4('作者：',a('宋骁',href='https://xsong.ltd/')),
      #h5('本程序使用5567条',a('英文短信',href='https://www.kaggle.com/team-ai/spam-text-message-classification'),'作为训练集'),
      #h4('将下边的短信文本复制到左边,并选一个模型试试！'),
      p('Did you catch the bus ? Are you buying an egg ? Did you make a coffee? 
        Are you eating your mom\'s left over lunch ?'),
      p('Yes. I will check all classes befor activities'),
      p('Jim and I are going to the NBA and having some guys. I mean games! Give me a call when ya finish.'),
      p('We tried to call you re your reply to our sms for a free nokia mobile. Please call now 08000930705 for delivery tomorrow'),
      p('BangBabes Ur order is on the way. U SHOULD receive a Service Msg 2 download UR content. If U do not, GoTo wap. bangb. tv on UR mobile internet/service menu'),
      p('Attention! Adult 18 Content Your PXXN video will go with you quickly'))
  )
)

