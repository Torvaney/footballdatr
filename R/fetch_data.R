#' Fetch data
#'
#' Fetch data for a single league and season
#'
#' @param country  The country of the league of interest
#' @param division An integer denoting the division of interest, where lower numbers refer
#'   to higher divisions. English and Scottish Premierships are `0`, while all other
#'   top divisions (e.g. La Liga) are `1`.
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
#' @importFrom rlang !!!
#'
#' @export
fetch_data <- memoise::memoise(function(country, division, season) {
  # #Different column select dependent on year
  # if(season > 1999){
  #   colname_map <- colname_map}
  # else if(season > 1994){
  #   colname_map <- colname_map[1:10]}
  # else{
  #   colname_map <- colname_map[1:7]
  # }
  data <- football_data_url(country_lookup[tolower(country)], division, season) %>%
   data.table::fread(fill = TRUE) %>%
  #Select columns that exist from data table of options
    dplyr::select(tidyselect::any_of(colname_map$cols)) %>%
    dplyr::mutate(Date = lubridate::dmy(Date)) %>%
    dplyr::filter(!is.na(Date))
  #Set names, skipping those that don't exist
  data.table::setnames(data, old = colname_map$cols, new = colname_map$names, skip_absent = T)
  return(data)
})

#' Get the url for a given league and season
#' @keywords internal
football_data_url <- function(country, division, season) {
  glue::glue("http://www.football-data.co.uk/mmz4281/{season_code(season)}/{country}{division}.csv")
}

#' Get the football-data.co.uk string for a given season
#' @keywords internal
season_code <- function(start_year) {
  end_year <- start_year + 1
  glue::glue("{sprintf('%02d',start_year %% 100)}{sprintf('%02d',end_year %% 100)}")
}

# TODO: better naming convention for home and away columns - should be easy to use with
#       tidyr::gather and tidyr::separate
#' Map for selecting and renaming foorball-data.co.uk columns
#' @keywords internal
colname_map <- data.table::data.table(cols = c("Div", "Date", "HomeTeam", "AwayTeam", "FTHG", "FTAG", "FTR", "HTHG", "HTAG",
"HTR", "Referee", "HS", "AS", "HST", "AST", "HF", "AF", "HC", "AC", "HY", "AY", "HR", "AR"),
names = c("competition", "date", "home", "away", "hgoal", "agoal", "result", "hgoal_ht", "agoal_ht", "result_ht",
          "referee", "hshot", "ashot", "hshot_on_target", "ashot_on_target", "hfoul", "afoul", "hcorner",
          "acorner", "hyellow", "ayellow", "hred", "ared"
))
