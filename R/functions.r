library(dplyr)
library(ggplot2)
data <- read.csv("../data/candy-data.csv", stringsAsFactors = FALSE)

# function that looks for the best candy based on a selected ingredient
best_candy_ingredient <- function(ingredient) {
  filtered <- data %>%
    select(competitorname, !!rlang::sym(ingredient), winpercent) %>%
    filter(!!rlang::sym(ingredient) == 1) %>%
    filter(winpercent == max(winpercent)) %>%
    select(competitorname)
  my_candy <- filtered$competitorname
  return(my_candy)
}

# function that draws a scatterplot based on the relationship of price/sugar percent vs. best candy ratings
# category = either price or sugar percent
price_best_rating <- function(category) {
  data %>%
    ggplot() +
    geom_point(aes(x = !!rlang::sym(category), y = winpercent)) +
    geom_smooth(method = "lm", aes(x = !!rlang::sym(category), y = winpercent)) +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(x = category, y = "Best Candy Ratings", title = paste0(category, " vs. Best Candy Ratings"))
}

# function that returns the ingredient by candy name
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
  return(selected_row)
}

# function by type e.g. snickers, giving related material 
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
    filter(count > 5) %>% 
    filter(sugarpercent > extract_value("sugarpercent") - 0.05) %>% 
    filter(sugarpercent < extract_value("sugarpercent") + 0.05) 
  return(related_rows)
}
