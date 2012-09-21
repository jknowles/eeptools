dropbox_source <-
function(myurl){
  require(stringr)
  s<-str_extract(myurl,"[/][a-z][/]\\d+[/][a-z]*.*")
  new_url<-paste("http://dl.dropbox.com",s,sep="")
  source(new_url)
}
