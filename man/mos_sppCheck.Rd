% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mos_sppCheck.R
\name{mos_sppCheck}
\alias{mos_sppCheck}
\title{Checks if a species is included in the records of MOSAIC}
\usage{
mos_sppCheck(binomialName)
}
\arguments{
\item{binomialName}{Latin name (Genus species). Check case sensitivity.}
}
\value{

}
\description{
This function evaluates whether a species is included the mosaic database (TRUE/FALSE).
If the species is in the database, returns = TRUE. If the species is not in the database, returns = FALSE.
}
\examples{
mos_sppCheck("Alces alces")
mos_sppCheck("Pagophilus groenlandicus")
}
