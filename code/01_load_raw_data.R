
# load raw data 

# advice found for reading json where every new line is a new object: 
# https://github.com/jeroen/jsonlite/issues/59 
# 
# > The proper way to do this is using the stream_in function in jsonite:
# 
# > Datasets where each line is a record are usually nosql database dumps. Because
# they might be too large to parse all at once, they are meant to be imported
# line-by-line, which is exactly what jsonlite does.
# 
data <- stream_in(con = file(here("data/News_Category_Dataset_v3.json"), open = 'r'))
