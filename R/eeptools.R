.onAttach<-function(...){
  if (!interactive() ) return()
packageStartupMessage(paste0("Welcome to eeptools for R version ",
                             packageVersion("eeptools"), "!"), appendLF=TRUE)
packageStartupMessage("Developed by Jared E. Knowles 2012-2018", appendLF=TRUE)
packageStartupMessage("for the Wisconsin Department of Public Instruction", appendLF=TRUE)
packageStartupMessage("Distributed without warranty.", appendLF=TRUE)

}