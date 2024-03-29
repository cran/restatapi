% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_eurostat_dsd.R
\name{get_eurostat_dsd}
\alias{get_eurostat_dsd}
\title{Download the Data Structure Definition of a dataset}
\usage{
get_eurostat_dsd(
  id,
  lang = "en",
  cache = TRUE,
  update_cache = FALSE,
  cache_dir = NULL,
  compress_file = TRUE,
  verbose = FALSE,
  ...
)
}
\arguments{
\item{id}{a character string with the id of the dataset. It is a value from the \code{codename} column of the \code{\link{get_eurostat_toc}} function.}

\item{lang}{a character string either \code{en}, \code{de} or \code{fr} to define the language version for the name column of the DSD. It is used only in the new API. The default is \code{en} - English.}

\item{cache}{a boolean whether to load/save the DSD from/in the cache or not. The default value is \code{TRUE}, so that the DSD is checked first in the cache and if does not exist then downloaded from Eurostat and cached.}

\item{update_cache}{a boolean to update cache or not. The default value is \code{FALSE}, so the cache is not updated. Can be set also with \code{options(restatapi_update=TRUE)}}

\item{cache_dir}{a path to a cache directory. The default is \code{NULL}, in this case the DSD is cached in the memory (in the '.restatapi_env'). Otherwise if the \code{cache_dir} directory does not exist it creates the 'restatapi' directory in the temporary directory from \code{tempdir()} to save the RDS-file. Directory can also be set with \code{option(restatapi_cache_dir=...)}.}

\item{compress_file}{a logical whether to compress the RDS-file in caching. Default is \code{TRUE}.}

\item{verbose}{A boolean with default \code{FALSE}, so detailed messages (for debugging) will not printed.
Can be set also with \code{options(restatapi_verbose=TRUE)}}

\item{...}{parameter to pass on the \code{load_cfg} function}
}
\value{
If the DSD does not exist it returns \code{NULL} otherwise the result is a table with the 3 columns:
   \tabular{ll}{
     \code{concept} \tab The name of the concepts in the order of the data structure \cr
     \code{code} \tab The possible list of codes under the concept \cr
     \code{name} \tab The name/description of the code 
   }
}
\description{
Download Data Structure Definition (DSD) of a Eurostat dataset if it is not cached previously.
}
\details{
The DSD is downloaded from Eurostat's website, through the REST API in XML (SDMX-ML) format.
}
\examples{
\dontshow{
if (parallel::detectCores()<=2){
   options(restatapi_cores=1)
}else{
   options(restatapi_cores=2)
}
}
\donttest{
if (!(grepl("amzn|-aws|-azure ",Sys.info()['release']))) options(timeout=2)
head(get_eurostat_dsd("med_rd6",lang="de",cache=FALSE,verbose=TRUE))
options(timeout=60)
}
}
\references{
For more information see the detailed documentation of the \href{https://ec.europa.eu/eurostat/data/web-services}{API}.
}
\seealso{
\code{\link{get_eurostat_data}}, \code{\link{search_eurostat_toc}}.
}
