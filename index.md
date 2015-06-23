---
title       : Races in USA
subtitle    : Based on census 2010
author      : Alvaro Espinel
job         : Data Science
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Race Distribution  in USA
## Based on US census 2010


# Introduction

This presentation contains the elements included in the shiny application (ui.R, server.R and helpers.R) to read the data associated to the Racial distribution by county in the United Sataes of America (2010).


```
##              name total.pop white black hispanic asian
## 1 alabama,autauga     54571  77.2  19.3      2.4   0.9
## 2 alabama,baldwin    182265  83.5  10.9      4.4   0.7
## 3 alabama,barbour     27457  46.8  47.8      5.1   0.4
## 4    alabama,bibb     22915  75.0  22.9      1.8   0.1
## 5  alabama,blount     57322  88.9   2.5      8.1   0.2
## 6 alabama,bullock     10914  21.9  71.0      7.1   0.2
```



--- .class #id 

### COMPONENTS
## The User Interfase ui.R component
#

In this component the Panel and Side Bar title are declared. The widget to select racial type and the minimun and maxium percentage desire to display.



```r
shinyUI(fluidPage(
  titlePanel("Racial Distribution in USA"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Demographic maps with 
        data from the 2010 US Census."),
      
      :
      :
    
    mainPanel(plotOutput("map"))
  )
))
```



--- .class #id 

## COMPONENTS: ui.R (2) 
#

In this part of the ui.R file are selected the input constraints
#




```r
:
:
 selectInput("var", 
                  label = "Choose a race to display",
                  choices = c("Percent White", "Percent Black",
                              "Percent Hispanic", "Percent Asian"),
                  selected = "Percent White"),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(0, 100))
:
```


--- .class #id 

## COMPONENTS: the server.R

in the first part the libraries are declared for map management (maps and mapproj, also the code to read data)


```r
library(maps)
library(mapproj)
counties <- readRDS("data/counties.rds")
source("helpers.R")
```

```r
shinyServer(
  function(input, output) {
    output$map <- renderPlot({
      args <- switch(input$var,
                     "Percent White" = list(counties$white, "darkgreen", "% White"),
                     "Percent Black" = list(counties$black, "black", "% Black"),
                     "Percent Hispanic" = list(counties$hispanic, "darkorange", "% Hispanic"),
                     "Percent Asian" = list(counties$asian, "darkviolet", "% Asian"))
      
      args$min <- input$range[1]
      args$max <- input$range[2]
      
      do.call(percent_map, args)
    })
  }
)
```


--- .class #id 

## Final presentation


