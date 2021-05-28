library(dplyr)

# loading the dataset

data <- read.csv('https://raw.githubusercontent.com/deepanshu88/data/master/sampledata.csv')

# glimpse of the dataset

glimpse(data)


# Example 1 : Selecting Random N Rows

sample_n(data,3)


# Example 2 : Selecting Random Fraction of Rows

sample_frac(data,0.20)


# Example 3 : Remove Duplicate Rows based on all the variables (Complete Row)

x1 <- distinct(data)

# Example 4 : Remove Duplicate Rows based on a variable

x2 <- distinct(data,'Alabama',.keep_all = T)


# Example 5 : select( ) Function

data %>% select(c('State','Y2002'))


# Example 6 : Selecting Variables (or Columns)

data %>% select(State:Y2008)


# Example 7 : Dropping Variables

data %>% select(-"Y2008")
data %>% select(-c("Y2002","Y2005"))


# Example 8 : Selecting or Dropping Variables starts with 'Y'

data %>% select(-starts_with("Y"))


# Example 9 : Selecting Variables contain 'I' in their names

data %>% select(contains("I"))


# Example 10 : Reorder Variables

data %>% select("State",everything())


# Example 11 : Rename Variables

data %>% rename("STATE" = "State")


# Example 12 : Filter Rows

data %>% filter(Index == 'A')


# Example 13 : Multiple Selection Criteria

data %>% filter(Index %in% c('A','C'))

# Example 14 : 'AND' Condition in Selection Criteria
# Suppose you need to apply 'AND' condition. In this case, we are picking data for 'A' and 'C' in the column 'Index' and income greater than 1.3 million in Year 2002.

data %>% filter(Index %in% c('A','C') & Y2002 >= 1300000)


# Example 15 : 'OR' Condition in Selection Criteria

data %>% filter(Index %in% c('A','C') | Y2002 >= 1300000)


# Example 16 : NOT Condition

data %>% filter(!Index %in% c('A','C'))


# Example 17 : CONTAINS Condition
# The grepl function is used to search for pattern matching. In the following code, we are looking for records wherein column state contains 'Ar' in their name.

data %>% filter(grepl('Ar',State))


# Example 18 : Summarize selected variables
# we are calculating mean and median for the variable Y2015

data  %>% summarize(Mean_2015 = mean(Y2015),Median_2015 = median(Y2015))


# Example 19 : Summarize Multiple Variables
# In the following example, we are calculating number of records, mean and median for variables Y2005 and Y2006. The summarise_at function allows us to select multiple variables by their names.

# way 1

data %>% summarize_at(vars(Y2005,Y2006),funs(n(),mean,median))

# way 2

data %>% summarize_at(vars(Y2005,Y2006),list(n = ~n(),M = mean,MD = median))

# way 3

data %>% summarize_at(vars(Y2005,Y2006),list(~n(),~mean(.),~median(.)))

# Example 20 : Summarize with Custom Functions

data %>% summarize_at(vars(Y2002,Y2005),funs(mean,median),na.rm = T)

data %>% summarize_at(vars(Y2003,Y2008),funs(n(),missing = sum(is.na(.)),mean(.,na.rm = T),median(.,na.rm = T)))


# How to apply Non-Standard Functions

set.seed(123)
mydata <- data.frame(X1 = sample(1:100,100),X2 = runif(100))
mydata %>% summarize_at(vars(X1,X2),function(x) var(x - mean(x)))


# Example 21 : Summarize all Numeric Variables

data %>% summarize_if(is.numeric,funs(n(),mean,median))

# Alternative Method :

numdata <- mydata[sapply(mydata,is.numeric)]
numdata


# arrange() function
# Example 23 : Sort Data by Multiple Variables

data %>% arrange(Y2002)


# Suppose you need to sort one variable by descending order and other variable by ascending oder.

data %>% arrange(desc(Y2002),Y2003)


# Pipe Operator %>%

data %>% select(Index,State) %>% sample_n(10)


# Summarise Data by Categorical Variable
# We are calculating count and mean of variables Y2011 and Y2012 by variable Index.

data %>% group_by(Index) %>% summarize_at(vars(Y2002,Y2005),funs(mean(.),median(.)))

# Example 25 : Filter Data within a Categorical Variable



###################################################################################################

# Exercises for dply

library(dplyr)

# Exercises
# Use glimpse() to see a quick overview of the data.

glimpse(mtcars)

# Exercise 1
# Print out the hp column using the select() function. Try using the pull() function instead of select to see what the difference is.

mtcars %>% select(hp)
mtcars %>% pull(hp) 


# Exercise 2
# Print out all but the hp column using the select() function.

mtcars %>% select(-hp)


# Exercise 3
# Print out the mpg, hp, vs, am, gear columns. Consider using the colon : symbol to simplfy selection of consecutive columns.

mtcars %>% select(mpg,hp,vs,am,gear)


# Exercise 4
# Create the object mycars containing the columns mpg, hp columns but let the column names be miles_per_gallon, and horse_power respectively and bring the row names into the data frame using tibble::rownames_to_column().


mycars <- mtcars %>% select(mpg,hp) %>% rename(miles_per_gallon = mpg,horse_power = hp)
mycars

# Exercise 5
# Create a new variable in the mycars data frame km_per_litre using the mutate() function. Hint: 1 mpg is 0.425 km/l.

mycars <- mycars %>% mutate(km_per_litre = miles_per_gallon * 0.425)
mycars


# Exercise 6
# Randomly select and print half the observations of mycars. Hint: consider using the sample_frac() function

mycars %>% sample_frac(0.50)


# Exercise 7
# Create a mycars_s object, containing from 10th to 35th row of mycars. Hint: consider using the slice() function

mycars_s <- mycars %>% slice(10:35)
mycars_s

# Exercise 8
# Print out the mycars_s object without any duplicates. Hint: Consider using the distinct() function.

mycars_s %>% distinct()


# Exercise 9
# Print out from mycars_s object all the observations which have mpg>20 and hp>100

mycars_s %>% filter(miles_per_gallon > 20 & horse_power > 100)


# Exercise 10
# Print out the row corresponding to the Lotus Europa car.

glimpse(mtcars)

mtcars["Lotus Europa"]

