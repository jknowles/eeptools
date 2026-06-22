# Helpers for testing deprecated/defunct functions.

# Evaluate `expr`, muffling only deprecation/defunct warnings so that
# behavioural tests of deprecated functions stay quiet while still surfacing
# any other (genuine) warnings. Returns the value of `expr`.
suppress_deprecation <- function(expr) {
  withCallingHandlers(
    expr,
    warning = function(w) {
      if (grepl("deprecated|defunct", conditionMessage(w), ignore.case = TRUE)) {
        invokeRestart("muffleWarning")
      }
    }
  )
}

# Return the message of the FIRST warning thrown by `expr`. Because every
# deprecated function calls .Deprecated() on its first line, this captures the
# deprecation warning and unwinds before any heavy work runs.
first_warning <- function(expr) {
  tryCatch(expr, warning = function(w) conditionMessage(w))
}
