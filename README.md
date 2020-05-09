
<!-- README.md is generated from README.Rmd. Please edit that file -->

# footballdatr

The goal of footballdatr is to enable easy use of football-data.co.uk
data within R.

## Installation

You can install the footballdatr from Github with:

``` r
devtools::install_github("torvaney/footballdatr")
```

## Example

To download Premier League data for the 2018/19 season:

``` r
footballdatr::fetch_data(
  "England",  # Country
  0,          # Division tier (0 = highest)
  2018        # Season (start year)
)
#> # A tibble: 380 x 24
#>    competition date       home  away  hgoal agoal result hgoal_ht agoal_ht
#>    <chr>       <date>     <chr> <chr> <int> <int> <chr>     <int>    <int>
#>  1 E0          2018-08-10 Man … Leic…     2     1 H             1        0
#>  2 E0          2018-08-11 Bour… Card…     2     0 H             1        0
#>  3 E0          2018-08-11 Fulh… Crys…     0     2 A             0        1
#>  4 E0          2018-08-11 Hudd… Chel…     0     3 A             0        2
#>  5 E0          2018-08-11 Newc… Tott…     1     2 A             1        2
#>  6 E0          2018-08-11 Watf… Brig…     2     0 H             1        0
#>  7 E0          2018-08-11 Wolv… Ever…     2     2 D             1        1
#>  8 E0          2018-08-12 Arse… Man …     0     2 A             0        1
#>  9 E0          2018-08-12 Live… West…     4     0 H             2        0
#> 10 E0          2018-08-12 Sout… Burn…     0     0 D             0        0
#> # … with 370 more rows, and 15 more variables: result_ht <chr>,
#> #   referee <chr>, hshot <int>, ashot <int>, hshot_on_target <int>,
#> #   ashot_on_target <int>, hfoul <int>, afoul <int>, hcorner <int>,
#> #   acorner <int>, hyellow <int>, ayellow <int>, hred <int>, ared <int>,
#> #   closing_odds <list>
```

To view the available competitions

``` r
footballdatr::ls_countries()
#> Available countries: belgium, england, france, germany, greece, italy, portugal, scotland, spain, turkey
```
