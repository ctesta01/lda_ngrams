# Get the topic probabilities for each document
topic_probabilities <- tidy(lda_model, matrix = "gamma")

# Find the most probable topic for each document
most_probable_topic <- topic_probabilities %>%
  group_by(document) %>%
  top_n(1, gamma) %>%
  ungroup() %>%
  select(document, topic, gamma)

# Add the most probable topic to the original data
health_and_wellness$document_id <- seq_len(nrow(health_and_wellness))
classified_data <- merge(health_and_wellness, most_probable_topic, by.x = "document_id", by.y = "document")

# Print classified data with most probable topic
# print(classified_data)