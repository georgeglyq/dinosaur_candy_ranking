
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    tags$img(src = 'lollipops.jpg', height = 600, width = 1175),
    titlePanel(HTML("<h1><center><font size=20> The Best Candy </font></center></h1>")),
    
    navbarPage("Navigation",
        tabPanel('Introduction', p("Project Overview
                                   In this project we will be producing data in regard to the best candy of a category 
                                   (such as chocolate or nut based), suggested candies that are similar to a user preference, 
                                   and their contents. Our purpose is to inform consumers about what is the best candy for
                                   themselves or their kids in terms of flavor and nutritional facts. It will also be useful
                                   to prospective candy makers which are looking to make the best tasting candies based on 
                                   current preferences. This is important because it might save someone an extra trip to the 
                                   store because a candy isn't good or is too unhealthy. Market research and learning consumer
                                   preferences is also very important for a product to be successful. 
                                   Audience
                                   Our audience will be people who are looking to buy candies for themselves or their children
                                   that would like to pick the best tasting candy or are looking for healthier alternatives.
                                   We are targeting companies who are looking to make candies for the public and need information
                                   about consumer preferences. 
                                   Data
                                   The data we will be using is the Candy Power Ranking dataset which is from the FiveThirtyEight 
                                   blog. This data was collected through voting of 269,000 randomly generated candy combinations and 
                                   86 samples which have specific information including things like ingredients, cost, and sugar 
                                   content. This data is publicly available at https://github.com/fivethirtyeight/data/tree/master/candy-power-ranking.
                                   Questions  
                                   Test categories include the following
                                   What is considered the best category in its class? (peanut, chocolate, fruit, etc.)
                                   What candy would an individual like given their current preference?
                                       What are the nutritional facts for a certain candy?"
        )), 
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

# #Tab comments 
# Best candy based on ingredient
# Here we take candies that contain a specific ingredient that the user chooses, and the graph outputs the best candy in that segment. We first filter out the category and then filter by the candy's power ranking.
# Price or sugar vs candy ranking
# This graph shows the relation of price or sugar relative to the candy's ranking. The highest ranked candy based on price 
# Candy and ingredients
# In this function the user inputs their candy and information about candy's ingredients is outputted.
# Find something new
# Here a user inputs a candy which they like and similar candies based on sugar percent and ingredients are displayed.


