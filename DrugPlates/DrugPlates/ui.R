library(shiny)
library(shinyjs)

shinyUI(fluidPage(
  
  titlePanel(HTML("<center>IC50 Drug Plates</center>")),
  
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
  ))
