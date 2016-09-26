library(ggplot2)
library(reshape2)

#Change the path of the file
result_ne <- read.csv('transects_2.csv')

num_tran=length(result_ne$Transect_ID)
col_names=colnames(result_ne)

meds <- c("p2p", "clos", "wavg","biLin", "biQua", "biQub", "TIN","NN")

res_L=c('10','30','100','1000')

resid_L=list()
for (med_ID in (1:length(meds))){
  resid_m = matrix(0, ncol=num_tran,nrow=length(res_L),byrow = TRUE)
  dimnames(resid_m) = list(res_L,result_ne$Transect_ID)
  for (tran_ID in 1:num_tran){
    for (res_ID in 1:4){
      resid_m[res_ID,tran_ID]=result_ne[tran_ID,3]-result_ne[tran_ID,1+med_ID+res_ID*length(meds)]

    }
  }

  #How to plot the matrix (resid_m) as a line chart where h each column is represented by a line, x axis is the row names.
  resid_L<-c(resid_L,list(resid_m))
}

resid_L



list_of_dfs <- lapply(resid_L, melt, varnames = c("transect_len", 'transect_id'))
nrow_each <- lapply(list_of_dfs, nrow)
big_df <- do.call(rbind, list_of_dfs)
big_df$med_ID <- rep(1:length(meds), unlist(nrow_each))

ggplot(big_df, aes(x = factor(transect_len), y = value)) +
  geom_line(aes(group = transect_id, color = factor(transect_id))) +
  facet_wrap(~med_ID)

