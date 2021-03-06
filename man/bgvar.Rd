% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bgvar_main.R
\name{bgvar}
\alias{bgvar}
\title{BGVAR}
\usage{
bgvar(Data, W, plag=1, saves=5000, burns=5000, prior="NG", SV=TRUE, h=0, thin=1, 
      hyperpara=NULL, eigen=FALSE, variable.list=NULL, OE.weights=NULL, Wex.restr=NULL,
      Ex=NULL, trend=FALSE, save.country.store=FALSE, multithread=FALSE, verbose=TRUE)
}
\arguments{
\item{Data}{Either a \itemize{
\item{\code{list object}}{ of length \code{N} that contains the data. Each element of the list refers to a country/entity. The number of columns (i.e., variables) in each country model can be different. The \code{T} rows (i.e., number of time observations), however, need to be the same for each country. Country and variable names are not allowed to contain a dot \code{.} (i.e., a dot) since this is our naming convention.}
\item{\code{matrix object}}{ of dimension \code{T} times \code{K}, with \code{K} denoting the sum of all endogenous variables of the system. The column names should consist of two parts, separated by a \code{.} (i.e., a dot). The first part should denote the country / entity name and the second part the name of the variable. Country and variable names are not allowed to contain a \code{.} (i.e., a dot).}
}}

\item{W}{An N times N weight matrix with 0 elements on the diagonal and row sums that sum up to unity or a list of weight matrices.}

\item{plag}{Number of lags used (the same for domestic, exogenous and weakly exogenous variables.). Default set to \code{plag=1}.}

\item{saves}{Number of draws saved. Default set to \code{saves=5000}.}

\item{burns}{Number of burn-ins. Default set to \code{burns=5000}.}

\item{prior}{Either "SSVS", "MN" or "NG". See Details below.}

\item{SV}{If set to \code{TRUE}, models are fitted with stochastic volatility using the \code{stochvol} package. Due to storage issues, not the whole history of the \code{T} variance covariance matrices are kept, only the median. Consequently, the \code{BGVAR} package shows only one set of impulse responses (with variance covariance matrix based on mean sample point volatilities) instead of \code{T} sets. Specify \code{SV=FALSE} to turn SV off.}

\item{h}{Defines the hold-out sample. Default without hold-out sample, thus set to zero.}

\item{thin}{Is a thinning interval of the MCMC chain. As a rule of thumb, workspaces get large if saves/thin>500. Default set to \code{thin=1}.}

\item{hyperpara}{Is a list object that defines the hyperparameters when the prior is set to either \code{MN}, \code{SSVS} or \code{NG}. \itemize{
\item{\code{a_1}}{ is the prior hyperparameter for the inverted gamma prior (shape) (set a_1 = b_1 to a small value for the standard uninformative prior). Default is set to \code{a_1=0.01}.}
\item{\code{b_1}}{ is the prior hyperparameter for the inverted gamma prior (rate). Default is set to \code{b_1=0.01}.}
\item{\code{prmean}}{ Prior mean on the first lag of the autoregressive coefficients, standard value is \code{prmean=1} for non-stationary data. Prior mean for the remaining autoregressive coefficients automatically set to 0.}
\item{\code{bmu}}{ If \code{SV=TRUE}, this is the prior hyperparameter for the mean of the the mean of the log-volatilities. Default is \code{bmu=0}.}
\item{\code{Bmu}}{ If \code{SV=TRUE}, this is the prior hyperparameter for the variance of the mean of the log-volatilities. Default is \code{Bmu=100}.}
\item{\code{a0}}{ If \code{SV=TRUE}, this is the hyperparameter of the shape1 parameter for the Beta prior on the persistence parameter of the log-volatilities. Default is \code{a0=25}.}
\item{\code{b0}}{ If \code{SV=TRUE}, this is the hyperparameter of the shape2 parameter for the Beta prior on the persistence parameter of the log-volatilities. Default is \code{b0=1.5}.}
\item{\code{Bsigma}}{ If \code{SV=TRUE}, this is the hyperparameter for the Gamma prior on the variance of the log-volatilities. Default is set to \code{Bsigma=1}.}
\item{"MN"}{\itemize{
      \item{\code{shrink1}}{ Starting value of \code{shrink1}. Default set to 0.1.}
      \item{\code{shrink2}}{ Starting value of \code{shrink2}. Default set to 0.2.}
      \item{\code{shrink3}}{ Hyperparameter of \code{shrink3}. Default set to 100.}
      \item{\code{shrink4}}{ Starting value of \code{shrink4}. Default set to 0.1.}
      }}
\item{"SSVS"}{\itemize{
      \item{\code{tau0}}{ is the prior variance associated with the normal prior on the regression coefficients if a variable is NOT included (spike, tau0 should be close to zero).}
      \item{\code{tau1}}{ is the prior variance associated with the normal prior on the regression coefficients if a variable is  included (slab, tau1 should be large).}
      \item{\code{kappa0}}{ is the prior variance associated with the normal prior on the covariances if a covariance equals zero (spike, kappa0 should be close to zero).}
      \item{\code{kappa1}}{  is the prior variance associated with the normal prior on the covariances if a covariance is  unequal to zero (slab, kappa1 should be large).}
      \item{\code{p_i}}{ is the prior inclusion probability for each regression coefficient whether it is included in the model (default set to \code{p_i=0.5}).}
      \item{\code{q_ij}}{ is the prior inclusion probability for each covariance whether it is included in the model (default set to \code{q_ij=0.5}).}
      }}
\item{"NG":}{\itemize{
      \item{\code{e_lambda}}{ Prior hyperparameter for the Gamma prior on the lag-specific shrinkage components, standard value is \code{e_lambda=1.5}.}
      \item{\code{d_lambda}}{ Prior hyperparameter for the Gamma prior on the lag-specific shrinkage components, standard value is \code{d_lambda=1}.}
      \item{\code{a_start}}{ Parameter of the Normal-Gamma prior that governs the heaviness of the tails of the prior distribution. A value of a_start=1 would lead to the Bayesian LASSO. Default value differs per entity and set to \code{a_start=1/log(M)}, where \code{M} is the number of endogenous variables per entity.}
      \item{\code{sample_A}}{ If set to \code{TRUE} \code{a_start} is sampled.}
      }}
 }}

\item{eigen}{Set to TRUE if you want to compute the largest eigenvalue of the companion matrix for each posterior draw. If the modulus of the eigenvalue is significantly larger than unity, the model is unstable. Unstable draws exceeding an eigenvalue of one are then excluded. If \code{eigen} is set to a numeric value, then this corresponds to the maximum eigenvalue. The default is set to 1.05 (which excludes all posterior draws for which the eigenvalue of the companion matrix was larger than 1.05 in modulus).}

\item{variable.list}{In case \code{W} is a list of weight matrices, specify here which set of variables should be weighted by which weight matrix. See the help file on \code{getweights} for details. Default is \code{NULL}.}

\item{OE.weights}{Default value is set to \code{NULL}. Can be used to provide information of how to handle additional country models (other entities). Additional country models can be used to endogenously determine variables that are (weakly) exogenous for the majority of the other country models. As examples, one could think of an additional oil price model (see also Mohaddes and Raissi 2019) or a model for the joint euro area monetary policy (see also Georgiadis 2015; Feldkircher, Gruber and Huber (2020)). The data for these additional country models has to be contained in \code{Data}. The number of additional country models is unlimited. Each list entry of \code{OE.weights} has to be named similar to the name of the additional country model contained in \code{Data}. Each slot of \code{OE.weight} has to contain the following information: \itemize{
\item{\code{weights}}{ a vector of weights with names relating to the countries for which data should be aggregated. Can also relate to a subset of countries contained in the data.}
\item{\code{variables}}{ a vector of variables names that should be included in the additional country model. Variables that are not contained in the data slot of the extra country model are assumed to be weakly exogenous for the additional country model (aggregated with \code{weight}).}
\item{\code{exo}}{ a vector of variable names that should be fed into the other countries as (weakly) exogenous variables.}
}}

\item{Wex.restr}{A character vector that contains variables that should only be specified as weakly exogenous if not contained as endogenous variable in a particular country. An example that has often been used in the literature is to place these restrictions on nominal exchange rates. Default is \code{NULL} in which case all weakly exogenous variables are treated symmetrically. See function \code{getweights} for more details.}

\item{Ex}{For including truly exogenous variables to the model. Either a \itemize{
\item{\code{list object}}{ of maximum length \code{N} that contains the data. Each element of the list refers to a country/entity and has to match the country/entity names in \code{Data}. If no truly exogenous variables are added to the respective country/entity model, omit the entry. The \code{T} rows (i.e., number of time observations), however, need to be the same for each country. Country and variable names are not allowed to contain a dot \code{.} (i.e., a dot) since this is our naming convention.}
\item{\code{matrix object}}{ of dimension \code{T} times number of truly exogenous variables. The column names should consist of two parts, separated by a \code{.} (i.e., a dot). The first part should denote the country / entity name and the second part the name of the variable. Country and variable names are not allowed to contain a \code{.} (i.e., a dot).}
}}

\item{trend}{If set to \code{TRUE} a deterministic trend is added to the country models.}

\item{save.country.store}{If set to \code{TRUE} then function also returns the container of all draws of the individual country models. Significantly raises object size of output and default is thus set to \code{FALSE}.}

\item{multithread}{If set to \code{TRUE} parallel computing using the packages \code{\link{foreach}} and \code{\link{doParallel}}. Number of cores is set to maximum number of cores in the computer. This option is recommended when working with sign restrictions to speed up computations. Default is set to \code{FALSE} and thus no parallelization.}

\item{verbose}{If set to \code{FALSE} it suppresses printing messages to the console.}
}
\value{
Returns a list of class \code{bgvar} with the following elements: \itemize{
\item{\code{args}}{ is a list object that contains the arguments submitted to function \code{bgvar}.}
\item{\code{xglobal}}{ is a matrix object of dimension T times N (T # of observations, K # of variables in the system).}
\item{\code{gW}}{ is the global weight matrix. It is a list, with \code{N} entries, each of which contains the weight matrix of each country.}
\item{\code{country.res}}{ is a matrix that contains the posterior mean of the  country models' residuals. The residuals have been obtained as a running mean and thus always relate to the full set of posterior draws. This implies that in case you have opted for trimming the draws the residuals do not correspond to the posterior draws of the "trimmed" coefficients. This is a storage problem, rather than a statistical problem. Experiments, however, show that residual properties (autocorrelation, cross-sectional correlation) of trimmed and reported residuals are close.}
\item{\code{stacked results}}{\itemize{
      \item{\code{S_large}}{ is a three-dimensional array (K times K times saves) of the (block-diagonal) posterior variance covariance matrix.}
      \item{\code{F_large}}{ is a four-dimensional array (K times K times lags times saves) of the coefficients.}
      \item{\code{Ginv_large}}{ is a three-dimensional array (K times K times saves) of the inverse of the G matrix.}
      \item{\code{A_large}}{ is a three-dimensional array (K times K+1 times saves) of the posterior estimates for the K coefficients plus a global constant.}
      \item{\code{F.eigen}}{ in case \code{eigen="TRUE"}, returns a vector that contains for each posterior draw the modulus of the largest eigenvalue of the companion matrix.}
      \item{\code{trim.info}}{ is a character vector. Contains information regarding the nr. of stable draws out of total (thinned) draws. Experience shows that a maximum eigenvalue of \code{1.05} seems a reasonable choice when working with data in levels to generate stable impulse responses.}
}}
\item{\code{cc.results}}{ each entry of this list contains an list object of length \code{N}. Each entry in the list corresponds to one country model and contains one of the following posterior medians.
\itemize{
      \item{\code{coeffs}}{ contains in each entry the matrix with the posterior median of the estimated coefficients. Columns of the matrix correspond to an equation in the country model (i.e., the dependent variable) and rows to coefficient estimates of the explanatory variables.}
      \item{\code{sig}}{ contains in each entry the variance-covariance matrix for each point in time. If \code{SV=FALSE} all entries along the time dimension are the same.}
      \item{\code{theta}}{ contains in each entry the estimated prior variances for the coefficients. Explains how much shrinkage is induced on each coefficient depending on the prior setup.}
      \item{\code{res}}{ contains in each entry a matrix of dimension (T-p  times K) with the posterior median of the residuals of the cross-country models.}
      \item{\code{shrink}}{ in case \code{prior="MN"} each entry contains the estimated shrinkage parameters.}
      \item{\code{PIP}}{ in case \code{prior="SSVS"} returns a list object. The first slot in the list \code{PIP.cc}, is a list of length \code{N} and contains the posterior inclusion probabilities of the country models. The second slot in the list, named \code{PIP.avg} yields simple averages (over the country models where a particular variable has been included) of the posterior inclusion probabilities.}
      \item{\code{lambda2}}{ in case \code{prior="NG"} each entry contains the estimated global shrinkage parameters. It is a matrix of dimension (p+1 times 3). Columns refer to the endogenous, weakly exogenous and shrinkage parameters for the covariances. Rows correspond to different degree of shrinkage per lag of the variables starting with the contemporaneous lag (only for weakly exogenous variables). In case of the covariances just one global shrinkage parameter is estimated.}
      \item{\code{tau}}{ in case \code{prior="NG"} each entry contains the estimated parameter that governs the heaviness of the tails of the marginal prior distribution of the coefficients associated to endogenous variables. Structure is the same as \code{lambda2}.}
}}}
}
\description{
Estimates a Bayesian GVAR with either the Stochastic Search Variable Selection (SSVS), the Minnesota prior (MN), or the Normal-Gamma prior. All specifications can be estimated with stochastic volatility.
}
\details{
We provide three priors, the Minnesota labeled \code{MN}, the SSVS and the Normal-Gamma prior. The first one has been implemented for global VARs in Feldkircher and Huber (2016) and the second one in Crespo Cuaresma et al. (2016), while the last one has been introduced to VAR modeling in Huber and Feldkircher (2019).
 Please consult these references for more details on the specification. In the following we will briefly explain the difference between the three priors. The Minnesota prior pushes the variables in the country-specific VAR towards their unconditional stationary mean, or toward a situation where there is at least one unit root present. The SSVS prior is a form of a 'spike' and 'slab' prior. Variable selection is based on the probability of assigning the corresponding regression coefficient to the 'slab' component. If a regression coefficient is non informative, the 'spike' component pushes the associated posterior estimate more strongly towards zero. Otherwise, the slab component resembles a non-informative prior that has little impact on the posterior. Following George et. al. (2008) we set the prior variances for the normal distribution in a semi-automatic fashion. This implies scaling the mixture normal with the OLS standard errors of the coefficients for the full model. The NG prior is a form of global-local shrinkage prior. Hence, the local component shrinks each coefficient towards zero if there is no information for the associated dependent variable. Otherwise, the prior exerts a fat-tail structure such that deviations from zero are possible. The global component is present for each lag, thus capturing the idea that higher lags should be shrunk more aggressively towards zero.
}
\examples{
\dontshow{
library(BGVAR)
data(eerData)
cN<-c("EA","US","UK")
eerData<-eerData[cN]
W.trade0012<-apply(W.trade0012[cN,cN],2,function(x)x/rowSums(W.trade0012[cN,cN]))
hyperpara <- list(tau0=0.1,tau1=3,kappa0=0.1,kappa1=7,a_1=0.01,b_1=0.01,p_i=0.5,q_ij=0.5)
model.ssvs <- bgvar(Data=eerData,W=W.trade0012,plag=1,saves=100,burns=100,
                    prior="SSVS",SV=FALSE,hyperpara=hyperpara,thin=1)

W.list<-lapply(W.list,function(l){l<-apply(l[cN,cN],2,function(x)x/rowSums(l[cN,cN]))})
variable.list<-list();variable.list$real<-c("y","Dp","tb");variable.list$fin<-c("stir","ltir","rer")
model.mn <- bgvar(Data=eerData, W=W.list[c("tradeW.0012","finW0711")], plag=1, saves=100, 
                  burns=100,prior="MN",SV=TRUE,thin=2,variable.list=variable.list)
print(model.mn)
}
\donttest{
library(BGVAR)
# replicate Feldkircher and Huber (2016) using trade based weights
data(eerData)
hyperpara <- list(tau0=0.1,tau1=3,kappa0=0.1,kappa1=7,a_1=0.01,b_1=0.01,p_i=0.5,q_ij=0.5)
model.ssvs <- bgvar(Data=eerData,W=W.trade0012,plag=1,saves=100,burns=100,
                    prior="SSVS",SV=FALSE,hyperpara=hyperpara,thin=1)
print(model.ssvs)

data("eerData")
variable.list<-list();variable.list$real<-c("y","Dp","tb");variable.list$fin<-c("stir","ltir","rer")
model.mn <- bgvar(Data=eerData, W=W.list[c("tradeW.0012","finW0711")], plag=1, saves=200, 
                  burns=100,prior="MN",SV=TRUE,thin=2,variable.list=variable.list)
print(model.mn)

data(monthlyData)
EA.weights$variables <- c("EAstir","total.assets","M3","ciss","y","p")
OC.weights$variables <- c("poil","qoil","y")
OE.weights <- list(EB=EA.weights,OC=OC.weights)
hyperpara<-list(c_tau = 0.01, d_tau = 0.01,e_lambda=1.5,d_lambda=1, 
                prmean=0,a_i=0.01,b_i=0.01,a_start=.6,sample_A=FALSE)
model.ssvs <- bgvar(Data=monthlyData,W=W,plag=2,saves=100,burns=100,prior="SSVS",
                    hyperpara=hyperpara,eigen=TRUE,SV=TRUE,OE.weights=OE.weights)
print(model.ssvs)
}
}
\references{
Crespo Cuaresma, J., Feldkircher, M. and F. Huber (2016) Forecasting with Global Vector Autoregressive Models: A Bayesian Approach. \emph{Journal of Applied Econometrics}, Vol. 31(7), pp. 1371-1391.

Doan, T. R., Litterman, B. R. and C. A. Sims (1984) Forecasting and Conditional Projection Using Realistic Prior Distributions. \emph{Econometric Reviews}, Vol. 3, pp. 1-100.

Dovern, J., Feldkircher, M. and F. Huber (2016) Does joint modelling of the world economy pay off? Evaluating multivariate forecasts from a Bayesian GVAR. \emph{Journal of Economic Dynamics and Control}, Vol. 70, pp. 86-100.

Feldkircher, M. and F. Huber (2016) The International Transmission of US Shocks - Evidence from Bayesian Global Vector Autoregressions. \emph{European Economic Review}, Vol. 81, pp. 167-188.

Feldkircher, M. Gruber, T. and F. Huber (2020) International effects of a compression of euro area yield curves. \emph{Journal of Banking & Finance}, Vol. 113, pp. 11-14.

George, E.I., Sun, D. and S. Ni (2008) Bayesian stochastic search for var model restrictions. \emph{Journal of Econometrics}, Vol. 142, pp. 553-580.

Georgiadis, G. (2015) Examining asymmetries in the transmission of monetary policy in the euro area: Evidence from a mixed cross-section global VAR model. \emph{European Economic Review}, Vol. 75, pp. 195-215.

Huber, F. and M. Feldkircher (2016) Adaptive Shrinkage in Bayesian Vector Autoregressive Models. \emph{Journal of Business and Economic Statistics}, Vol. 37(1), pp. 27-39.

Mohaddes, K. and M. Raissi (2018). Compilation, Revision and Updating of the Global VAR (GVAR) Database, 1979Q2-2016Q4. University of Cambridge: Faculty of Economics (mimeo).

Mohaddes, K. and M. Raissi (2019) The US oil supply revolution and the global economy. \emph{Empirical Economics}, Vol. 57, pp. 515-546.

Pesaran, M.H., Schuermann T. and S.M. Weiner (2004) Modeling Regional Interdependencies Using a Global Error-Correcting Macroeconometric Model. \emph{Journal of Business and Economic Statistics}, Vol. 22, pp. 129-162.

Sims, C. A. (1992) Bayesian Inference for Multivariate Time Series with Trend. \emph{Mimeo}, presented at the American statistical Association meeting.

Sims, C.A. and T. Zha (1998) Bayesian Methods for Dynamic Multivariate Models. \emph{International Economic Review}, Vol. 39, pp. 949-968.
}
\author{
Maximilian Boeck, Martin Feldkircher, Florian Huber
}
