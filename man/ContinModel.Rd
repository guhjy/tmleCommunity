% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GenericModelClasses.R
\docType{class}
\name{ContinModel}
\alias{ContinModel}
\title{R6 class for modeling (fitting and predicting) joint probability for a univariate continuous outcome \code{A[m]}}
\format{An \code{\link{R6Class}} generator object}
\usage{
ContinModel
}
\description{
\code{ContinModel} inherits from \code{\link{GenericModel}} class, defining and modeling a joint conditional density 
 \eqn{P(A[m]|W,E,...)} where \code{A[m]} is univariate and continuous. By calling \code{self$new()}, \code{A[m]} will be 
 discretized into \code{nbins} bins via one of the 3 bin cutoff approaches (See Details for \code{\link{tmleCommunity}}). 
 By calling \code{self$fit()}, it fits hazard regressoin \code{Bin_A[m][k] ~ W + E} on \code{data} (a \code{\link{DatKeepClass}} 
 class), which is the hazard probaility of the the observation of \code{A[m]} belongs to bin \code{Bin_A[m][k]}, given covariates 
 \eqn{(W, E)} and that observation doesn't belong to any precedent bins \code{Bin_A[m][1]}, \code{Bin_A[m][2]}, ..., 
 \code{Bin_A[m][k-1]}.
}
\details{
\itemize{
 \item{\code{reg}} - .
 \item{\code{outvar}} - .
 \item{\code{nbins}} - 
 \item{\code{bin_nms}} - Character vector of column names of bin indicators.
 \item{\code{intrvls}} - 
 \item{\code{intrvls.width}} - 
 \item{\code{bin_weights}} - .
}
}
\section{Methods}{

\describe{
  \item{\code{new(reg, DataStorageClass.g0, DataStorageClass.gstar, ...)}}{Instantiate an new instance of \code{ContinModel} for a univariate continuous outcome \code{A[m]}}
  \item{\code{fit(data, savespace = TRUE)}}{...}
  \item{\code{predict(newdata, savespace = TRUE)}}{...}
  \item{\code{predictAeqa(newdata, savespace = TRUE, wipeProb = TRUE)}}{...}
}
}

\section{Active Bindings}{

\describe{
  \item{\code{cats}}{...}
}
}

\seealso{
\code{\link{DatKeepClass}}, \code{\link{RegressionClass}}, \code{\link{GenericModel}}, \code{\link{BinaryOutModel}}
}
\keyword{R6}
\keyword{class}
