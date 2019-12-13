fluidPage(
  titlePanel('朴素贝叶斯垃圾短信分类'),
  helpText('本程序由',a('宋骁',href='https://xsong.ltd/',target='_blank'),'编写'),
  helpText('本程序使用5567条',a('英文短信',href='https://www.kaggle.com/team-ai/spam-text-message-classification',target='_blank'),'作为训练集生成朴素贝叶斯分类器。'),
  helpText('用户需要输入一段短信内容文本。下方将返回该文本的分类结果。'),
  helpText('由于训练文本为英文，请输入英文文本。'),
  
  helpText('如:  Did you catch the bus ? Are you buying an egg ? Did you make a coffee? Are you eating your mom\'s left over lunch ?（非垃圾短信）'),
  helpText('Yes. I will check all classes befor activities（非垃圾短信）'),
  helpText('Jim and I are going to the NBA and having some guys. I mean games! Give me a call when ya finish.（非垃圾短信）'),
  
  
  helpText('We tried to call you re your reply to our sms for a free nokia mobile. Please call now 08000930705 for delivery tomorrow（垃圾短信）'),
  helpText('BangBabes Ur order is on the way. U SHOULD receive a Service Msg 2 download UR content. If U do not, GoTo wap. bangb. tv on UR mobile internet/service menu
（垃圾短信）'),
  helpText('Attention! Adult 18 Content Your PXXN video will go with you quickly
（垃圾短信）'),
  
  helpText('程序包支持：tm、e1071'),
  textInput("sms", '短信文本输入','请输入短信文本(英文)...'),
  #verbatimTextOutput('out', placeholder = F),
  verbatimTextOutput('value', placeholder = F)

)

