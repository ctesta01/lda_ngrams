# Get the top terms for each topic
top_terms <- tidy(lda_model, matrix = "beta") %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)


# function to plot results 
create_topic_plot <- function(top_terms) {
  top_terms %>% 
    ggplot(aes(y = forcats::fct_reorder(term, beta), x = beta)) + 
    geom_col() + 
    ylab("term")
}

# insert plot by topic
top_terms %<>% nest_by(topic)
top_terms %<>% mutate(plot = list(create_topic_plot(data))) 

# plot in a grid
patchwork::wrap_plots(top_terms$plot) + 
  patchwork::plot_annotation(title = "Latent Dirichlet Allocation Topics and Top 10 Term-Weights", 
                             subtitle = "6-topic model")

# save the figure
ggsave(here("outputs/lda_model_terms_and_weights.png"))
