#' List available countries
#' @export
ls_countries <- function() {
  glue::glue(
    "Available countries: ",
    glue::glue_collapse(sort(c(names(country_lookup), names(alt_country_lookup))), sep = ", ")
  )
}

#' Lookup football-data.co.uk country codes by name
#' @keywords internal
country_lookup <- list(
  belgium  = "B",
  england  = "E",
  france   = "F",
  germany  = "D",
  greece   = "G",
  italy    = "I",
  portugal = "P",
  scotland = "SC",
  spain    = "SP",
  turkey   = "T"
)

#' Lookup alternative football-data.co.uk country codes by name
#' @keywords internal
alt_country_lookup <- list(
  argentina  = "ARG",
  austria    = "AUT",
  brazil     = "BRA",
  china      = "CHN",
  denmark    = "DNK",
  finland    = "FIN",
  ireland    = "IRL",
  japan      = "JPN",
  mexico     = "MEX",
  norway     = "NOR",
  poland     = "POL",
  romania    = "ROU",
  russia     = "RUS",
  sweden     = "SWE",
  switzerland= "SWZ",
  usa = "USA"
)
