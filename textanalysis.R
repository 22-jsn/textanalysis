# Project: Consumer Complaint Insights


library(tidyverse)      # For data manipulation and visualization
library(tidytext)       # For sentiment analysis
library(wordcloud)      # For generating word clouds
library(lubridate)      # For date processing
library(readr)          # For reading large CSV files
library(textdata)
library(scales)
# For loading sentiment lexicons
#resetting RStudio Environment
rm(list = ls())
#set working directory
setwd("~/r_projects")

df <- read_csv("Consumer_Complaints.csv")

# Data cleaning
# Remove rows with no complaint narrative (we need these for text analysis)
df_clean <- df %>%
  filter(!is.na(`Consumer complaint narrative`))

# Convert date and extract year/month
df_clean <- df_clean %>%
  mutate(`Date received` = mdy(`Date received`),
         year = year(`Date received`),
         month = month(`Date received`, label = TRUE))


# Chart 1: Top 10 most common issues
top_issues <- df %>%
  count(Issue, sort = TRUE) %>%
  slice_max(n, n = 10)

ggplot(top_issues, aes(x = reorder(Issue, n), y = n, fill = Issue)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(title = "Top 10 Most Common Consumer Issues",
       x = "Issue", y = "Number of Complaints") +
  theme_minimal()

# Chart 2: Complaints by State
states <- df %>%
  count(State, sort = TRUE) %>%
  filter(!is.na(State))

ggplot(states[1:10, ], aes(x = reorder(State, n), y = n, fill = State)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(title = "Top 10 States by Complaint Volume",
       x = "State", y = "Complaints") +
  theme_minimal()

# Chart 3: Timely Response Rate by Company
timely <- df %>%
  filter(!is.na(`Company`), !is.na(`Timely response?`)) %>%
  group_by(Company) %>%
  summarise(total = n(), timely = sum(`Timely response?` == "Yes")) %>%
  mutate(rate = timely / total) %>%
  arrange(desc(total)) %>%
  slice_max(total, n = 10)

ggplot(timely, aes(x = reorder(Company, rate), y = rate)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 10 Companies by Timely Response Rate",
       x = "Company", y = "% Timely Response") +
  theme_minimal()

# Sentiment Analysis: Bing & NRC Lexicons
# Unnest tokens from narratives
text_tokens <- df_clean %>%
  unnest_tokens(word, `Consumer complaint narrative`)

# Remove stop words
text_tokens <- text_tokens %>%
  anti_join(get_stopwords())

# Join with sentiment lexicons
bing_sentiment <- text_tokens %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment, sort = TRUE)

nrc_sentiment <- text_tokens %>%
  inner_join(get_sentiments("nrc")) %>%
  count(sentiment, sort = TRUE)

# Plot Bing Sentiment
ggplot(bing_sentiment, aes(x = sentiment, y = n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  scale_y_continuous(labels = label_number(scale = 1/1000, suffix = "K")) +
  labs(title = "Sentiment Score (Bing Lexicon)",
       x = "Sentiment", y = "Word Count (in Thousands)") +
  theme_minimal()

# png("images/wordcloud.png", width = 800, height = 600)
# wordcloud(words = word_counts$word, freq = word_counts$n,
#           min.freq = 1, max.words = 100, random.order = FALSE,
#           colors = brewer.pal(8, "Dark2"))
# dev.off()


#trial charts
df_clean %>%
  count(month = floor_date(`Date received`, "month")) %>%
  ggplot(aes(x = month, y = n)) +
  geom_line(color = "darkred") +
  scale_x_date(date_breaks = "3 months", date_labels = "%b %Y") +
  labs(title = "Complaints Over Time",
       x = "Month", y = "Complaint Volume") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

df %>%
  count(`Submitted via`, sort = TRUE) %>%
  ggplot(aes(x = reorder(`Submitted via`, n), y = n, fill = `Submitted via`)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  scale_y_continuous(labels = label_number(scale = 1/1000, suffix = "K")) +
  labs(title = "How Complaints Are Submitted",
       x = "Channel", y = "Count") +
  theme_minimal()

df %>%
  count(Product, Issue) %>%
  filter(n > 500) %>%
  ggplot(aes(x = Product, y = Issue, fill = n)) +
  geom_tile() +
  scale_fill_viridis_c() +
  labs(title = "Frequency of Issues by Product", x = "Product", y = "Issue") +
  theme_minimal()


# ☁️ Word Cloud of Complaint Narratives
word_counts <- text_tokens %>%
  count(word, sort = TRUE) %>%
  filter(n > 500)

wordcloud(words = word_counts$word, freq = word_counts$n,
          min.freq = 1, max.words = 100, random.order = FALSE,
          colors = brewer.pal(8, "Dark2"))



