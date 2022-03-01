#' Returns the absolute and relative occurance of any given trait level.
#'
#' This function returns the frequency and counts of records for factorial variable (e.g., 30% volant, 70% non-volant)
#' @param trait Trait name of a factorial variable. Search mos_traitAllSpp(mosaic) for trait list if needed.
#' @return list of records (no metadata) for all attribute/trait fields in MOSAIC for the species
#' @export
#' @examples
#' mos_traitFrequency("volancy")
#' mos_traitFrequency("sexual dimorphism")


# Trait frequency for a given trait
mos_traitFrequency <- function(trait){
  focalTrait <- slot(slot(mosaic, trait), "value")
  focalTrait <- as.factor(focalTrait)
  hold <- matrix(NA,
                 nrow=length(levels(focalTrait)),
                 ncol=2)

  rownames(hold) <- levels(focalTrait)
  colnames(hold) <- c("counts", "freq")

  for(i in 1:length(levels(focalTrait))){
    hold[i,1] <- sum(focalTrait==levels(focalTrait)[[i]])
  }

  hold[which(rownames(hold)=="NDY"),2] <- NA
  hold[-which(rownames(hold)=="NDY"),2] <- round(hold[-which(rownames(hold)=="NDY"),1]/sum(hold[-which(rownames(hold)=="NDY"),1]), 3)
  return(hold)
}
