#' @title Extract the text of the table of contents from SDMX XML 
#' @description Extracts the values of a node from the Eurostat XML Table of contents (TOC) file
#' @param ns an XML node set from the XML TOC file 
#' @export
#' @details It is a sub-function to use in the \code{\link{get_eurostat_toc}} function.
#' @return a character vector with all the values of the node set.
#' @examples 
#' \dontshow{
#' if (parallel::detectCores()<=2){
#'    options(restatapi_cores=1)
#' }else{
#'    options(restatapi_cores=2)
#' }    
#' }
#' cfg<-get("cfg",envir=restatapi::.restatapi_env) 
#' rav<-get("rav",envir=restatapi::.restatapi_env)
#' toc_endpoint<-eval(parse(text=paste0("cfg$TOC_ENDPOINT$'",rav,"'$ESTAT$xml")))
#' \donttest{
#' if (!(grepl("amzn|-aws|-azure ",Sys.info()['release']))) options(timeout=2)
#' tryCatch(xml_leafs<-xml2::xml_find_all(xml2::read_xml(toc_endpoint),".//nt:leaf"),
#'          error = function(e) {xml_leafs<-""},
#'          warning = function(w) {xml_leafs<-""})
#' if (exists("xml_leafs")){
#'    if (Sys.info()[['sysname']]=='Windows'){ 
#'       xml_node<-as.character(xml_leafs[1])
#'    }else{
#'       xml_node<-xml_leafs[1]
#'    }
#'    restatapi::extract_toc(xml_node)
#' }
#' options(timeout=60)
#' }


extract_toc<-function(ns){
  if (Sys.info()[['sysname']]=='Windows'){ns<-xml2::as_xml_document(ns)}
  lf<-data.table::as.data.table(t(xml2::xml_text(xml2::xml_children(ns))))
  data.table::setnames(lf,gsub("\\.character\\(0\\)","",paste0(xml2::xml_name(xml2::xml_children(ns)),".",xml2::xml_attrs(xml2::xml_children(ns)))))
  return(lf[])
}

