#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/ 
#

library(shiny)

# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Calculate sample size needed based on estimated effect size and reliability of two measures"),

    
    sidebarLayout(
        sidebarPanel(
            numericInput(inputId = "relA",
                         label = "Reliability variable A",
                         min = -1,
                         max = 1,
                         value = 0.8),
            numericInput(inputId = "relB",
                         "Reliability variable B",
                         min = -1,
                         max = 1,
                         value = .8),
            numericInput(inputId = "pwr",
                         "Desired power",
                         min = 0,
                         max = 1,
                         value = .8),
            numericInput(inputId = "alpha",
                         "Alpha",
                         min = 0,
                         max = 1,
                         value = 0.05),
            numericInput(inputId = "eff",
                         "Estimated effect size",
                         min = -1,
                         max = 1,
                         value = 0.3)
        ),
        mainPanel(h3(textOutput("Power"))
        )
    )
)
        
server <- function(input, output) {
    output$Power <- renderText({
    x <- input$eff*(sqrt(input$relA*input$relB))
    power <- pwr::pwr.r.test(r = x, sig.level = input$alpha, power = input$pwr)
    paste0("Sample size needed: ", round(power$n, 0))
    })
    }
        
shinyApp(ui = ui, server = server) 
