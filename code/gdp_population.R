# load libraries
library(tidyverse)

# read in data
gapminder_1997 <- read_csv("data/gapminder_1997.csv")


# name <- "Fred"
# name
# age <- 36
# age
# name <- "Harry Potter"
# name


# name <- "Ben"
# name
# age <- 26
# age
# name <- "Harry Potter"
# name


?read_csv()

# gapminder_1997 <- read_csv(file = "gapminder_1997.csv")


# ggplot(data = gapminder_1997) +
#   aes(x = gdpPercap, y = lifeExp) +
#   labs(x = "GDP Per Capita", y = "Life Expectancy")


# ggplot(data = gapminder_1997) +
#   aes(x = gdpPercap) +
#   labs(x = "GDP Per Capita", y = "Life Expectancy") +
#   aes(y = lifeExp)

ggplot(data = gapminder_1997) +
  aes(x = `gdpPercap`) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  labs(title = "Do people in wealthy countries live longer?") +
  geom_point() +
  aes(color = continent) +
  scale_color_brewer(palette = "Set1") +
  aes(size = pop/10^6) +
  labs(size = "Population in millions") +
  aes(shape = continent)


# ggplot(data = gapminder_1997) +
#   aes(x = gdpPercap) +
#   labs(x = "GDP Per Capita") +
#   aes(y = lifeExp) +
#   labs(y = "Life Expectancy") +
#   labs(title = "Do people in wealthy countries live longer?") +
#   geom_point() +
#   aes(shape = continent) +
#   aes(size = pop/10^6) +
#   labs(size = "Population in millions")


# different color palette
RColorBrewer::display.brewer.all()


gapminder_data <- read_csv("data/gapminder_data.csv")

dim(gapminder_data)

ggplot(data = gapminder_data) +
  aes(x = year, y = lifeExp, color = continent, group = country) +
  geom_line()
  



ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_boxplot() +
  geom_jitter(width=.1)



ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_point() + 
  geom_boxplot(alpha=.5)


ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin() + 
  geom_jitter()


ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_boxplot() + 
  geom_jitter()


sample(colors(), size = 10)

ggplot(data = gapminder_1997, aes(x = continent, y = lifeExp, fill = continent)) +
  labs(x = 'Continent', y = 'Life expectancy', title = 'Life expectancy by continent (1997)') +
  geom_jitter(aes(size = pop)) +
  geom_violin(alpha=.5)

# ggplot(data = gapminder_1997, aes(x = continent, y = lifeExp, size = pop)) +
#   labs(x = 'Continent', y = 'Life expectancy', title = 'Life expectancy by continent (1997)') +
#   geom_jitter() +
#   geom_violin(alpha=.5, fill = 'papayawhip')


violin_plot <- ggplot(data = gapminder_1997, mapping = aes(x = continent, y = lifeExp)) +
  labs(x = 'Continent', y = 'Life expectancy', title = 'Life expectancy by continent (1997)') +
  geom_jitter(aes(size = pop)) +
  geom_violin(alpha=.5, aes(fill = continent))


ggplot(data = gapminder_1997) +
  aes(x = lifeExp) +
  geom_histogram(bins = 20) +
  theme_bw()+
  theme(axis.text.x=element_text(angle = 90))

# theme_classic()


# saving plots

ggsave("figures/plot_11.png", width = 6, height = 4)


violin_plot + theme_bw()

violin_plot <- violin_plot + theme_bw()


ggsave("figures/plot_22.png", plot = violin_plot, width = 6, height = 4)


# Faceting plots

ggplot(data = gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp) +
  geom_point() +
  facet_wrap(vars(continent))

ggsave("figures/my_awesome_plot1.jpg", plot = violin_plot, width = 6, height = 4)



