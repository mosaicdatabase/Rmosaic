#' Reports the trait names from the mosaic object
#'
#' This function extracts the traitnames from the mosaic object
#' @param mosaic The mosaic object (run:  mosaic <- mos_fetch("v1.0.0")  to obtain mosaic)
#' @return
#' @export
#' @examples
#' mos_traitNames(mosaic)


# TraitList
mos_traitNames <- function(mosaic){
  names <- slotNames(mosaic)[4:length(slotNames(mosaic))]
  fullName <- c("biomass", "height", "growth determination", "regeneration",
                "sexual dimorphism", "mating system", "hermaphrodism",
                "sequential hermaphrodism", "dispersal capability",
                "dispersal type", "mode of dispersal", "dispersal class",
                "volancy/flight", "acquatic habitat dependency")
  df <- data.frame(c(4:(length(names)+3)), names, fullName)
  colnames(df) <- c("slot index", "mosaic abreviated name", "full trait name")
  return(df)
}
