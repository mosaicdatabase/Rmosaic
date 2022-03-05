#' Returns metadata for a given trait and species
#'
#' This function returns a dataframe containing the metadata for a given record (trait + spp) - including
#' author, year, journal, database, and mosaic. See the MOSAIC user guide for more information.
#' See mos_multiMetaRecords if searching metadata for > 1 species.
#' @param trait Trait name of a factorial variable. Search mos_traitAllSpp(mosaic) for trait list if needed.
#' @param index Index of the species of interest search "which(slot(mosaic, "species")==BinomialName)" for index.
#' @return dataframe of metadata for a given species and trait record
#' @export
#' @examples
#' mos_metadata("volancy", 14)


# Metadata for a given trait and species index
mos_metadata <- function(trait, index){
  metas <- data.frame(matrix(NA, nrow=1, ncol=5))
  colnames(metas) <- c("author", "year", "journal", "database", "mosaic")
  metas[1,1] <- slot(slot(mosaic, trait), "author")[[index]]
  metas[1,2] <- slot(slot(mosaic, trait), "year")[[index]]
  metas[1,3] <- slot(slot(mosaic, trait), "journal")[[index]]
  metas[1,4] <- slot(slot(mosaic, trait), "database")[[index]]
  metas[1,5] <- slot(slot(mosaic, trait), "mosaic")[[index]]
  return(metas)
}
