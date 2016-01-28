library(shiny)
library(markdown)

shinyUI(fluidPage(
     titlePanel("String Clustering"),
     br(),
     sidebarLayout(
          sidebarPanel(
               shiny::fileInput('file1','Choose your own CSV file',
                                accept = c('text/csv',
                                           'text/comma-separated-values,text/plain',
                                           '.csv')),
               helpText("Select the algorithm that will be used to cluster the strings together"),
               selectInput("method",label = "String Clustering Algorithm",
                           choices = list("Jaro-Winker" = "jw","Levenshtein" = "lv", 
                                          "Full Damerau-Levenshtein" = "dl",
                                          "q-gram" = "qgram", "Hamming" = "hamming",
                                          "Longest common substring" = "lcs",
                                          "Optimal String Alignment" = "osa",
                                          "soundex" = "soundex")),
               numericInput("groups","Number of clusters to form",value = 80),
               numericInput("display","Cluster to display",
                            value = 1,step = 1,min = 1),
               submitButton("Update")
),
          mainPanel(
               tabsetPanel(type = "tabs",
                           tabPanel("Main",
                                h2("Table of strings clustered together"),
                                htmlOutput("meanLength"),
                                br(),
                                DT::dataTableOutput("typeTable")
                           ),
                           tabPanel("Readme",includeMarkdown("readme.md")),
                           tabPanel("All Clusters",
                                    DT::dataTableOutput("fullTable")))
          )
     )
     
))