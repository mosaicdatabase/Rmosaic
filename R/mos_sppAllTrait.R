#' Returns all MOSAIC attribute/trait records for one or more species
#'
#' This function returns all records (no metadata) in the MOSAIC database for one or more species.
#' @param sppList list of one or more species for which a trait summary is desired.
#' @return list of records (no metadata) for all attribute/trait fields in MOSAIC
#' @export
#' @examples
#' mos_sppAllTrait("Alces alces")
#' mos_sppAllTrait(("Acinonyx jubatus", "Acropora downingi", "Aepyceros melampus", "Alces alces", "Alligator mississippiensis")))


# All trait records for one or more species
mos_sppAllTrait <- function(sppList){
  sppList <- as.list(sppList)
  summary <- lapply(sppList, mos_singleSppTraitSummary)
  framesummary <- data.frame(matrix(NA, nrow=length(summary), ncol=length(summary[[1]])+1))
  colnames(framesummary) <- c("sppnames", colnames(summary[[1]]))
  for(i in 1:length(summary)){
    framesummary[i,] <- c(sppList[[i]],summary[[i]])
  }
  return(framesummary)
}
