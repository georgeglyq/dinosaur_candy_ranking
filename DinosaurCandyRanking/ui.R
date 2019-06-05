library(shiny)
library(plotly)
library(markdown)
library(shinythemes)

# Define UI for application 
shinyUI(fluidPage(
    
    theme = shinytheme("united"),
    # Application title and header image of candy
    title = "The Best Candy",
    HTML('<center><img src="lollipops.jpg" height="550"></center>'),
    br(),
    titlePanel(HTML("<h1><center><font size=20> The Best Candy </font></center></h1>")),
    br(),
    
    # Creates a Navbar with 5 tabs: Introduction, Best Candy Based on Ingredient, Price or Sugar vs. 
    # Candy rating, Candy and Their Ingredients, and, Find Something New
    navbarPage("Navigation",
               tabPanel('Introduction', icon = icon("home"),
                        includeMarkdown("markdownintro.md")
               ), 
               
               # Gives textual output based on user choice what the best candy is depending on ingredient
               tabPanel('Best Candy Based on Ingredient', icon = icon("crown"),
                        sidebarLayout(
                            # Has a sidepanel with radio buttons for the different ingredients, the user can select one
                            sidebarPanel(
                                radioButtons("ingredients", "Ingredients:",
                                             c("Chocolate" = "chocolate", "Fruity" = "fruity",
                                               "Caramel" = "caramel", "Peanuts and Almonds" = "peanutyalmondy",
                                               "Nougat" = "nougat", "Crisped Rice Wafer" = "crispedricewafer")
                                )
                            ),
                            # Maine panel displays textual output of the highest ranked candy that contains the 
                            # ingredient that the user selected from the buttons
                            mainPanel(
                                p("Pick an ingredient, and based on our algorithm we will tell you the best candy that contains it!"),
                                br(),
                                textOutput('candybasedoningredient'),
                                tags$head(tags$style("#candybasedoningredient{color: blue; font-size: 18px; font-style: bold}"))
                            )
                            
                        )
                        
               ),
               
               # Plots an interactive scatter plot either based on Price vs Candy Ranking or Sugar Content vs Candy Ranking
               tabPanel('Price or Sugar vs. Candy Ranking', icon = icon("donate"),
                        sidebarLayout(
                            # The user chooses to plot based on either price or sugar percentage
                            sidebarPanel(
                                selectInput(inputId = "variable",
                                            label = "Choose a Factor:",
                                            choices = c("Price", "Sugar Percentage")),
                                textOutput('pricesugartext')
                                
                            ),
                            # Produces a plot where you can hover over a point and see what kind of candy it is
                            mainPanel(
                                p("This graph shows the relation of price or sugar content relative to the candy's ranking."),
                                p("Hover over a point to see what candy it is!"),
                                plotlyOutput("plot1")
                            )
                        )
                        
               ),
               
               # A user can choose a candy from all of the options and a dataframe is returned telling them whether or not
               # it contains an ingredient from the list
               tabPanel('Candy and Their Ingredients', icon = icon("search"),
                        sidebarLayout(
                            # Provides a drop down menu with all of the candy options
                            sidebarPanel(
                                selectInput( inputId = "factors", 
                                             label = "Pick Your Candy",
                                             choices = c("100 Grand" = "100 Grand", "3 Musketeers" = "3 Musketeers", 
                                                         "One Dime" = "One dime",
                                                         "One Quarter" = "One quarter", "Air Heads" = "Air Heads", 
                                                         "Almond Joy" = "Almond Joy",
                                                         "Baby Ruth" = "Baby Ruth",  "Boston Baked Beans" =  "Boston Baked Beans", 
                                                         "Candy Corn" = "Candy Corn",
                                                         "Caramel Apple Pops" = "Caramel Apple Pops", "Charleston Chew" = "Charleston Chew", 
                                                         "Chewey Lemonhead Fruit Mix" = "Chewey Lemonhead Fruit Mix",
                                                         "Chiclets" = "Chiclets",
                                                         "Dots" = "Dots", "Dum Dums" = "Dum Dums", "Fruit Chews" = "Fruit Chews",
                                                         "Fun Dip" = "Fun Dip",
                                                         "Gobstoppers" =  "Gobstopper", "Haribo Gold Bears" = "Haribo Gold Bears", 
                                                         "Haribo Happy Cola" =  "Haribo Happy Cola",  "Haribo Sour Bears" =  "Haribo Sour Bears", 
                                                         "Haribo Twin Snakes" = "Haribo Twin Snakes", "Hersheys Kisses" = "Hersheys Kisses",
                                                         "Hersheys Krackel" = "Hersheys Krackel",
                                                         "Jawbusters" = "Jawbusters", "Junior Mints" = "Junior Mints",
                                                         "Kit Kat" =  "Kit Kat",  "Laffy Taffy" =  "Laffy Taffy",  "Lemonhead" =  "Lemonhead",
                                                         "Lifesavers Big Ring Gummies" = "Lifesavers big ring gummies",
                                                         "Peanut butter M&Ms" =  "Peanut butter M&Ms",
                                                         "M&Ms" = "M&Ms","Mike & Ike" =  "Mike & Ike",
                                                         "Milk Duds" = "Milk Duds",  "Milky Way" = "Milky Way", "Milky Way Midnight",
                                                         "Milky Way Simply Caramel" = "Milky Way Simply Caramel",
                                                         "Mr Good Bar" = "Mr Good Bar", "Nerds" = "Nerds", "Mounds" = "Mounds",
                                                         "Nestle Butterfinger" =  "Nestle Butterfinger",
                                                         "Nestle Crunch" = "Nestle Crunch", "Nik L Nip" =  "Nik L Nip", "Now & Later" = "Now & Later",
                                                         "Payday" = "Payday",
                                                         "Peanut M&Ms" = "Peanut M&Ms", "Pixie Sticks" = "Pixie Sticks", "Pop Rocks" = "Pop Rocks",
                                                         "Red Vines" = "Red vines",
                                                         "Reeses Miniatures" = "Reeses Miniatures", "Reeses Peanut Butter Cup"= "Reeses Peanut Butter cup",
                                                         "Reeses pieces" =  "Reeses pieces",  "Reeses Stuffed With Pieces" =  "Reeses stuffed with pieces",
                                                         "Ring Pop" = "Ring pop",
                                                         "Rolo" = "Rolo", "Root Beer Barrels" = "Root Beer Barrels", "Runts" = "Runts",
                                                         "Sixlets" = "Sixlets",
                                                         "Skittles Original" = "Skittles original", "Skittles Wildberry" = "Skittles wildberry",
                                                         "Nestle Smarties" = "Nestle Smarties", "Smarties Candy" = "Smarties candy",
                                                         "Snickers" = "Snickers",
                                                         "Snickers Crisper" =  "Snickers Crisper", "Sour Patch Kids" = "Sour Patch Kids",
                                                         "Sour Patch Tricksters" = "Sour Patch Tricksters",
                                                         "Starburst" = "Starburst",  "Strawberry Bon Bons" = "Strawberry bon bons",
                                                         "Sugar Babies" = "Sugar Babies", "Sugar Daddy" = "Sugar Daddy",
                                                         "Super Bubble" = "Super Bubble", "Swedish Fish" = "Swedish Fish",  "Tootsie Pop" =  "Tootsie Pop",
                                                         "Tootsie Roll Juniors" = "Tootsie Roll Juniors", "Tootsie Roll Midgies" = "Tootsie Roll Midgies",
                                                         "Tootsie Roll Snack Bars" = "Tootsie Roll Snack Bars" , "Trolli Sour Bites" = "Trolli Sour Bites",
                                                         "Twix" = "Twix", "Twizzlers" = "Twizzlers", "Warheads" = "Warheads",
                                                         "Welchs Fruit Snacks" = "Welchs Fruit Snacks",
                                                         "Werther's Original Caramel" = "Werthers Original Caramel", "Whoppers" = "Whoppers")
                                             
                                )
                            ),
                            # Outputs a simple dataframe that says YES if it has an ingredient, NO if it doesn't
                            mainPanel(
                                p("Here, see if the candy you picked contains a certain ingredient (YES) or doesn't (NO)"),
                                p("Hint: pluribus means multiple pieces, like Skittles!"),
                                tableOutput("candyingredientslist")
                            )
                        )
               ),
               # Allows a user to select a candy from a dropdown menu and outputs a graph of similar candies
               tabPanel('Find Something New!', icon = icon("hand-point-right"),
                        sidebarLayout(
                            # Provides a dropdown menu of all the candies and the user can select one
                            sidebarPanel(
                                selectInput(inputId = "candies", 
                                            label = "Pick Your Candy",
                                            choices = c("100 Grand" = "100 Grand", "3 Musketeers" = "3 Musketeers", 
                                                        "One Dime" = "One dime",
                                                        "One Quarter" = "One quarter", "Air Heads" = "Air Heads", 
                                                        "Almond Joy" = "Almond Joy",
                                                        "Baby Ruth" = "Baby Ruth",  "Boston Baked Beans" =  "Boston Baked Beans", 
                                                        "Candy Corn" = "Candy Corn",
                                                        "Caramel Apple Pops" = "Caramel Apple Pops", "Charleston Chew" = "Charleston Chew", 
                                                        "Chewey Lemonhead Fruit Mix" = "Chewey Lemonhead Fruit Mix",
                                                        "Chiclets" = "Chiclets",
                                                        "Dots" = "Dots", "Dum Dums" = "Dum Dums", "Fruit Chews" = "Fruit Chews", 
                                                        "Fun Dip" = "Fun Dip",
                                                        "Gobstoppers" =  "Gobstopper", "Haribo Gold Bears" = "Haribo Gold Bears", 
                                                        "Haribo Happy Cola" =  "Haribo Happy Cola",  "Haribo Sour Bears" =  "Haribo Sour Bears", 
                                                        "Haribo Twin Snakes" = "Haribo Twin Snakes", "Hersheys Kisses" = "Hersheys Kisses",
                                                        "Hersheys Krackel" = "Hersheys Krackel",
                                                        "Jawbusters" = "Jawbusters", "Junior Mints" = "Junior Mints",
                                                        "Kit Kat" =  "Kit Kat",  "Laffy Taffy" =  "Laffy Taffy",  "Lemonhead" =  "Lemonhead",
                                                        "Lifesavers Big Ring Gummies" = "Lifesavers big ring gummies",
                                                        "Peanut butter M&Ms" =  "Peanut butter M&Ms",
                                                        "M&Ms" = "M&Ms","Mike & Ike" =  "Mike & Ike",
                                                        "Milk Duds" = "Milk Duds",  "Milky Way" = "Milky Way", "Milky Way Midnight",
                                                        "Milky Way Simply Caramel" = "Milky Way Simply Caramel",
                                                        "Mr Good Bar" = "Mr Good Bar", "Nerds" = "Nerds", "Mounds" = "Mounds",
                                                        "Nestle Butterfinger" =  "Nestle Butterfinger",
                                                        "Nestle Crunch" = "Nestle Crunch", "Nik L Nip" =  "Nik L Nip", "Now & Later" = "Now & Later",
                                                        "Payday" = "Payday",
                                                        "Peanut M&Ms" = "Peanut M&Ms", "Pixie Sticks" = "Pixie Sticks", "Pop Rocks" = "Pop Rocks",
                                                        "Red Vines" = "Red vines",
                                                        "Reeses Miniatures" = "Reeses Miniatures", "Reeses Peanut Butter Cup"= "Reeses Peanut Butter cup",
                                                        "Reeses pieces" =  "Reeses pieces",  "Reeses Stuffed With Pieces" =  "Reeses stuffed with pieces",
                                                        "Ring Pop" = "Ring pop",
                                                        "Rolo" = "Rolo", "Root Beer Barrels" = "Root Beer Barrels", "Runts" = "Runts",
                                                        "Sixlets" = "Sixlets",
                                                        "Skittles Original" = "Skittles original", "Skittles Wildberry" = "Skittles wildberry",
                                                        "Nestle Smarties" = "Nestle Smarties", "Smarties Candy" = "Smarties candy",
                                                        "Snickers" = "Snickers",
                                                        "Snickers Crisper" =  "Snickers Crisper", "Sour Patch Kids" = "Sour Patch Kids",
                                                        "Sour Patch Tricksters" = "Sour Patch Tricksters",
                                                        "Starburst" = "Starburst",  "Strawberry Bon Bons" = "Strawberry bon bons",
                                                        "Sugar Babies" = "Sugar Babies", "Sugar Daddy" = "Sugar Daddy",
                                                        "Super Bubble" = "Super Bubble", "Swedish Fish" = "Swedish Fish",  "Tootsie Pop" =  "Tootsie Pop",
                                                        "Tootsie Roll Juniors" = "Tootsie Roll Juniors", "Tootsie Roll Midgies" = "Tootsie Roll Midgies",
                                                        "Tootsie Roll Snack Bars" = "Tootsie Roll Snack Bars" , "Trolli Sour Bites" = "Trolli Sour Bites",
                                                        "Twix" = "Twix", "Twizzlers" = "Twizzlers", "Warheads" = "Warheads",
                                                        "Welchs Fruit Snacks" = "Welchs Fruit Snacks",
                                                        "Werther's Original Caramel" = "Werthers Original Caramel", "Whoppers" = "Whoppers")
                                            
                                )
                            ),
                            # Produces a bar graph that contains similar candies, with the closer a bar height is to the
                            # selected candy's bar height meaning how similar the candies are to one another
                            # Similarity is decided on matching ingredients and sugar content
                            mainPanel(
                                p("Here, see what candies are the most similar to the candy you picked, based on ingredients and sugar content."),
                                p("The closer a candy's bar height is to your selected candy's bar, the more similar it is."),
                                plotlyOutput("similarcandy")
                            )
                        )
               ),
               br(),
               br(),
               br(),
               br(),
               br()
    )))

