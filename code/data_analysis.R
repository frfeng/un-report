# workshop day 2

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


# Goals: data fro a year that is close to 2007
# a column for country and we want columns for different types of co2 emissions (total, per capita)

co2_emissions <- read_csv("data/co2-un-data.csv", skip = 2,
         col_names = c("region", "country", "year", "series", "value", 
                       "footnotes", "source")) %>% 
  select(-region, -footnotes, -source) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>%
  pivot_wider(names_from = series, values_from = value) %>% 
  filter(year == 2005) %>% 
  select(-year) %>% 
  mutate(country = recode(country, "Bolivia (Plurin. State of)" = "Bolivia", 
                          "United States of America" = "United States", 
                          "Venezuela (Boliv. Rep. of)" = "Venezuela"))

View(co2_emissions)


gapminder_data <- read_csv("data/gapminder_data.csv") %>% 
  filter(year == 2007, continent == "Americas") %>% 
  select(-continent, -year) %>% 
  mutate(country = recode(country, "Puerto Rico" = "United States")) %>% 
  group_by(country) %>% 
  summarize(lifeExp = sum(lifeExp * pop)/sum(pop), 
            gdpPercap = sum(gdpPercap * pop) / sum(pop), 
            pop = sum(pop))

View(gapminder_data)


# joining the data sets

anti_join(gapminder_data, co2_emissions)

gapminder_co2 = inner_join(gapminder_data, co2_emissions, by = "country")

gapminder_data %>% inner_join(co2_emissions, by = "country")


View(gapminder_co2_region)

# motate and the if_else

gapminder_co2_region <- gapminder_co2 %>% 
  mutate(region = if_else(country == "Canada" | 
                            country == "United States" | 
                            country == "Mexico", "north", "south"))

# | - or
# && - and
# ! - not


gapminder_co2_region %>% 
  mutate(region2 = if_else(country %in% c("Canada", "United States", "Mexico"), "north", "south"))

# 
ggplot(data = gapminder_co2_region) +
  aes(x = gdpPercap, y = per_capita_emissions, color = region) +
  geom_point()

