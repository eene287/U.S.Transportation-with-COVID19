library(shiny)
library(astsa)
library(dplyr)


# Load the necessary data files
files_to_load <- c("traffic_ts.R", "prior_ts.R", "emer_ts.R", "lock_ts.R", "allStateCodes.R")

for (file in files_to_load) {
  load(file)
}

stateList<-read.csv("C:/Users/Mama/Desktop/Customer_cases/CovidOnTransportation/USPS_State_Abbreviations.csv", header=T, all=T)
#create a list of all states in the data base
allCodes<-as.numeric(stateList$FIPS.State.Code)


ui <- fluidPage(
  titlePanel("State Daily Traffic in 2020"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = "plotType",
                   label = "Data to visualize:",
                   choiceNames = c('Traffic', 'Average state traffic in 2018 &2019 ','COVID19 state policy'),
                   choiceValues = c('Traffic', 'Average state traffic in 2018 &2019 ', "COVID19 state policy")),
      textInput("num", label = "Enter an integer smaller than 57:", value = '48'),
      textOutput("codeFIPS")
    ),
    mainPanel(
      plotOutput(outputId = "tsPlot")
    )
  )
)

server <- function(input, output) {
  n <- reactive({ as.numeric(input$num) })
  traffic<-reactive({traffic_ts[[n()]]$traffic20})
  prior<-reactive({prior_ts[[n()]]$prior})
  emer<-reactive({emer_ts[[n()]]$emer})
  lock<-reactive({lock_ts[[n()]]$lock})
  name<- reactive({ stateList[[n(), "stateName"]]  })
  
  observe({
    if (n() %in% allCodes) {
           output$codeFIPS <- renderText({
           paste("The state name is:", name()) 
        })
    } else {
      output$codeFIPS <- renderText({
        "This state code is not included in our database. Please select another code."
      })
    }
  })
  
  output$tsPlot <- renderPlot({
          if (input$plotType == 'Traffic') {
        par(cex = 0.65)
        date <- seq.Date(from = as.Date("2020-01-01"), to = as.Date("2020-12-31"), by = "day")
        library(astsa)
        tsplot(date, traffic(), 
               main = "State Traffic in 2020", xlab = "Date in 2020", ylab = "Traffic Statewide, million vehicles per day", col = "darkblue", ltw = 2)
      } else if (input$plotType == "Average state traffic in 2018 &2019 ") {
        library("astsa")
        par(cex = 0.65) 
        date<- seq.Date(from = as.Date("2020-01-01"), to = as.Date("2020-12-31"), by = "day")
        tsplot(date, prior(), main = "Average Prior State Traffic, in 2018 and 2019", xlab = "Date in 2020", ylab = "Traffic Statewide, million vehicles per day", col="gray",ltw =2)
      } else if (input$plotType == "COVID19 state policy") {
        library("astsa")
        par(cex = 0.65) 
        date<- seq.Date(from = as.Date("2020-01-01"), to = as.Date("2020-12-31"), by = "day")
        tsplot(date, traffic(), main = "State Traffic in 2020", xlab = "Date in 2020", ylab = "Traffic Statewide, million vehicles per day", col="darkblue",ltw =2)
        lines(date,prior(), lty =1, lwd=1.5, col='gray') 
        lines(date,0.9*emer(), lty=2, lwd=1.2, col=2)
        lines(date,0.93*lock(),lty=2, lwd=2, col="magenta")
        legend("bottomright", legend = c("Traffic 2020","Prior Years Traffic", "LockDown","Emergency Order"), col = c("darkblue","gray", 2,"magenta"), lty = c(1,1,2,2), lwd = 2)
      }
  })

 }

shinyApp(ui = ui, server = server)
