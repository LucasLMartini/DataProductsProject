
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

data("mtcars")

shinyServer(function(input, output) {

    output$coefs <- renderText("No regression run yet")
    output$n <- renderText({
        n <- input$numberOfVars
    
        if (is.na(n)) {
            stop("No N defined")
        }
        
        if (n > 10) {
            stop("Too high")
        }
        
        if (n < 1) {
            stop("Too low")
        }
        
        paste("N is",n)
    })
    
    observeEvent(input$goButton, {
        n <- input$numberOfVars
        x <- mtcars[,2:11]
        y <- drop(mtcars[,1])
        
        topNCoefs <- topN(x,y,n)
        names(topNCoefs) <- gsub("xN","",names(topNCoefs))
        #browser()
        output$coefs <- renderText({paste(names(topNCoefs),topNCoefs,sep = "\n",
                                          collapse = "\n")})
    })
})

topN <- function(x,y,n) {
    p <- ncol(x)
    if (p < 10) {
        stop("there are less than 10 predictors")
    }
    
    pvalues <- numeric(p)
    for(i in seq_len(p)) {
        fit <- lm(y~x[,i])
        summ <- summary(fit)
        pvalues[i] <- summ$coefficients[2,4]
    }
    
    ord <- order(pvalues)
    ord <- ord[1:n]
    browser()
    xN <- as.matrix(x[,ord])
    fit <- lm(y~xN)
    coef(fit)
}
