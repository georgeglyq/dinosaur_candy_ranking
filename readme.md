This ShinyApp was created in collaboration with Ryan Huang, Maria Matlick, George Gu, and Justin Du.
The data we will be using is the Candy Power Ranking dataset which is from the FiveThirtyEight
blog. <br />
This data was collected through a surveyed sample of 8,000 people. They voted on 269,000 randomly generated candy combinations of
86 sample candies. The data includes different ingredient factors, like if a candy has chocolate or is fruit flavored. It also includes
information regarding price point and sugar content. This data is publicly available [here](https://github.com/fivethirtyeight/data/tree/master/candy-power-ranking). <br />
Our ShinyApp answers the following questions:
* What is considered the best in each ingredient category?? (peanut, chocolate, fruit, etc.)
* What is the price and sugar content compared to the candy's ranking?
* What ingredient factors are in a certain candy?
* What candy would an individual like given their current preference?
<br />
Our App will allow the user to pick an ingredient factor category (ex: chocolate, fruity), and output the highest rating candy that contains that factor
<br />
Our App will create a scatterplot of candy rating vs. price point, and a scatterplot of candy rating vs. sugar content. The user can pick which graph to display,
and can hover over any point to see what candy the point represents.
 <br />
Our App will allow the user to select one of the 86 candies and then display a data frame of the different ingredient factors. The data frame will have a "YES" or a "NO"
in each column depending on if the candy contains that factor or not. It also displays the sugar content percentage of the chosen candy. 
<br />
Our app will also create a recommendation histogram. The user can pick one of the 86 candy options, and then sees a display of candies similar to this one that they would
hopefully also like. The recommended candies must have a score of at least 6 out of the maximum 9, with this score determined on whether the candies contain the same
ingredients and if the sugar percentage is within a 5% range of the chosen candy.
 <br />
 <br />
View our app [here](https://mariamatlick.shinyapps.io/DinosaurCandyRanking/)
