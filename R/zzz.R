#' @import data.table

.onLoad <- function(libname, pkgname){
  load_cfg(verbose=FALSE)
  options(restatapi_verbose=FALSE)
  options(restatapi_dmethod="auto")
}

.onAttach <- function(libname, pkgname){
  load_cfg(verbose=TRUE)
  options(restatapi_verbose=FALSE)
  options(restatapi_dmethod="auto")
}