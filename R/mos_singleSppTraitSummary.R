#' Returns all MOSAIC attribute/trait records for one species
#'
#' This function returns all records (no metadata) in the MOSAIC database for one species.
#' @param speciesNameLatin Binomial species name (Genus species).
#' @return list of records (no metadata) for all attribute/trait fields in MOSAIC for the species
#' @export
#' @examples
#' mos_singleSppTraitSummary("Alces alces")

# Trait summary for a single species
mos_singleSppTraitSummary  <- function(speciesNameLatin){
  speciesIndex <- which(mosaic@species==speciesNameLatin)
  metadataNames <- slotNames(mosaic)[-c(1:3)]
  meta <- data.frame(matrix(NA, nrow=1, ncol=length(metadataNames)))
  colnames(meta) <- metadataNames
  for(i in 1:length(metadataNames)){
    meta[,i] <- slot(slot(mosaic, metadataNames[[i]]), "value")[[speciesIndex]]
  }
  return(meta)
}
