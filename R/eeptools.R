.onAttach<-function(...){
  if (!interactive() ) return()
packageStartupMessage("Welcome to eeptools for R version 1.2.0!", appendLF=TRUE)
packageStartupMessage("Developed by Jared E. Knowles 2012-2018", appendLF=TRUE)
packageStartupMessage("for the Wisconsin Department of Public Instruction", appendLF=TRUE)
packageStartupMessage("Distributed without warranty.", appendLF=TRUE)

}