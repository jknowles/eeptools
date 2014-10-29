max_mis <- function(x){
  varclass <- class(x)
  suppressWarnings(x <- max(x, na.rm=TRUE))
  if(varclass == "integer"){
    ifelse(!is.finite(x), NA_integer_, x)
  } else if(varclass == "numeric") {
    ifelse(!is.finite(x), NA_real_, x)
  }

}
