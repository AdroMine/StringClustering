library(shiny)
library(googleVis)
library(stringdist)

mydata <- read.csv("StormTypes.csv",colClasses = "character", stringsAsFactors = FALSE)
mydata <- mydata[,1]
K <- length(mydata)

shinyServer(function(input,output,clientData,session){
     # change ui max values according to data and clusters selected
     observe({
          updateNumericInput(session,"groups",max = K,
                             value = ifelse(input$groups>K,K/2,input$groups))
          updateNumericInput(session,"display",max = input$groups,
                             value = ifelse(input$display>input$groups,1,input$display))
     })
     # if user uploads his own data
     getData <- reactive({
          inFile <- input$file1
          if(is.null(inFile))
               return(mydata)
          else {
               mydata <- read.csv(inFile$datapath,colClasses = "character")[,1]
               return(mydata)
          }
     })
     
     # create clusters don't want this to updated each time different
     # cluster is selected to be viewed
     clustered <- reactive({
          df <- getData()
          dist <- stringdistmatrix(df,df,method = input$method)
          hc <- hclust(as.dist(dist))
          clustered <- data.frame(Type=df,Cluster=cutree(hc,input$groups))
     })
     # output cluster selected for viewing by user
     output$typeTable <- DT::renderDataTable({
          df <- clustered()
          df <- subset(df,Cluster == input$display)
          DT::datatable(df,rownames = FALSE,selection = "none",
                        options = list(searching = FALSE))
     })
     
     # output all strings and their clusters
     output$fullTable <- DT::renderDataTable({
          df <- clustered()
          DT::datatable(df,selection = "none")
     })
     
     # average cluster size
     output$meanLength <- renderUI({
          df <- clustered()
          ml <- mean(tapply(df$Type,df$Cluster,length))
          h4(paste("Average number of strings in each cluster =",ml))
     })
})