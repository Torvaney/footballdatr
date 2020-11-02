#' Get the url for the alternative leagues
#' @keywords internal
alt_football_data_url <- function(country) {
  glue::glue("http://www.football-data.co.uk/new/{alt_country_lookup[tolower(country)]}.csv")
}

#' Fetch data for a single country and season
#'
#' @param country  The country of the league of interest
#' @param season   The start-year of the season
#'
#' @examples
#'
#' # Fetching Danish data for 2014/15 season
#' alt_fetch_data("Denmark", 2014)
#'
#' @importFrom magrittr %>%
alt_fetch_data <- memoise::memoise(function(country, season) {
  #Select which source to read from based on which the country appears in
  data <- alt_football_data_url(country) %>%
    data.table::fread(fill = TRUE) %>%
    #Select season
    dplyr::filter(Season == alt_season_code(season) | Season == season) %>%
    #Select columns that exist from data table of options
    dplyr::select(tidyselect::any_of(alt_colname_map$cols)) %>%
    dplyr::mutate(Date = lubridate::dmy(Date)) %>%
    dplyr::filter(!is.na(Date))
  #Set names, skipping those that don't exist
  data.table::setnames(data, old = alt_colname_map$cols, new = alt_colname_map$names, skip_absent = T)
  return(data)
})

#' Create a filter string for a given season
#' @keywords internal
alt_season_code <- function(start_year) {
  end_year <- start_year + 1
  paste(start_year, end_year, sep = "/")
}

#' Map for selecting and renaming football-data.co.uk columns
#' @keywords internal
alt_colname_map <- tibble::tibble(cols = c("League", "Date", "Home", "Away", "HG", "AG", "Res"),
                                      names = c("competition", "date", "home", "away", "hgoal", "agoal", "result"))
