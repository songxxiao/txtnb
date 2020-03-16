# Author: Song Xiao

library(shiny)

shinyUI(
fluidPage(
  uiOutput("tit"),
  radioButtons(inputId = "language", 
               label = "Select an UI language/选择一种界面语言",
               choices = c("中文" = "zh","English" = "en"),
               selected = "zh"),
  
  sidebarLayout(
    
    sidebarPanel(
      uiOutput("althmodels"),
      uiOutput("sup"),
      uiOutput("pack"),
      uiOutput("txt"),
      
      verbatimTextOutput('value', 
                         placeholder = F),
      uiOutput('resetable_input'),
      actionButton('reset_input','Reset/重置')),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel(uiOutput("intro"),
                           uiOutput('author'),
                           a('github',href='https://github.com/songxxiao/txtnb'),
                           uiOutput('mention'),
                           uiOutput('intropage')
                           
                  ),
                  tabPanel(uiOutput("instruc"),
                           uiOutput('instpage')
),
                  tabPanel(uiOutput("example"),
                           uiOutput('select'),
                           p('Hi, quick heads up that your £15 goodybag expires on 13/01/2020. You can buy your next goodybag on 14/01/2020  here: giff.ly/switchgb'),
                           p('Did you catch the bus ? Are you buying an egg ? Did you make a coffee? 
        Are you eating your mom\'s left over lunch ? Jim and I are going to the NBA and having some guys. I mean games! Give me a call when ya finish.'),
                           p('Welcome to Finland. Enjoy the use of data, calls and texts specified in your pack within the EU without extra fees. You may visit cmlink.com/uk for our PAYG rates & Terms. For assistance, please call +44 797 300 0186. In case of emergency, please call 112.'),
                           p('We tried to call you re your reply to our sms for a free nokia mobile. Please call now 08000930705 for delivery tomorrow'),
                           p('Dear Carter,Your appointment is on 12/05/2017 at 7:00 in Boots London, Holborn. To amend or cancel please call 0546 3055219 (local call rates apply).'),
                           p('197254 Use this code for Kaggle verification'),
                           p('Hello, your 2 weeks of roaming like at home is now up, roaming in the EU and selected destinations will now be charged from your balance at 3.2p/min, 1p/text and 0.46p/MB. Terms apply. For more info: giff.ly/2qL4iQs')
                  ))
  ))
))
