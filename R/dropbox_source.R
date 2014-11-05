##' A function to source R scripts from Dropbox public shares
##' @description  Allows the user to source R scripts from a public Dropbox folder using the 
##' URL provided by the Dropbox shared URL tool. Parses the URL and then sources
##' the script in one easy line.
##' @param url a character string for the full URL of the Dropbox share
##' @details url must be the full URL including https://
##' @seealso \code{\link{source}}
##' @return None. The script is sourced.
##' @author Jared E. Knowles
##' @note This function works with Dropbox as of the release date. If functionality 
##' breaks, please e-mail the package maintainer to push an update. 
##' @keywords utilities
##' @export
##' @examples
##' \dontrun{
##'  dropbox_source("https://dropbox.com/public/somekey/coolscript.R")
##' }
dropbox_source <- function(url){
  s<-stringr::str_extract(url, "[/][a-z][/]\\d+[/][a-z]*.*")
  new_url<-paste("http://dl.dropbox.com",s,sep="")
  source(new_url)
}
