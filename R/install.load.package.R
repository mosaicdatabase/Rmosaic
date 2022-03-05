#' Returns the mosaic database
#'
#' This downloads the MOSAIC database as an S4 object
#' @param x Version of the MOSAIC database
#' @return mosaic database
#' @export
#' @examples
#' mos_fetch("v1.0.0")

install.load.package <- function(x) { # Automate installs & load packages from CRAN where needed
  if (!require(x, character.only = TRUE)){ # If package is not yet installed, then install package from CRAN
    install.packages(x, repos='http://cran.us.r-project.org')
  }
  require(x, character.only = TRUE) # Require loads packages that are downloaded
}
