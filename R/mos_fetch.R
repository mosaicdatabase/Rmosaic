#' Returns the mosaic database
#'
#' This downloads the MOSAIC database as an S4 object
#' @param versionSet Version of the MOSAIC database
#' @return mosaic database
#' @export
#' @examples
#' mos_fetch("v1.0.0")
library(ape)

mosaic_meta <- setClass("mosaic_meta",
           representation(value = "character",
                          author = "character",
                          year = "character",
                          journal = "character",
                          doi = "character",
                          database = "character",
                          mosaic = "character",
                          notes = "logical")
                       )

mosaic_base <- setClass("mosaic_base",
           representation(species = "character",
                          taxaMetadat = "data.frame",
                          index = "list",
                          mosaicID = "numeric",
                          biomass = "mosaic_meta",
                          height = "mosaic_meta",
                          growthdet = "mosaic_meta",
                          regen = "mosaic_meta",
                          dimorph = "mosaic_meta",
                          matsyst = "mosaic_meta",
                          hermaph = "mosaic_meta",
                          seqherm = "mosaic_meta",
                          dispcap = "mosaic_meta",
                          disptype = "mosaic_meta",
                          modedisp = "mosaic_meta",
                          dispclass = "mosaic_meta",
                          volancy = "mosaic_meta",
                          aquadep = "mosaic_meta",
                          climate = "data.frame",
                          phylogeny = "list")
  )

