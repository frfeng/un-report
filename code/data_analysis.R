library(tidyverse)

gapminder_data <- read_csv("data/gapminder_data.csv")

# View(gapminder_data)


summarize(gapminder_data, mean(lifeExp))

# summarize(gapminder_data, mean(lifeExp))


# piping function: %>%
gapminder_data %>% summarize(averageLifeExp <- mean(lifeExp))

# CTRL+SHIFT+M shortcut for %>%

gapminder_data %>% summarize(averageLifeExp = mean(pop))

gapminder_data %>% summarize(averageLifeExp = sum(pop))

# filter

gapminder_data %>% summarize(averageLifeExp <- mean(pop), 
                            recent_year <- max(year))

gapminder_data %>% filter(year == max(year)) %>% summarize(averageLifeExp = mean(lifeExp))

# find the average GDP per capita for the first year in the dataset

# gapminder_data %>% 
#   filter(year == min(year))
#   summarize(GDP_per_capita = mean(gdpPercap))

  gapminder_data %>% filter(year == min(year))

# we can use : >, <, >=, <=

  gapminder_data %>% 
  group_by(by = year) %>% 
  summarize(averageLifeExp = mean(lifeExp))

# find the mean life expectancy for each continent

  gapminder_data %>% 
  group_by(by = continent) %>% 
  summarize(averageLifeExp = mean(lifeExp))

# the code below does not work. Might need to use a pivot table. 
# gapminder_data %>% 
#   group_by(by = [year, continent]) %>% 
#   summarize(averageLifeExp = mean(lifeExp))

# mutate -  add more column to your dataset

  gapminder_data %>% 
  mutate(gdp = gdpPercap * pop)

  gapminder_data %>% 
  mutate(gdp_million = gdpPercap * pop / 10^6)


  gapminder_data %>% 
  select(year, pop)

  gapminder_data %>% 
  select(-continent)

  # gapminder_data <- gapmider_data %>% 
  # select(-continent)

  gapminder_data %>% 
  select(-gdpPercap, pop)


# long vs. wide
# pivot_longer, and pivot_wider

  gapminder_data %>% 
  select(country, continent, year, lifeExp) %>% 
  pivot_wider(names_from = year, values_from = lifeExp)

  gapminder_data %>% 
  select(country, continent, year, lifeExp) %>% 
  pivot_wider(names_from = continent, values_from = lifeExp)

  gapminder_data



# rename() - rename columns


# Create a new dataset with only data from the Americas and 2007

data_Americas_2007 <- gapmider_data %>% 
  filter(continent == "Americas", year == 2007) %>% 
  select(-continent, -year)

