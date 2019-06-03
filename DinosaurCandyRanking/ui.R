
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    tags$img(src = 'lollipops.jpg', height = 600, width = 1175),
    titlePanel(HTML("<h1><center><font size=20> The Best Candy </font></center></h1>")),
    
    navbarPage("Navigation",
        tabPanel('Introduction'), 
        tabPanel('Best Candy Based on Ingredient', 
                 sidebarLayout(
                     sidebarPanel(
                         radioButtons("ingredients", "Ingredients:",
                                      c("Chocolate" = "chocolate", "Fruity" = "fruity",
                                        "Caramel" = "caramel", "Peanuts and Almonds" = "peanutyalmondy",
                                        "Nougat" = "nougat", "Crisped Rice Wafer" = "crispedricewafer")
                        )
                     ),
                     mainPanel(
                         p("Pick an ingredient, and based on our algorithm we will tell you the best candy that contains it!"),
                         textOutput('candybasedoningredient')
                         
                     )
                     
                 )
                 
        ),
        
        tabPanel('Price or Sugar vs. Candy Ranking',
                 sidebarLayout(
                     sidebarPanel(
                         selectInput(inputId = "variable",
                                     label = "Choose a Factor:",
                                     choices = c("Price", "Sugar Percentage"))
                     ),
                     mainPanel(
                         plotOutput("plot1")
                     )
                 )
                
        ),
        tabPanel('Candy and Their Ingredients'
                 ),
        tabPanel('Find Something New!' 
                 # sidebarLayout(
                 #     sidebarPanel(
                 #         checkboxGroupInput("factors", "Your Candy Preferences",
                 #                            c("Chocolate" = "chocolate", "Fruity" = "fruity",
                 #                              "Caramel" = "caramel", "Peanuts and Almonds" = "peanutyalmondy",
                 #                              "Nougat" = "nougat", "Crisped Rice Wafer" = "crispedricewafer",
                 #                              "Hard" = "hard", "Bar" = "bar", "Pieces" = "pluribus"))
                 #     ),
                 #     mainPanel(
                 #         textOutput("candybasedonpreference")
                 #     )
                 #     
                  ),
        tabPanel('Conclusion')
                 
    )
))
