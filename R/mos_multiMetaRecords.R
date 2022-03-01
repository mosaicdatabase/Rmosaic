#' Returns metadata for a given trait and >1 species
#'
#' This function returns a dataframe containing the metadata for a given record (trait + multiple spp) - including
#' author, year, journal, database, and mosaic. See the MOSAIC user guide for more information.
#' @param trait Trait name of a factorial variable. Search mos_traitAllSpp(mosaic) for trait list if needed.
#' @param index Index of the species of interest search "match(slot(mosaic, "species"), c(BinomialName1,BinomialName1, etc.))" for indices
#' @return dataframe of metadata for a given species and trait record
#' @export
#' @examples
#' mos_multiMetaRecords("volancy", 14)


mos_multiMetaRecords <- function(trait, sequenceOfIds){
  formerMeta <- mos_metadata("volancy", sequenceOfIds[[1]])
  for(i in 2:length(sequenceOfIds)){
    formerMeta <- rbind(mos_metadata("volancy", sequenceOfIds[[i]]), formerMeta)
  }
  return(formerMeta)
}
