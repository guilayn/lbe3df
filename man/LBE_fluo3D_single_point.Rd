% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LBE_fluo3D_single_point.R
\name{LBE_fluo3D_single_point}
\alias{LBE_fluo3D_single_point}
\title{Extraction of intensity singles, given any excitation and emission wavelenghts.}
\usage{
LBE_fluo3D_single_point(x_emission = 350, y_excitation = 350,
  data = data_interpol)
}
\arguments{
\item{x_emission}{Selected emission wavelenght in nm.  Default is 350 for exampling purposes.}

\item{y_excitation}{Selected excitation wavelenght in nm.  Default is 350 for exampling purposes.}

\item{data}{The default value of "data_interpol" is assuming that "LBE_fluo3D_processing" have just been used. Otherwise a list containing x=vector of emission wavelenghts, y=vector of excitation wavelenghts, z= a matrix containing the z values (intensity) where X must be the lines, Y must be the columns and Z must be the values of the table.}
}
\description{
Extraction of intensity singles, given any excitation and emission wavelenghts.
}
\examples{
> setwd(XXXX) #XXX is your directory contaning the .sp files (copy and paste from the brownse and replace all the "\\" by "/").
> LBE_fluo3D_processing() #include your options if you want.
> single_point(350,420) #returns an intensity value at emission = 350 and excitation = 420 nm.
}
\keyword{3D}
\keyword{fluorescence}
