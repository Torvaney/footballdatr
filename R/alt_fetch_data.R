#' Get the url for the alternative leagues
#' @keywords internal
alt_football_data_url <- function(country) {
  glue::glue("http://www.football-data.co.uk/new/{alt_country_lookup[tolower(country)]}.csv")
}

#' Fetch data for a single league and season
#'
#' @param country  The country of the league of interest
#' @param division An integer denoting the division of interest, where lower numbers refer
#'   to higher divisions.
#' @param season   The start-year of the season
#'
#' @examples
#'
#' # Fetching Premier League data for 2014/15 season
#' fetch_data("England", 0, 2014)
#'
#' # Fetching Championship data
#' fetch_data("England", 1, 2014)
#'
#' # Fetching Serie A data
#' fetch_data("Italy", 1, 2014)
#'
#' @importFrom magrittr %>%
#'
#' @export
alt_fetch_data <- memoise::memoise(function(country, division, season) {
  #Select which source to read from based on which the country appears in
  data <- alt_football_data_url(country) %>%
    data.table::fread(fill = TRUE) %>%
    #Select season

    #Select columns that exist from data table of options
    dplyr::select(tidyselect::any_of(alt_colname_map$cols)) %>%
    dplyr::mutate(Date = lubridate::dmy(Date)) %>%
    dplyr::filter(!is.na(Date))
  #Set names, skipping those that don't exist
  data.table::setnames(data, old = colname_map$cols, new = colname_map$names, skip_absent = T)
  return(data)
})

#' Create a filter string for a given season
#' @keywords internal
season_code <- function(start_year) {
  end_year <- start_year + 1
  glue::glue("{sprintf('%02d',start_year %% 100)}{sprintf('%02d',end_year %% 100)}")
}

#' Map for selecting and renaming football-data.co.uk columns
#' @keywords internal
alt_colname_map <- data.table::data.table(cols = c("League", "Date", "Home", "Away", "HG", "AG", "Res"),
                                      names = c("competition", "date", "home", "away", "hgoal", "agoal", "result"))
