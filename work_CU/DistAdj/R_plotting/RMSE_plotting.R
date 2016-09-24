library(ggplot2)
library(reshape2)
# sa=vector(mode="list", length=6)
# names(sa) <- c("Colorado", "Louisiana", "North Carolina","Nebraska", "Texas", "Washington")
# sa[[1]]='C:/Users/yiqi7710/work_CU/data/Modified_2/Colorado/'
# sa[[2]]='C:/Users/yiqi7710/work_CU/data/Modified_2/Louisiana/'
# sa[[3]]='C:/Users/yiqi7710/work_CU/data/Modified_2/NC/'
# sa[[4]]='C:/Users/yiqi7710/work_CU/data/Modified_2/Nebraska/'
# sa[[5]]='C:/Users/yiqi7710/work_CU/data/Modified_2/Washington/'
# sa[[6]]='C:/Users/yiqi7710/work_CU/data/Modified_2/Texas/'
# fn_ne=paste0(sa$Nebraska,'transects_2.csv')

#Change the path of the file
result_ne=read.csv('C:/transects_2.csv')

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
  #How to plot the matrix (resid_m) as a line chart in which each column is represented by a line, x axis is the row names.
  
  resid_L<-c(resid_L,list(resid_m))
  
}

resid_L
