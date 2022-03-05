#' Checks if a species is included in the records of MOSAIC
#'
#' This function evaluates whether a species is included the mosaic database (TRUE/FALSE).
#' If the species is in the database, returns = TRUE. If the species is not in the database, returns = FALSE.
#' @param binomialName Latin name (Genus species). Check case sensitivity.
#' @return
#' @export
#' @examples
#' mos_sppCheck("Alces alces")
#' mos_sppCheck("Pagophilus groenlandicus")


# Species check - is the species in the database?
mos_sppCheck <- function(binomialName){ # is any given species in the database
  return(length(which(mosaic@species==binomialName))>0)
}
