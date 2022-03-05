#' Returns the mosaic database
#'
#' This downloads the MOSAIC database as an S4 object
#' @param i Version of the MOSAIC database
#' @return mosaic database
#' @export
#' @examples
#' mos_fetch("v1.0.0")

Index <- function(i){
  return(1:8+(8*i)-8)
}
