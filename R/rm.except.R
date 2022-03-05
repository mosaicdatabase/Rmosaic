#' Returns the mosaic database
#'
#' This downloads the MOSAIC database as an S4 object
#' @param except Version of the MOSAIC database
#' @param pattern Version of the MOSAIC database
#' @return mosaic database
#' @export
#' @examples
#' mos_fetch("v1.0.0")


rm.except <- function(except, pattern) {
  except = except
  pattern = pattern
  formula = c(c(except), ls(pattern = pattern, envir = .GlobalEnv))
  rm(list = setdiff(ls(envir = .GlobalEnv), formula), envir = .GlobalEnv)
}
