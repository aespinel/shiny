# ui.R

shinyUI(fluidPage(
  titlePanel("Racial Distribution in USA"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Demographic maps with 
        data from the 2010 US Census."),
      
      selectInput("var", 
                  label = "Choose a race to display",
                  choices = c("Percent White", "Percent Black",
                              "Percent Hispanic", "Percent Asian"),
                  selected = "Percent White"),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(0, 100))
    ),
    
    mainPanel(plotOutput("map"))
  )
))