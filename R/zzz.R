#' @import data.table
.onLoad <- function(libname, pkgname){
  options(mc.cores=parallel::detectCores()-1)
  load_cfg(verbose=TRUE)
  options(restatapi_verbose=FALSE)
}

