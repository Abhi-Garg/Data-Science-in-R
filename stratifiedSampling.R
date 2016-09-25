stratfiedSampling <- function(d, train.size, valid.size){
  if(train.size<1 & valid.size<1)
  
  #### Calculate the sample sizes
  samp.train = floor(train.size * nrow(d))
  samp.valid = floor(valid.size * nrow(d))
  #Setting seed value.
  set.seed(1234)
  #### Determine the indices each subset will have
  indices.train = sort(sample(seq_len(nrow(d)), size=samp.train))
  indices.valid = setdiff(seq_len(nrow(d)), indices.train)
  
  #### Use the indices to select the data from the dataframe
  return(list(d.train = d[indices.train,],
  d.valid = d[indices.valid,]))
}