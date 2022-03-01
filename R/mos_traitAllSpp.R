#' Returns all records in MOSAIC for a given trait
#'
#' This function returns all records in the MOSAIC database for a given trait.
#' @param trait Name of trait. Prompt:  mos_traitList(mosaic)  for the list of trait names.
#' @return
#' @export
#' @examples
#' mos_sppCheck("biomass")
#' mos_sppCheck("sexual dimorphism")
#' mos_sppCheck("volancy")


# Species check - is the species in the database?
mos_traitAllSpp <- function(trait){
  traitOut <- data.frame(mosaic@species,
                         slot(slot(mosaic, trait),"value"))
  return(traitOut)
}
