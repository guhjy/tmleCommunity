% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GenericModelClasses.R
\docType{class}
\name{GenericModel}
\alias{GenericModel}
\title{Generic R6 class for modeling (fitting and predicting) \eqn{P(A|W,E)} where \eqn{A} can be multivariate \eqn{(A[1], ..., A[M])}}
\format{An \code{\link{R6Class}} generator object}
\usage{
GenericModel
}
\description{
\code{GenericModel} defines and models the conditional density \eqn{P(A=a|W=w,E=e)}, where \eqn{a} are generated under \eqn{g_star}
 or \eqn{g_0}. By calling \code{self$new(reg)}, it utilizes estimation options defined in \code{\link{RegressionClass}} class, and 
 automatically factorizes the multivariate conditional probability model \eqn{P(A|W,E)} into \eqn{M} univariate conditional probability 
 models (can be binary, categorical or continuous) and finally an entire tree of binary regression models (see details in
 \code{\link{tmleCommunity}}), where a new instance of \code{\link{BinaryOutModel}} class will be initialized for each binary 
 regression (If one outcome variable \eqn{A[m]} is already binary, then immediately call a new instance of \code{BinaryOutModel}). 
 By calling \code{self$fit(data)} and \code{self$predict(newdata)},  where \code{data} and \code{newdata}
 are \code{\link{DatKeepClass}} class objects, it fits \eqn{P(A|W,E)} and predicts \eqn{P(A=1|W=w,E=e)}, where values of \eqn{(w,e)}     
 are from \code{newdata}. Moreover, it predicts likelihood function \eqn{P(A=a| W=w,E=e)} through \code{self$predictAeqa(newdata)},   
 where \eqn{(a,w,e)} are from \code{newdata} (also a \code{DatKeepClass} class).
}
\details{
\itemize{
\item{\code{n_regs}} - Total number of regression models.
\item{\code{parfit_allowed}} - Logical. If TRUE, allow parallel computing to fit multivariate outvar.
}
}
\section{Methods}{

\describe{
  \item{\code{new(reg, ...)}}{Use \code{reg} (a \code{\link{RegressionClass}} object) to instantiate an new object of \code{GenericModel}}
  \item{\code{length}}{Get the number of regression models (i.e., the number of exposure viarables)}
  \item{\code{getPsAsW.models}}{Get all model objects (one model object per outcome var \code{A[m]})}
  \item{\code{getcumprodAeqa}}{Get joint prob as a vector of the cumulative prod over j for \code{P(A[m]=a[m]|W,E)}}
  \item{\code{fit(data, savespace = TRUE)}}{...}
  \item{\code{copy.fit(Generic.Model)}}{...}
  \item{\code{predict(newdata, savespace = TRUE)}}{...}
  \item{\code{predictAeqa(newdata, savespace = TRUE, wipeProb = TRUE, ...)}}{...}
}
}

\section{Active Bindings}{

\describe{
  \item{\code{wipe.alldat(wipeProb = TRUE)}}{...}
}
}

\examples{
\dontrun{
#***************************************************************************************
# Example 1: Defining and modeling P(A | W) with continuous A
data(indSample.iid.cA.cY_list)
indSample.iid.cA.cY <- indSample.iid.cA.cY_list$indSample.iid.cA.cY
nodes <- list(Ynode = "Y", Anodes = "A", WEnodes = c("W1", "W2", "W3", "W4"))
tmleCom_Options(gestimator = "speedglm__glm", maxNperBin = nrow(indSample.iid.cA.cY),
                bin.method = "equal.mass", nbins = 10)
options(tmleCommunity.verbose = FALSE)  # Don't print status messages
#***************************************************************************************

#***************************************************************************************
# 1.1 Defining new R6 objects of DatKeepClass and RegressionClass and GenericModel
#***************************************************************************************
OData.g0 <- DatKeepClass$new(Odata = indSample.iid.cA.cY, nodes = nodes)
h.g0.sVars <- tmleCommunity:::define_regform(NULL, Anodes.lst = nodes$Anodes, 
                                             Wnodes.lst = nodes$WEnodes)
subsets_expr <- lapply(h.g0.sVars$outvars, function(var) {var}) 
regclass.g0 <- RegressionClass$new(outvar = h.g0.sVars$outvars,
                                   predvars = h.g0.sVars$predvars,
                                   subset_vars = subsets_expr,
                                   outvar.class = OData.g0$type.sVar[h.g0.sVars$outvars])
genericmodels.g0 <- GenericModel$new(reg = regclass.g0, DatKeepClass.g0 = OData.g0)

#***************************************************************************************
# 1.2 Details regarding the GenericModel of the first exposure variable  
#***************************************************************************************
genericmodels.g0.A1 <- genericmodels.g0$getPsAsW.models()$`P(A|W).1` 
genericmodels.g0$getPsAsW.models()$`P(A|W).2`  # NULL as only one A in the input data
# Defining the number and positions of the bins via arguments in tmleCom_Options()
genericmodels.g0.A1$intrvls  
# Creating a matrix of dummy bin indicators for continuous A
OData.g0$binirize.sVar(name.sVar = genericmodels.g0.A1$outvar, 
                       intervals = genericmodels.g0.A1$intrvls, 
                       nbins = genericmodels.g0.A1$reg$nbins, 
                       bin.nms = genericmodels.g0.A1$bin_nms)  
bin.ind.mat <- OData.g0$dat.bin.sVar
colSums(bin.ind.mat, na.rm = TRUE)   # Each bin has 1000 obs as "equal.mass" with 10 bins

#***************************************************************************************
# 1.3 Fitting regression models for the first exposure variable  
#***************************************************************************************
genericmodels.g0.A1$fit(data = OData.g0)
genericmodels.g0.A1.B2 <- genericmodels.g0.A1$getPsAsW.models()$`P(A|W).2`  # 2nd bin
genericmodels.g0.A1.B2$getfit$coef
}
}
\seealso{
\code{\link{DatKeepClass}}, \code{\link{RegressionClass}}, \code{\link{ContinModel}}, 
 \code{\link{CategorModel}}, \code{\link{BinaryOutModel}}
}
\keyword{R6}
\keyword{class}
