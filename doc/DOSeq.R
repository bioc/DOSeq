## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(DOSeq)

## ----data, message=FALSE,warning = FALSE,include=TRUE, cache=FALSE------------
samples<-DOSeq::L_Tung_single$NA19098_NA19101_count
samples[1:5,1:5]

## ----main, message=FALSE,warning = FALSE, include=TRUE, cache=FALSE-----------
output<-DOSeq(countData=samples, factor=.8)

## ----output, message=FALSE,warning = FALSE,include=TRUE, cache=FALSE----------
output[1:5,1:5]

