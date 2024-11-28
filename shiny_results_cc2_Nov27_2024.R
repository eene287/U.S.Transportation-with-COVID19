library(shiny)
library(astsa)
library(dplyr)
library(DT)


# Load the necessary data files
files_to_load <- c("stateInfo.R")

for (file in files_to_load) {
  load(file)
}

ui <- fluidPage(
  titlePanel(
    div(
      h1("Association between the State Daily Traffic and the COVID19 state policies"),
      tags$h3(" _ _ The not significant associations are listed as NA _ _", style="font-size:16px; color:gray;")
    )
      ),
    sidebarPanel(
      DTOutput("table")
  )
)

server <- function(input, output) {
   output$table <- renderDT({
      datatable(
      stateInfo,
      options = list(pageLength = 10, autoWidth = TRUE, searchHighlight = TRUE),
      class = 'cell-border stripe'
    )
  })
}
  
  
shinyApp(ui = ui, server = server)