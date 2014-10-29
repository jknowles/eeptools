retained_calc <- function(df, sid='sid', grade_val=9){
  dt <- data.table(df, key=c(sid, 'grade'))
  result <- dt[I(grade == grade_val), list(count = .N), by = key(dt)]
  result <- result[, list(sid, retained = ifelse(count>1, 'Y', 'N'))]
  return(as.data.frame(result))
}

# Test Data
# x <- data.frame(sid = c(101, 101, 102, 103, 103, 103, 104),
#                 grade = c(9, 10, 9, 9, 9, 10, 10))