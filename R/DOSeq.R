##' @title Modeling expression drop-out for analysis of scRNA-Seq data
##' @description DOSeq - Modeling expression drop-out for analysis of scRNA-Seq
##' data. DOSeq takes read count matrix and factor for drop-out ratio as input
##' and return the read count matrix with dropout. Here input parameter factor
##' indicates drop-out ratio in expression matrix.
##' @param countData read count matrix, with row names as genes name/ID and
##' column names as sample id/name
##' @param factor indicates dropout ratio
##' @return Simulated read count with drop out
##' @examples
##' countData<-DOSeq::L_Tung_single$NA19098_NA19101_count
##' head(countData)
##' output<-DOSeq(countData=countData, factor=.8)
##' output
##' @export DOSeq
DOSeq<-function(countData,factor=.8)
{
    M=log2(rowMeans(countData)+1)
    p= apply(countData, 1, function(x) (sum(x==0)/length(x)))
    p[p == 0] = 0.000001
    p[p == 1] = 0.999999
    log_odd=log(p/(1-p))
    summary(log_odd)
    model=stats::lm(formula = log_odd~M)
    print(model)
    print(summary(model))
    temp=as.numeric(model$coefficients[2]) * M
    current_estimated_log_odd =  temp + as.numeric(model$coefficients[1])
    temp1=as.numeric(model$coefficients[2]) * factor*M
    update_1 =  temp1 + as.numeric(model$coefficients[1])
    sum_factor1= model$coefficients[2]*(factor*M - M)
    new_p1 = 1/(1+exp(-(log_odd+sum_factor1)))
    diff1 = new_p1 - p
    temp2=length(which(diff1>=0))/length(p)
    print(paste("Positive change fraction for factor 1 = ",temp2))
    new_0_1 = ceiling( diff1 * ncol(countData))
    for(i in seq_len(dim(countData)[1]))
    {
        if(new_0_1[i]>0)
        {
            countData[i,sample(which(countData[i,] != 0),new_0_1[i])]=0
        }
    }
    new_mean=rowMeans(countData)
    new_mean[new_mean==0]=1
    countData=((2^(M*factor)-1)/(new_mean))*countData
    # if(abs(sum(2^(M*factor)-1)-sum(rowMeans(countData)))<10)
    #  print("Excelent")
    return(countData)
}
