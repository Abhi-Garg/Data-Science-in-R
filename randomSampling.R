randomSampling <- function(d, sampleSize)
{
  #Setting seed value.
  set.seed(1234)
  #### Determine the indices each subset will have
  indices.samp = sort(sample(seq_len(nrow(d)), sampleSize))
  d[indices.samp,]
}