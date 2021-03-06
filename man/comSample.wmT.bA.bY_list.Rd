% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tmleCommunity-package.R
\docType{data}
\name{comSample.wmT.bA.bY_list}
\alias{comSample.wmT.bA.bY_list}
\title{An Example of a Hierarchical Data Containing a Cluster-Based Binary Exposure with a Individual-Level Binary Outcome.}
\format{A data frame with 1000 independent communities, each containing around 50 individuals (in total 50,457 observations 
 (rows)), and 8 variables (columns):
\describe{
  \item{id}{integer (unique) community identifier from 1 to 1000, identical within the same community}
  \item{E1}{continuous uniform community-level baseline covariate with \code{min=0} and \code{max=1} (independent and identical
    across all individuals in the same community)}
  \item{E2}{discrete uniform community-level baseline covariate with 5 elements (0, 0.2, 0.4, 0.8, 1) (independent and identical
    across all individuals in the same community)}
  \item{W1}{binary individual-level baseline covariate that depends on the values of community-level baseline covaries (\code{E1,E2})}
  \item{W2}{continuous individual-level baseline covariate, together with \code{W3}, are drawn from a bivariate normal distribution
    with correlation 0.6, depending on the values of community's baseline covaries (\code{E1, E2})}
  \item{W3}{continuous normal individual-level baseline covariate, correlated with \code{W2}, see details in above}
  \item{A}{binary exposure that depends on community's baseline covariate values in \code{(E1, E2)}, and the mean of all individuals'
    baseline covariates \code{W1} within the same community}
  \item{Y}{binary outcome that depends on community's baseline covariate and exposure values in (\code{E1}, \code{E2}, \code{A}), 
    and all individuals' baseline covariate values in \code{(W2, W3)}}
}}
\source{
\url{https://github.com/chizhangucb/tmleCommunity/blob/master/tests/dataGeneration/get.cluster.dat.Abin.R}
}
\usage{
data(comSample.wmT.bA.bY_list)
}
\description{
Simulated hierarchical dataset containing 1000 independent communities, each (community \eqn{j}) containing \eqn{n_j} (non-fixed) 
 number of individuals where \eqn{n_j} is drawn from a normal with mean 50 and standard deviation 10 and round to the nearest 
 integer. Each row (observation) includes 2 measured community-level baseline covariates (\code{E1, E2}), 3 dependent   
 individual-level baseline covariates (\code{W1, W2, W3}), 1 dependent bianry exposure (\code{A}) and 1 dependent binary outcoem 
 (\code{Y}), along with one unique community identifier (\code{id}). The community-level baseline covariates (\code{E1, E2}) 
 were sampled as i.i.d across all communities, while the individual-level baseline covariates (\code{W1, W2, W3}) for each 
 individual \eqn{i} within communty \eqn{j} was generated conditionally on the values of \eqn{j}'s community-level baseline 
 covariates (\code{E1[j], E2[j]}). Then the community-level exposure (\code{A}) for each community \eqn{j} was sampled 
 conditionally on the value of \eqn{j}'s community-level baseline covariates (\code{E1[j], E2[j]}), together with all 
 invididuals' baseline covariates (\code{W1[i], W2[i], W3[i]}) within community \eqn{j} where \eqn{i=1,..,n_j}. Similary, 
 the individual-level binary outcome \code{Y} for each individual \eqn{i} within communty \eqn{j} was sampled conditionally 
 covariates and exposure (\code{E1[j], E2[j], A[j]}), as well as the value of individual \eqn{i}'s baseline covariates 
 on the value of community \eqn{j}'s baseline (\code{W1[i]}, \code{W2[i]}, \code{W3[i]}). The following section provides more 
 details regarding individual variables in simulated data.
}
\examples{
data(comSample.wmT.bA.bY_list)
comSample.wmT.bA.bY <- comSample.wmT.bA.bY_list$comSample.wmT.bA.bY
head(comSample.wmT.bA.bY)
comSample.wmT.bA.bY_list$psi0.Y  # 0.103716, True ATE
# summarize the number of individuals within each community
head(table(comSample.wmT.bA.bY$id))  
}
\keyword{datasets}
