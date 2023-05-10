
# remove stopwords before analysis
stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
classified_data %<>% mutate(headline_desc = stringr::str_replace_all(headline_desc, stopwords_regex, ''))

# extract trigrams
ngrams <- unnest_tokens(tbl = classified_data, ngram, headline_desc,
              token = 'ngrams', n = 2) %>% 
  tidyr::separate(ngram, c("word1", "word2"), sep = " ") %>%
  filter(!word1 %in% stop_words$word,
         !word2 %in% stop_words$word) %>% 
         # !word3 %in% stop_words$word, 
         # !word4 %in% stop_words$word,
         # !word5 %in% stop_words$word) %>% 
  filter(! is.na(word1) & ! is.na(word2)) %>% 
  tidyr::unite(ngram, word1, word2, sep = " ")

ngram_counts <- ngrams %>% group_by(topic, ngram) %>% 
  count()

ngram_counts %<>% ungroup() %>% nest_by(topic)

ngram_counts %<>% rowwise() %>% mutate(
  plot = list(
    data %>% top_n(10) %>% 
    mutate(prop = n / sum(n)) %>% 
    ggplot(aes(y = forcats::fct_reorder(ngram, prop), x = prop)) + 
    geom_col() + 
    ylab("n-gram") + 
    xlab("proportion of headlines") + 
    scale_x_continuous(labels = scales::percent_format())))

patchwork::wrap_plots(ngram_counts$plot) + 
  patchwork::plot_annotation(title = "Most Common Bi-grams by LDA Topic")

# save bigrams
ggsave(here("outputs/bigrams.png"))
