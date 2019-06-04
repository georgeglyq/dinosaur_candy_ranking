library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(plotly)

data <- read.csv("./data/candy-data.csv", stringsAsFactors = FALSE)

# function that looks for the best candy based on a selected ingredient
# Outputs text telling the user what the best candy is
best_candy_ingredient <- function(ingredient) {
    filtered <- data %>%
        select(competitorname, !!rlang::sym(ingredient), winpercent) %>%
        filter(!!rlang::sym(ingredient) == 1) %>%
        filter(winpercent == max(winpercent)) %>%
        select(competitorname)
    my_candy <- filtered$competitorname
    paste(c("The best candy based on your choice is: ", my_candy))
}

# function that draws a scatterplot based on the relationship of price/sugar percent vs. best candy ratings
# category = either price or sugar percent
price_best_rating <- function(category) {
    label <- category
    if(category == "Price") {
        category <- "pricepercent"
        cat("Price isn't the leading factor in determining if a candy is popular among consumers")
    } else {
        category <- "sugarpercent"
        cat("There is a slight positive linear trend between how high a candy is ranked and how much sugar it contains, with people generally preferring candies with more sugar")
    }
    
        my_plot <- data %>% 
            ggplot() +
            geom_point(aes(x = !!rlang::sym(category), y = winpercent)) +
            aes_string(text = "competitorname") +
            theme(plot.title = element_text(hjust = 0.5)) +
            labs(x = label, y = "Best Candy Ratings", title = paste0(label, " vs. Best Candy Ratings"))
        ggplotly(my_plot, source = "select", tooltip = c("text")) %>% config(displayModeBar = F)
}

# function that returns the list of ingredients and "YES" or "NO" based on if the inputted 
# candy contains it
name_function <- function(name){
    selected_row <- data %>%
        select(-winpercent, -pricepercent) %>%
        filter(competitorname == name) %>%
        mutate(Chocolate = ifelse(chocolate != 0, "YES", "NO")) %>%
        mutate(Fruity = ifelse(fruity != 0, "YES", "NO")) %>%
        mutate(Caramel = ifelse(caramel != 0, "YES", "NO")) %>%
        mutate(Peanuty_Almondy = ifelse(peanutyalmondy != 0, "YES", "NO")) %>%
        mutate(Nougat = ifelse(nougat != 0, "YES", "NO")) %>%
        mutate(Crisped_Rice_Wafer = ifelse(crispedricewafer != 0, "YES", "NO")) %>%
        mutate(Hard = ifelse(hard != 0, "YES", "NO")) %>%
        mutate(Pluribus = ifelse(pluribus != 0, "YES", "NO")) %>%
        mutate(Sugar_Content = paste0(round(sugarpercent*100, digit = 2), "%")) %>%
        select(Chocolate, Fruity, Caramel, Peanuty_Almondy, Nougat, Crisped_Rice_Wafer,
               Hard, Pluribus, Sugar_Content)
    selected_row <- data.table(selected_row)
}



type_function <- function(type) {
    # function that returns the value of the selected candy in each column
    extract_value <- function(category) {
        data %>% 
            filter(competitorname == type) %>% 
            select(category) %>% 
            pull()
    }
    # filter out similar candies that have values equal or close to the selected candies
    # there are 9 yes/no variables in total. If more than 5 variables are identical as well as 
    # a less than 5 percent difference in sugar percent, we clarify those candies as the similar ones
    related_rows <- data %>% 
        mutate(count = abs(extract_value("chocolate") - chocolate) + 
                   abs(extract_value("fruity") - fruity) +
                   abs(extract_value("caramel") - caramel) +
                   abs(extract_value("peanutyalmondy") - peanutyalmondy) +
                   abs(extract_value("nougat") - nougat) +
                   abs(extract_value("crispedricewafer") - crispedricewafer) +
                   abs(extract_value("hard") - hard) +
                   abs(extract_value("bar") - bar) +
                   abs(extract_value("pluribus") - pluribus)) %>% 
        
        filter(9-count > 5) %>%
        filter(sugarpercent > extract_value("sugarpercent") - 0.05) %>% 
        filter(sugarpercent < extract_value("sugarpercent") + 0.05) 
    return(related_rows)
}

# function that returns a histogram that tells how many similarities do the candies have with the selected candy
similarity_histogram <- function(candy) {
    data_set <- type_function(candy) %>% 
        select(competitorname, count)
    histogram <- ggplot(data_set, aes(competitorname, 9-count, fill = competitorname))  +
        geom_col() +
        theme(plot.title = element_text(hjust = 0.5)) +    
        labs(x = "Candy Name", y = "Similarity Score Out of 9", title = paste0("Candies Similar to ", candy), fill = "Similar Candies")
    return(histogram)
}



shinyServer(function(input, output) {
    # outputs the best candy based on user selected ingredient
    output$candybasedoningredient <-  renderText({
        best_candy_ingredient(input$ingredients)
    })
    
    # outputs a scatter plot with the x value either being price or sugar content based 
    # on user specfication
    output$plot1 <- renderPlotly({
        price_best_rating(input$variable)
    })
    
    # Outputs text related to the graph based on if the graph is plotting price or sugar
    output$pricesugartext <-  renderPrint({
        price_best_rating(input$variable)
    })

    # Outputs a datatable of ingredients and whether a candy contains it or not based on
    # user input
    output$candyingredientslist <-  renderTable({
        name_function(input$factors)
    })
    
    # Outputs a histogram of candies and how similar they are compared to a user
    # selected candy
    output$similarcandy <- renderPlot({
        similarity_histogram(input$candies)
    })
    
    
})


