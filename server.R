library(shiny)
library(googleVis)
library(stringdist)

storms <- read.csv("StormTypes.csv",colClasses = "character", stringsAsFactors = FALSE)
storms <- storms[,1]
K <- length(storms)

shinyServer(function(input,output,clientData,session){
     
     observe({
          updateNumericInput(session,"groups",max = K,
                             value = ifelse(input$groups>K,K/2,input$groups))
          updateNumericInput(session,"display",max = input$groups,
                             value = ifelse(input$display>input$groups,1,input$display))
     })
     clustered <- reactive({
          dist <- stringdistmatrix(storms,storms,method = input$method)
          hc <- hclust(as.dist(dist))
          clustered <- data.frame(Type=storms,Cluster=cutree(hc,input$groups))
     })
     output$typeTable <- DT::renderDataTable({
          df <- clustered()
          df <- subset(df,Cluster == input$display)
          DT::datatable(df,rownames = FALSE,selection = "none",
                        options = list(searching = FALSE))
     })
     output$meanLength <- renderUI({
          df <- clustered()
          ml <- mean(tapply(df$Type,df$Cluster,length))
          h4(paste("Average number of strings in each cluster =",ml))
     })
})