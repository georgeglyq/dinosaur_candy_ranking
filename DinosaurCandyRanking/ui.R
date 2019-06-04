
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    tags$img(src = 'lollipops.jpg', height = 600, width = 1175),
    titlePanel(HTML("<h1><center><font size=20> The Best Candy </font></center></h1>")),
    
    navbarPage("Navigation",
               tabPanel('Introduction',
                        includeMarkdown("markdownintro.md")
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
                                            choices = c("Price", "Sugar Percentage")),
                                textOutput('pricesugartext')
                                
                            ),
                            mainPanel(
                                p("This graph shows the relation of price or sugar relative to the candy's ranking"),
                                plotOutput("plot1")
                                
                            )
                        )
                        
               ),
               tabPanel('Candy and Their Ingredients', 
                        sidebarLayout(
                            sidebarPanel(
                                p("hello"),
                                radioButtons("factors", "Pick Your Candy",
                                             c("100 Grand" = "100 Grand", "3 Musketeers" = "3 Musketeers", "One Dime" = "One dime",
                                               "One Quarter" = "One quarter", "Air Heads" = "Air Heads", "Almond Joy" = "Almond Joy",
                                               "Baby Ruth" = "Baby Ruth",  "Boston Baked Beans" =  "Boston Baked Beans", "Candy Corn" = "Candy Corn",
                                               "Caramel Apple Pops" = "Caramel Apple Pops", "Charleston Chew" = "Charleston Chew", 
                                               "Chewey Lemonhead Fruit Mix" = "Chewey Lemonhead Fruit Mix", "Chiclets" = "Chiclets",
                                               "Dots" = "Dots", "Dum Dums" = "Dum Dums", "Fruit Chews" = "Fruit Chews", "Fun Dip" = "Fun Dip",
                                               "Gobstoppers" =  "Gobstopper", "Haribo Gold Bears" = "Haribo Gold Bears", 
                                               "Haribo Happy Cola" =  "Haribo Happy Cola",  "Haribo Sour Bears" =  "Haribo Sour Bears", 
                                               "Haribo Twin Snakes" = "Haribo Twin Snakes", "Jawbusters" = "Jawbusters", "Junior Mints" = "Junior Mints", 
                                               "Kit Kat" =  "Kit Kat",  "Laffy Taffy" =  "Laffy Taffy",  "Lemonhead" =  "Lemonhead",
                                               "Lifesavers Big Ring Gummies" = "Lifesavers big ring gummies", "Mike & Ike" =  "Mike & Ike",
                                               "Milk Duds" = "Milk Duds",  "Milky Way" = "Milky Way", "Milky Way Midnight", "Milky Way Simply Caramel" = "Milky Way Simply Caramel",
                                               "Mr Good Bar" = "Mr Good Bar", "Nerds" = "Nerds", "Mounds" = "Mounds",  "Nestle Butterfinger" =  "Nestle Butterfinger",
                                               "Nestle Crunch" = "Nestle Crunch", "Nik L Nip" =  "Nik L Nip", "Now & Later" = "Now & Later", "Payday" = "Payday",
                                               "Peanut M&Ms" = "Peanut M&Ms", "Pixie Sticks" = "Pixie Sticks", "Pop Rocks" = "Pop Rocks", "Red Vines" = "Red vines", "Ring Pop" = "Ring pop",
                                               "Rolo" = "Rolo", "Root Beer Barrels" = "Root Beer Barrels", "Runts" = "Runts", "Sixlets" = "Sixlets",
                                               "Skittles Original" = "Skittles original", "Skittles Wildberry" = "Skittles wildberry", 
                                               "Nestle Smarties" = "Nestle Smarties", "Smarties Candy" = "Smarties candy", "Snickers" = "Snickers",
                                               "Snickers Crisper" =  "Snickers Crisper", "Sour Patch Kids" = "Sour Patch Kids", "Sour Patch Tricksters" = "Sour Patch Tricksters",
                                               "Starburst" = "Starburst",  "Strawberry Bon Bons" = "Strawberry bon bons", "Sugar Babies" = "Sugar Babies", "Sugar Daddy" = "Sugar Daddy", 
                                               "Super Bubble" = "Super Bubble", "Swedish Fish" = "Swedish Fish",  "Tootsie Pop" =  "Tootsie Pop", 
                                               "Tootsie Roll Juniors" = "Tootsie Roll Juniors", "Tootsie Roll Midgies" = "Tootsie Roll Midgies", 
                                               "Tootsie Roll Snack Bars" = "Tootsie Roll Snack Bars" , "Trolli Sour Bites" = "Trolli Sour Bites",
                                               "Twix" = "Twix", "Twizzlers" = "Twizzlers", "Warheads" = "Warheads", "Whoppers" = "Whoppers")
                                             
                                )
                            ),
                            mainPanel(
                                dataTableOutput("candyingredientslist")
                            )
                        )
               ),
               tabPanel('Find Something New!')
    )))

# #Tab comments 
# Best candy based on ingredient
# Here we take candies that contain a specific ingredient that the user chooses, and the graph outputs the best candy in that segment. We first filter out the category and then filter by the candy's power ranking.
# Price or sugar vs candy ranking
# This graph shows the relation of price or sugar relative to the candy's ranking. The highest ranked candy based on price 
# Candy and ingredients
# In this function the user inputs their candy and information about candy's ingredients is outputted.
# Find something new
# Here a user inputs a candy which they like and similar candies based on sugar percent and ingredients are displayed.

# ,
# , ,"Hershey√.s Kisses" = "Hershey√.s Kisses"
# "Hershey√.s Krackel" = "Hershey√.s Krackel", ,
#,
# "Peanut butter M&M√.s" =  "Peanut butter M&M√.s",,
# "M&M√.s" = "M&M√.s",

# , ,
# ,
# "Reese√.s Miniatures" = "Reese√.s Miniatures", "Reese√.s Peanut Butter Cup"= "Reese√.s Peanut Butter cup",
# "Reese√.s pieces" =  "Reese√.s pieces",  "Reese√.s Stuffed With Pieces" =  "Reese√.s stuffed with pieces",
# ,"Welch's Fruit Snacks" = "Welch√.s Fruit Snacks"
# 
# "Werther's Original Caramel" = "Werther√.s Original Caramel", ")
