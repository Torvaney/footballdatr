#' List available countries
#' @export
ls_countries <- function() {
  glue::glue(
    "Available countries: ",
    glue::glue_collapse(names(country_lookup), sep = ", ")
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
