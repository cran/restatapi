#' @title Search for pattern in the titles, units and short description of the TOC
#' @description Lists names of dataset from Eurostat with the particular
#' pattern in the title, units or short description.
#' @details Downloads the list of all tables and datasets available in the 
#' Eurostat database and returns all the details from the table of contents of the tables/datasets that contains particular
#' pattern in the dataset title, unit or short description. E.g. all tables/datasets  mentioning
#' 'energy'.
#' @param pattern Character string to search for in the table of contents of Eurostat tables/datasets
#' @param lang a character string either \code{en}, \code{de} or \code{fr} to define the language version for the table of contents. The default is \code{en} - English.
#' @param verbose A boolean with default \code{FALSE}, so detailed messages (for debugging) will not printed.
#'         Can be set also with \code{options(restatapi_verbose=TRUE)}
#' @param ... other additional parameters to pass to the \code{grepl} function like \code{ignore.case=TRUE} if the pattern should be searched case sensitive or not. 
#'            The default value for \code{ignore.case} is \code{FALSE}.
#' @return A table with the following columns:
#'    \tabular{ll}{
#'      \code{title} \tab The name of dataset/table in the language provided by the \code{lang} parameter \cr
#'      \code{code} \tab The codename of dataset/table which can be used by the \code{get_eurostat} function \cr
#'      \code{type} \tab The type of information: 'dataset' or 'table' \cr
#'      \code{lastUpdate} \tab The date when the data was last time updated for tables and datasets\cr
#'      \code{lastModified}\tab The date when the structure of the dataset/table was last time modified\cr
#'      \code{dataStart}\tab The start date of the data in the dataset/table\cr
#'      \code{dataEnd}\tab The end date of the data in the dataset/table\cr
#'      \code{values}\tab The number of values in the dataset/table\cr
#'      \code{unit}\tab The unit name for tables in the language provided by the \code{lang} parameter, if the \code{type} 'dataset' this column is empty \cr
#'      \code{shortDescription}\tab The short description of the values for tables in the language provided by the \code{lang} parameterif the \code{type} 'dataset' this column is empty\cr
#'      \code{metadata.html}\tab The link to the metadata in html format\cr
#'      \code{metadata.sdmx}\tab The link to the metadata in SDMX format\cr
#'      \code{downloadLink.tsv}\tab The link to the whole dataset/table in tab separated values format in the bulk download facility
#'    }
#'    The value in the \code{code} column can be used as an id in the \code{\link{get_eurostat_data}}, \code{\link{get_eurostat_bulk}}, \code{\link{get_eurostat_raw}} and \code{\link{get_eurostat_dsd}} functions.
#'    If there is no hit for the search query, it returns \code{NULL}.
#' @export
#' @seealso \code{\link{search_eurostat_dsd}}, \code{\link{get_eurostat_data}}, \code{\link{get_eurostat_toc}}
#' @examples 
#' \dontshow{
#' if (parallel::detectCores()<=2){
#'    options(restatapi_cores=1)
#' }else{
#'    options(restatapi_cores=2)
#' }    
#' }
#' \donttest{
#' if (!(grepl("amzn|-aws|-azure ",Sys.info()['release']))) options(timeout=2)
#' head(search_eurostat_toc("energy",verbose=TRUE))
#' nrow(search_eurostat_toc("energy"))
#' head(search_eurostat_toc("energie",lang="de",ignore.case=TRUE))
#' nrow(search_eurostat_toc("energie",lang="de",ignore.case=TRUE))
#' options(timeout=60)
#' }


search_eurostat_toc <- function(pattern,lang="en",verbose=FALSE,...) {
  tmp<-get_eurostat_toc(lang=lang,verbose=verbose)
  if (!is.null(tmp)){
    tmp[grepl(pattern,tmp$title,...)|grepl(pattern,tmp$unit,...)|grepl(pattern,tmp$shortDescription,...), ]  
  } else {
    NULL
  }
  
}
