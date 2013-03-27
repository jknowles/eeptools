.onAttach<-function(...){
  if (!interactive() ) return()
packageStartupMessage("Welcome to eeptools for R version 0.1 ",appendLF=TRUE)
packageStartupMessage("Free and Open Software for Education Evaluation", appendLF=TRUE)
packageStartupMessage("Developed by Jared E. Knowles 2012-2013", appendLF=TRUE)
packageStartupMessage("for The Wisconsin Department of Public Instruction", appendLF=TRUE)
packageStartupMessage("Distributed without warranty", appendLF=TRUE)

}

# testit <- function() {
#   message("testing")
#   packageStartupMessage("Welcome to eeptools for R version 0.1 ",appendLF=TRUE)
#   packageStartupMessage("Free and Open Software for Education Evaluation", appendLF=TRUE)
#   packageStartupMessage("Developed by Jared E. Knowles 2012-13", appendLF=TRUE)
#   packageStartupMessage("for The Wisconsin Department of Public Instruction", appendLF=TRUE)
#   packageStartupMessage("Distributed without warranty", appendLF=TRUE)
#   Sys.sleep(1)
#   packageStartupMessage("....")
# }