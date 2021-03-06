% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bootstrapify.R
\name{bootstrapify}
\alias{bootstrapify}
\title{Create a bootstrapped tibble}
\usage{
bootstrapify(data, times, ..., key = ".bootstrap")
}
\arguments{
\item{data}{A tbl.}

\item{times}{A single integer specifying the number of resamples.
If the \code{tibble} is grouped, this is the number of resamples per group.}

\item{...}{Not used.}

\item{key}{A single character specifying the name of the virtual group
that is added.}
}
\value{
A \code{resampled_df} with an extra group specified by the \code{key}.
}
\description{
\code{bootstrapify()} creates a bootstrapped tibble with \emph{virtual groups}.
}
\details{
The following functions have special / interesting behavior when used with
a \code{resampled_df}:
\itemize{
\item \code{\link[dplyr:collect]{dplyr::collect()}}
\item \code{\link[dplyr:summarise]{dplyr::summarise()}}
\item \code{\link[dplyr:do]{dplyr::do()}}
\item \code{\link[dplyr:group_map]{dplyr::group_map()}}
\item \code{\link[dplyr:group_modify]{dplyr::group_modify()}}
\item \code{\link[dplyr:group_walk]{dplyr::group_walk()}}
\item \code{\link[dplyr:group_nest]{dplyr::group_nest()}}
\item \code{\link[dplyr:group_split]{dplyr::group_split()}}
}
}
\examples{
library(dplyr)
library(broom)

bootstrapify(iris, 5)

iris \%>\%
  bootstrapify(5) \%>\%
  summarise(per_strap_mean = mean(Petal.Width))

iris \%>\%
  group_by(Species) \%>\%
  bootstrapify(5) \%>\%
  summarise(per_strap_species_mean = mean(Petal.Width))

iris \%>\%
  bootstrapify(5) \%>\%
  do(tidy(lm(Sepal.Width ~ Sepal.Length + Species, data = .)))

# Alternatively, use the newer group_modify()
iris \%>\%
  bootstrapify(5) \%>\%
  group_modify(~tidy(lm(Sepal.Width ~ Sepal.Length + Species, data = .x)))

# Alter the name of the group with `key`
# Materialize them with collect()
straps <- bootstrapify(iris, 5, key = ".straps")
collect(straps)

}
\seealso{
\code{\link[=collect.resampled_df]{collect.resampled_df()}}

Other virtual samplers: \code{\link{samplify}}
}
\concept{virtual samplers}
