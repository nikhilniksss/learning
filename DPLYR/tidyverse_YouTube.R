library(tidyverse)
options(warn = -1)

# loading dataset

install.packages('gapminder')
library(gapminder)

gapminder %>% filter(country == 'Oman' &
                       year > 1980 &
                       year <= 2000) 

# sorting ascending by year and descending by populations

gapminder %>% arrange(year,desc(pop))


# selecting specific columns

gapminder %>% select(country,lifeExp,pop)


# dropping columns in dplyr

gapminder %>% select(-year)

# starts_with in select (columna that starts with c)

gapminder %>% select(starts_with("c"))

# endwith in select

gapminder %>% select(ends_with("Exp"))

# renaming column names using select

gapminder %>% select(Population = pop)

# renaming using rename function

gapminder %>% select(country,lifeExp,pop) %>% rename(population = pop)

# creating new column using mutate

gapminder %>% filter(country == 'Serbia') %>% 
              select(country,lifeExp,pop,year) %>% 
              rename(population = pop) %>% 
              mutate(pop_million = population/1000000,year_back = year - 10)


# case_when

gapminder %>% mutate(gapminder_ordinal = 
                       case_when(lifeExp < 30 ~ "short life",
                                 lifeExp > 30 & lifeExp <= 60 ~ "Average life",
                                 TRUE ~ "Long life")) %>% 
  slice(6:20)

# summarize

gapminder %>% filter(year == 1982) %>% 
              summarize(n_tot = n(),
                        total_pop = sum(pop),
                        mean_life = mean(lifeExp),
                        range_life = max(lifeExp) - min(lifeExp))

# computing statistics for multiple column at same time

gapminder %>% filter(year == 1982) %>% 
              summarize_at(vars(lifeExp,pop),list(~mean(.),~sd(.)))

# to get summary statistics for all variable

gapminder %>% summarise_all(list(~mean(.)))

# to check if numerical variable is there then calculate

gapminder %>% summarise_if(is.numeric,list(~mean(.)))

# group_by

gapminder %>% group_by(year) %>% summarize(con = n_distinct(country),mean_pop = mean(pop))


### loading billboeard dataset

library(tidyr)

view(billboard)

# gather function

bill<- billboard %>% gather(key = week,value = rank,starts_with('wk'))

summary(bill$rank)

# let's remove NA from data

bill <- billboard %>% gather(key = week,value = rank,starts_with('wk'),na.rm = T)

summary(bill$week)

# let's convert weeks column into numbers

bill <- bill %>% mutate(week = parse_number(week))

summary(bill$week)

# joins 

install.packages('nycflights13')
library(nycflights13)

data(flights)
data(planes)
data(airlines)
data(airports)
data(weather)

flights
planes

flights %>% filter(dest == 'SEA') %>% select(tailnum) %>% 
  left_join(planes %>% select(tailnum,manufacturer),by = "tailnum") %>% 
  count(manufacturer) %>% arrange(desc(n))
