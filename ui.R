
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Top n Predictors"),
    
    p("This experiment will find the N top predictors from the 'mtcars' dataset, for a car's mileage."),
    p("You'll input N, and the code will find the N most important predictors to predict the miles per gallon of a car, given its other characteristics, via a simple linear regression."),
    p("The code here is inspired by Prof. Peng's lecture 'Build an R Package Demo'."),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput('numberOfVars', 'Number of top predictors', 5, min = 1, max = 10, step = 1),
            actionButton("goButton","Find top N predictors!")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            textOutput("n"),
            h4("Your top predictor coefficients are: " ),
            verbatimTextOutput("coefs")
        )
    )
))
