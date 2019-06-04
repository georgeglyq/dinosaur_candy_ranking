
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    tags$img(src = 'lollipops.jpg', height = 600, width = 1175),
    titlePanel(HTML("<h1><center><font size=20> The Best Candy </font></center></h1>")),
    
    navbarPage("Navigation",
        tabPanel('Introduction', 
                 p("Project Overview
                    In this project we will be producing data in regard to the best candy of a category 
                    (such as chocolate or nut based), suggested candies that are similar to a user preference,
                    and their contents. Our purpose is to inform consumers about what is the best candy for 
                    themselves or their kids in terms of flavor and nutritional facts. It will also be useful
                    to prospective candy makers which are looking to make the best tasting candies based on
                    current preferences. This is important because it might save someone an extra trip to the 
                    store because a candy isn't good or is too unhealthy. Market research and learning consumer
                    preferences is also very important for a product to be successful.")
                 ), 
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
