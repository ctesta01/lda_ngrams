# filter for health and wellness news
health_and_wellness <- data %>% filter(category %in% c("WELLNESS", "HEALTHY LIVING"))

health_and_wellness %<>% mutate(headline_desc = stringr::str_c(headline, short_description, sep = ". "))

# Pre-process the text
corpus <- VCorpus(VectorSource(health_and_wellness$headline_desc))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english"))

# Create a Document-Term Matrix
dtm <- DocumentTermMatrix(corpus)

# save to processed_data folder
saveRDS(dtm, here("processed_data/dtm.rds"))
