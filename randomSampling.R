# Author: Abhinav Garg
randomSampling <- function(d, sampleSize)
{
  #Setting seed value.
  set.seed(1234)
  #### Determine the indices each subset will have
  indices.samp = sort(sample(seq_len(nrow(d)), sampleSize))
  ## Return the sample to calling object.
  d[indices.samp,]
}
