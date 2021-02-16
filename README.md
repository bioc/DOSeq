
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DOSeq

Modeling expression drop-out for analysis of scRNA-Seq data

## Introduction

DOSeq - Modeling expression drop-out for analysis of scRNA-Seq data.
DOSeq takes read count matrix and factor for drop-out ratio as input and
return the read count matrix with dropout. Here input parameter factor
indicates drop-out ratio in expression matrix.

## Installation

The developer’s version of the R package can be installed with the
following R commands:

``` r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# The following initializes usage of Bioc devel
BiocManager::install(version='devel')

BiocManager::install("DOSeq")
```

The github’s version of the R package can be installed with the
following R commands:

``` r
library(devtools)
install_github('krishan57gupta/DOSeq')
```

## Vignette tutorial

This vignette uses the Tung dataset, which is already inbuilt in the
package, to demonstrate a standard pipeline.

## Example

Libraries need to be loaded before running.

``` r
library(DOSeq)
```

### Loading tung dataset

``` r
samples<-DOSeq::L_Tung_single$NA19098_NA19101_count
samples[1:5,1:5]
#>                 NA19098.r1.A01 NA19098.r1.A02 NA19098.r1.A03 NA19098.r1.A04
#> ENSG00000237683              0              0              0              1
#> ENSG00000187634              0              0              0              0
#> ENSG00000188976              3              6              1              3
#> ENSG00000187961              0              0              0              0
#> ENSG00000187583              0              0              0              0
#>                 NA19098.r1.A05
#> ENSG00000237683              0
#> ENSG00000187634              0
#> ENSG00000188976              4
#> ENSG00000187961              0
#> ENSG00000187583              0
```

### DOSeq analysis.

Input: gene expression matrix with genes in rows and cells in columns.

``` r
output<-DOSeq(countData=samples, factor=.8)
#> 
#> Call:
#> stats::lm(formula = log_odd ~ M)
#> 
#> Coefficients:
#> (Intercept)            M  
#>       3.014       -2.672  
#> 
#> 
#> Call:
#> stats::lm(formula = log_odd ~ M)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -9.1203 -0.6927 -0.1402  0.6525 10.8011 
#> 
#> Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  3.014413   0.013339   226.0   <2e-16 ***
#> M           -2.671974   0.007074  -377.7   <2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 1.248 on 16598 degrees of freedom
#> Multiple R-squared:  0.8958, Adjusted R-squared:  0.8958 
#> F-statistic: 1.427e+05 on 1 and 16598 DF,  p-value: < 2.2e-16
#> 
#> [1] "Positive change fraction for factor 1 =  1"
```

### Showing results are in the form of gene expression with drop out

##### Simulated gene expression matrix

``` r
output[1:5,1:5]
#>                 NA19098.r1.A01 NA19098.r1.A02 NA19098.r1.A03 NA19098.r1.A04
#> ENSG00000237683       0.000000              0      0.0000000      0.9099606
#> ENSG00000187634       0.000000              0      0.0000000      0.0000000
#> ENSG00000188976       2.685938              0      0.8953126      2.6859379
#> ENSG00000187961       0.000000              0      0.0000000      0.0000000
#> ENSG00000187583       0.000000              0      0.0000000      0.0000000
#>                 NA19098.r1.A05
#> ENSG00000237683       0.000000
#> ENSG00000187634       0.000000
#> ENSG00000188976       3.581251
#> ENSG00000187961       0.000000
#> ENSG00000187583       0.000000
```
