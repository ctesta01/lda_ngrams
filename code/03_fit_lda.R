
# pre-processing step:  remove empty rows 
# 
# just trying to use rowSums or apply(dta, 1, FUN=sum) ran into a memory limit error.
# i tried to increase R_MAX_VSIZE in my ~/.Renviron, but that didn't work.
# 
# googling "rowsums of dtm" led me to this stackoverflow post: 
# https://stackoverflow.com/questions/21921422/row-sum-for-large-term-document-matrix-simple-triplet-matrix-tm-package
# 
# > Row sum for large term-document matrix / simple_triplet_matrix ?? {tm package} 
# 
# which suggested to use row_sums from the slam package
# 
raw.sum <- slam::row_sums(dtm)
dtm <- dtm[raw.sum!=0,]

# Fit LDA model (change the number of topics and other settings if needed)
num_topics <- 6
lda_model <- LDA(dtm, k = num_topics, control = list(seed = 123))