mos_fetch <- function(id_key){
  
  package_vec <- c( # vector of package/library names - note: CRAN-dependent (no GitHub, local, &c.)
    "RCurl",
    "Rcompadre",
    "ape"
  )

  api_key <- "https://github.com/mosaicdatabase/mosaicdatabase/blob/main/new_IDs.rds?raw=true"
  Indices <- readRDS(url(api_key, method="libcurl"))
  sapply(package_vec, install.load.package) # Load the vector of libraries based on the install function - T & Fs returned

  compadre <- cdb_fetch("compadre")
  comadre <- cdb_fetch("comadre")
  
  plantPhy.url <- "https://raw.githubusercontent.com/mosaicdatabase/mosaicdatabase/main/plant_tree.txt"
  plantPhyLink <- url(plantPhy.url, method="libcurl")
  plantPhyType <- ape::read.tree(file=plantPhyLink)
  close(plantPhyLink)
           
  animalPhy.url <- "https://raw.githubusercontent.com/mosaicdatabase/mosaicdatabase/main/animal_tree.txt"
  animalPhyLink <- url(animalPhy.url, method="libcurl")
  animalPhyType <- ape::read.tree(file=animalPhyLink)
  close(animalPhyLink)
           
  phylogenies <- list(plantPhyType, animalPhyType)
  names(phylogenies) <- c("plantPhylogeny", "animalPhylogeny")
   
  climate.url <- "https://raw.githubusercontent.com/mosaicdatabase/mosaicdatabase/main/climate_031422.csv"
  joint.climate <- read.csv(url(climate.url, method="libcurl"))

  id_key <- id_key
  api_key_link <- paste("https://raw.githubusercontent.com/mosaicdatabase/mosaicdatabase/main/MOSAIC_", id_key, ".csv", sep="")
  mosaic <- read.csv(url(api_key_link))

  spp <- mosaic$specieslist

  cp_names <- gsub("_", " ", compadre@data$SpeciesAuthor)
  cp_names <- sub('^(\\w+\\s+\\w+).*', '\\1', cp_names)

  ca_names <- gsub("_", " ", comadre@data$SpeciesAuthor)
  ca_names <- sub('^(\\w+\\s+\\w+).*', '\\1', ca_names)

  taxMeta <- list()

  Kingdom_a <- list()
  Phylum_a <- list()
  Class_a <- list()
  Order_a <- list()
  Family_a <- list()
  Genus_a <- list()
  Species_a <- list()

  for(i in 1:length(spp)){
    Kingdom_a[[i]] <- try(comadre@data$Kingdom[match(spp[[i]], ca_names)])
    Phylum_a[[i]] <- try(comadre@data$Phylum[match(spp[[i]], ca_names)])
    Class_a[[i]] <- try(comadre@data$Class[match(spp[[i]], ca_names)])
    Order_a[[i]] <- try(comadre@data$Order[match(spp[[i]], ca_names)])
    Family_a[[i]] <- try(comadre@data$Family[match(spp[[i]], ca_names)])
    Genus_a[[i]] <- try(comadre@data$Genus[match(spp[[i]], ca_names)])
    Species_a[[i]] <- try(comadre@data$Species[match(spp[[i]], ca_names)])
  }

  Kingdom_a <- unlist(Kingdom_a)
  Phylum_a <- unlist(Phylum_a)
  Class_a <- unlist(Class_a)
  Order_a <- unlist(Order_a)
  Family_a <- unlist(Family_a)
  Genus_a <- unlist(Genus_a)
  Species_a <- unlist(Species_a)

  Kingdom_p <- list()
  Phylum_p <- list()
  Class_p <- list()
  Order_p <- list()
  Family_p <- list()
  Genus_p <- list()
  Species_p <- list()

  for(i in 1:length(spp)){
    Kingdom_p[[i]] <- try(compadre@data$Kingdom[match(spp[[i]], cp_names)])
    Phylum_p[[i]] <- try(compadre@data$Phylum[match(spp[[i]], cp_names)])
    Class_p[[i]] <- try(compadre@data$Class[match(spp[[i]], cp_names)])
    Order_p[[i]] <- try(compadre@data$Order[match(spp[[i]], cp_names)])
    Family_p[[i]] <- try(compadre@data$Family[match(spp[[i]], cp_names)])
    Genus_p[[i]] <- try(compadre@data$Genus[match(spp[[i]], cp_names)])
    Species_p[[i]] <- try(compadre@data$Species[match(spp[[i]], cp_names)])
  }
  compadre@data$Kingdom[match(spp[[1003]], cp_names)]

  Kingdom_p <- unlist(Kingdom_p)
  Phylum_p <- unlist(Phylum_p)
  Class_p <- unlist(Class_p)
  Order_p <- unlist(Order_p)
  Family_p <- unlist(Family_p)
  Genus_p <- unlist(Genus_p)
  Species_p <- unlist(Species_p)


  TaxaMeta <- data.frame(matrix(NA, ncol=7, nrow=length(mosaic$specieslist)))
  rownames(TaxaMeta) <- mosaic$specieslist
  colnames(TaxaMeta) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")

  for(i in 1:length(mosaic$specieslist)){
    if(is.na(Kingdom_p[i]==FALSE)){
      TaxaMeta[i,1]<- Kingdom_a[i]
      TaxaMeta[i,2]<- Phylum_a[i]
      TaxaMeta[i,3]<- Class_a[i]
      TaxaMeta[i,4]<- Order_a[i]
      TaxaMeta[i,5]<- Family_a[i]
      TaxaMeta[i,6]<- Genus_a[i]
      TaxaMeta[i,7]<- Species_a[i]
    }else if(is.na(Kingdom_p[2]==TRUE)){
      TaxaMeta[i,1]<- Kingdom_p[i]
      TaxaMeta[i,2]<- Phylum_p[i]
      TaxaMeta[i,3]<- Class_p[i]
      TaxaMeta[i,4]<- Order_p[i]
      TaxaMeta[i,5]<- Family_p[i]
      TaxaMeta[i,6]<- Genus_p[i]
      TaxaMeta[i,7]<- Species_p[i]
    }
  }
           
           
  theMetMet <- list()
  for(i in 1:14){
    theMetMet[[i]] <- new("mosaic_meta",
                          value = unlist(mosaic[,Index(i)[1]], use.names = FALSE),
                          author = unlist(mosaic[,Index(i)[2]], use.names = FALSE),
                          year = unlist(mosaic[,Index(i)[3]], use.names = FALSE),
                          journal = unlist(mosaic[,Index(i)[4]], use.names = FALSE),
                          doi = unlist(mosaic[,Index(i)[5]], use.names = FALSE),
                          database = unlist(mosaic[,Index(i)[6]], use.names = FALSE),
                          mosaic = unlist(mosaic[,Index(i)[7]], use.names = FALSE),
                          notes = unlist(mosaic[,Index(i)[8]], use.names = FALSE)
    )
  }
           
  biomass <- theMetMet[[1]]
  height <- theMetMet[[2]]
  growthdet <- theMetMet[[3]]
  regen <- theMetMet[[4]]
  dimorph <- theMetMet[[5]]
  matsyst <- theMetMet[[6]]
  hermaph <- theMetMet[[7]]
  seqherm <- theMetMet[[8]]
  dispcap <- theMetMet[[9]]
  disptype <- theMetMet[[10]]
  modedisp <- theMetMet[[11]]
  dispclass <- theMetMet[[12]]
  volancy <- theMetMet[[13]]
  aquadep <- theMetMet[[14]]

  mosiac_main <- new("mosaic_base",
                     species = unlist(mosaic[,113], use.names = FALSE),
                     taxaMetadat = TaxaMeta,
                     index = Indices,
                     mosaicID = c(2000:2461,5000:5959),
                     biomass = biomass,
                     height = height,
                     growthdet = growthdet,
                     regen = regen,
                     dimorph = dimorph,
                     matsyst = matsyst,
                     hermaph = hermaph,
                     seqherm = seqherm,
                     dispcap = dispcap,
                     disptype = disptype,
                     modedisp = modedisp,
                     dispclass = dispclass,
                     volancy = volancy,
                     aquadep = aquadep,
                     climate = joint.climate,
                     phylogeny = phylogenies
  )
  rm.except("mosaic", pattern = "com")
  return(mosiac_main)
}
