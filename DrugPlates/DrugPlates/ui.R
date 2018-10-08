library(shiny)
library(shinyjs)

shinyUI(fluidPage(
  
  titlePanel(HTML("<center>Drug Plates</center>")),
  tabsetPanel(
    tabPanel("IC50", 
             
  sidebarLayout(
    sidebarPanel(
      shinyjs::useShinyjs(),
      strong("Concentrations (in triplicate):"),
      fluidRow(
        column(3,numericInput("conc1","",0.1)),
        column(3,numericInput("conc2","",1)),
        column(3,numericInput("conc3","",10)),
        column(3,numericInput("conc4","",50))
      ),
      textInput('unit',strong("Data Unit:"),'uM'),
      numericInput("cell_num", strong("Number of cell lines (from 1 to 4):"), 1,min=1,max=4),
      hr(),
      textInput('name1',strong("Cell Line 1 Name:"),'Cell Line 1'),
      fileInput('file1','Choose CSV File:', 
                accept=c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      ),
      fluidRow(
        column(6,
               radioButtons("sep1", "Separator",
                            choices = c(Comma = ",",
                                        Semicolon = ";",
                                        Tab = "\t"),
                            selected = ",")),
        column(6,
               radioButtons("col1", "Plot Color:",
                            choices = c(Red = "red",
                                        Green = "darkgreen",
                                        Orange = "orange",
                                        Blue = "blue"),
                            selected = "red")
        )
      ),
      conditionalPanel(condition="input.cell_num>=2",
                       hr(),
                       textInput('name2',strong("Cell Line 2 Name:"),'Cell Line 2'),
                       fileInput('file2','Choose CSV File:',
                                 accept=c(
                                   "text/csv",
                                   "text/comma-separated-values,text/plain",
                                   ".csv")
                       ),
                       fluidRow(
                         column(6,
                                radioButtons("sep2", "Separator",
                                             choices = c(Comma = ",",
                                                         Semicolon = ";",
                                                         Tab = "\t"),
                                             selected = ",")),
                         column(6,
                                radioButtons("col2", "Plot Color:",
                                             choices = c(Red = "red",
                                                         Green = "darkgreen",
                                                         Orange = "orange",
                                                         Blue = "blue"),
                                             selected = "darkgreen")
                         )
                       )
      ),
      conditionalPanel(condition="input.cell_num>=3",
                       hr(),
                       textInput('name3',strong("Cell Line 3 Name:"),'Cell Line 3'),
                       fileInput('file3','Choose CSV File:',
                                 accept=c(
                                   "text/csv",
                                   "text/comma-separated-values,text/plain",
                                   ".csv")
                       ),
                       fluidRow(
                         column(6,
                                radioButtons("sep3", "Separator",
                                             choices = c(Comma = ",",
                                                         Semicolon = ";",
                                                         Tab = "\t"),
                                             selected = ",")),
                         column(6,
                                radioButtons("col3", "Plot Color:",
                                             choices = c(Red = "red",
                                                         Green = "darkgreen",
                                                         Orange = "orange",
                                                         Blue = "blue"),
                                             selected = "orange")
                         )
                       )
      ),
      conditionalPanel(condition="input.cell_num>=4",
                       hr(),
                       textInput('name4',strong("Cell Line 4 Name:"),'Cell Line 4'),
                       fileInput('file4','Choose CSV File:',
                                 accept=c(
                                   "text/csv",
                                   "text/comma-separated-values,text/plain",
                                   ".csv")
                       ),
                       fluidRow(
                         column(6,
                                radioButtons("sep4", "Separator",
                                             choices = c(Comma = ",",
                                                         Semicolon = ";",
                                                         Tab = "\t"),
                                             selected = ",")),
                         column(6,
                                radioButtons("col4", "Plot Color:",
                                             choices = c(Red = "red",
                                                         Green = "darkgreen",
                                                         Orange = "orange",
                                                         Blue = "blue"),
                                             selected = "blue")
                         )
                       )
      ),
      hr(),
      textInput('out_dir',strong("Project Name (no spaces):"),paste0("Project_",Sys.Date())),
      fluidRow(column(12, align="center", actionButton("report","Generate report"))),
      br(),
      uiOutput("text"),
      tags$head(tags$style("#text{color: red;
                           font-size: 14px;
                           }"
      )
      )
      ),
    
    mainPanel(align="center",
              br(),
              conditionalPanel(
                condition = "output.fileUploaded",
                HTML("<center><font size='3' color='red'>To check the results, please upload your drug plate data.</font></center>")
              ),
              wellPanel(
                uiOutput("tab")
              ),
              tableOutput("table"),
              plotOutput("plot"),
              br(),
              uiOutput("downloadData")
    )
      )
    ),
  tabPanel("Drug synergy",
           sidebarLayout(
             sidebarPanel(
               textInput('name_project',strong("Project Name:"),paste0("Project ",Sys.Date())),
               hr(),
               strong("Concentrations of drug combinations (in triplicate):"),
               br(),
               "(The model is very sensitive: enter all decimals)",
               fluidRow(
                 column(4,numericInput("conc1.1","",0.000000000,step = 0.000000001)),
                 column(4,numericInput("conc2.1","",0.000500001,step = 0.000000001)),
                 column(4,numericInput("conc3.1","",0.002000001,step = 0.000000001)),
                 column(4,numericInput("conc4.1","",0.010000001,step = 0.000000001)),
                 column(4,numericInput("conc5.1","",0.050000001,step = 0.000000001)),
                 column(4,numericInput("conc6.1","",0.200000001,step = 0.000000001)),
                 column(4,numericInput("conc7.1","",1.000000001,step = 0.000000001)),
                 column(4,numericInput("conc8.1","",5.000000001,step = 0.000000001)),
                 column(4,textInput('unit_conc',strong("Data Unit:"),'uM')),
                 column(8,fileInput('file0','Choose CSV File for drug combinations:', 
                                    accept=c("text/csv","text/comma-separated-values,text/plain",".csv"))),
                 column(4,radioButtons("sep_1", "Separator:",
                                       choices = c(Comma = ",", Semicolon = ";", Tab = "\t"),
                                       selected = ";"))
               ),
               hr(),
               fluidRow(
                 column(9,textInput('name1.1',strong("Drug 1 Name (NO spaces):"),'Drug1'))
                 #                 column(3,numericInput("drug_base1", strong("Drug Base:"), 1))
               ),
               fluidRow(
                 column(9,textInput('name2.1',strong("Drug 2 Name (NO spaces):"),'Drug2'))
                 #                 column(3,numericInput("drug_base2", strong("Drug Base:"), 1))
               ),
               strong("Concentrations of single drugs (in triplicate):"),
               br(),
               "(The model is very sensitive: enter all decimals)",
               fluidRow(
                 column(4,numericInput("conc1.2","",10.000000001,step = 0.000000001)),
                 column(4,numericInput("conc2.2","",2.000000001,step = 0.000000001)),
                 column(4,numericInput("conc3.2","",0.600000001,step = 0.000000001)),
                 column(4,numericInput("conc4.2","",0.100000001,step = 0.000000001)),
                 column(4,numericInput("conc5.2","",0.030000001,step = 0.000000001)),
                 column(4,numericInput("conc6.2","",0.008000001,step = 0.000000001)),
                 column(4,numericInput("conc7.2","",0.002100001,step = 0.000000001)),
                 column(4,numericInput("conc8.2","",0.000510001,step = 0.000000001)),
                 column(8,fileInput('file1.1','Choose CSV File for single drugs:', 
                                    accept=c("text/csv","text/comma-separated-values,text/plain",
                                             ".csv"))),
                 column(4,radioButtons("sep_2", "Separator:",
                                       choices = c(Comma = ",", Semicolon = ";", Tab = "\t"),
                                       selected = ";"))
               ),
               hr(),
               fluidRow(column(12,align="center", downloadButton("report1","Generate report")))
             ),
             mainPanel(align="center",
                       br(),
                       conditionalPanel(
                         condition = "output.fileUploaded1",
                         HTML("<center><font size='3' color='red'>To check the results, please upload your drug plate data.</font></center>")
                       ),
                       tableOutput("syn1"),
                       br(),
                       tableOutput("syn2"),
                       br(),
                       plotOutput("isob"),
                       br(),
                       plotOutput("heat"),
                       br()
             )
           )
  )
  )
  ))
