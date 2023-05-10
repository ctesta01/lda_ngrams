
# create streamgraph 

# the idea here is to see if there are temporal trends in the data in terms of 
# which topics were showing up... 

# the problem ended up being that basically all of the health & wellness articles
# were from 2012 and 2013, so that didn't give much of a duration over which we 
# could see if topics were waxing or waning. 

topic_labels <- c(
  '1' = 'weight loss',
  '2' = 'constant stress & strain',
  '3' = 'health care & mental health',
  '4' = 'breast cancer, sleep apnea, health conditions, research studies',
  '5' = 'top 10 guides', 
  '6' = 'gps guides')
  
classified_data$topic_label <- topic_labels[classified_data$topic]

classified_data$date %<>% lubridate::ymd()

classified_data %>% 
  mutate(year_month = paste0(lubridate::year(date), "-", lubridate::month(date), "-01")) %>% 
  group_by(year_month, topic, topic_label) %>% 
  count() %>% 
  mutate(year_month = lubridate::ymd(year_month)) %>% 
  streamgraph('topic_label', 'n', 'year_month', interactive = TRUE) %>%
  sg_axis_x(1, "year_month", "%Y") %>%
  sg_fill_brewer("PuOr")


data$date %<>% lubridate::ymd()

# create a monthly streamgraph
data %>% 
  mutate(year_month = paste0(lubridate::year(date), "-", lubridate::month(date), "-01")) %>% 
  group_by(year_month, category) %>% 
  count() %>% 
  mutate(year_month = lubridate::ymd(year_month)) %>% 
  streamgraph('category', 'n', 'year_month', interactive = TRUE) %>%
  sg_axis_x(1, "year", "%Y") 


# create a yearly streamgraph
data %>% 
  mutate(year = lubridate::year(date)) %>% 
  group_by(year, category) %>% 
  count() %>% 
  streamgraph('category', 'n', 'year', interactive = TRUE) %>%
  sg_axis_x(1, "year", "%Y") 
