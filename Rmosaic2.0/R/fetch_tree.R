#' Returns the mosaic database
#'
#' This downloads the MOSAIC database as an S4 object
#' @param TreeURL Version of the MOSAIC database
#' @return mosaic database
#' @export
#' @examples
#' mos_fetch("v1.0.0")


fetch_tree <- function(TreeURL){
  tree_url <- TreeURL
  URL_act_tree <- url(tree_url)
  mos_tree <- read.tree(URL_act_tree)
  close(URL_act_tree)
  return(mos_tree)
}
