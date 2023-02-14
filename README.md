
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bonn

The R package `bonn` provides functions to retrieve data from the [INKAR
database](https://www.inkar.de/) maintained by the Federal Office for
Building and Regional Planning (BBSR) in Bonn. The package uses an
undocumented JSON API.

### Installation

You can install the package from Github using:

``` r
remotes::install_github("sumtxt/bonn", force=TRUE)
```

### Usage

The main data-retrieving function is `get_data()`. It requires to
specify which variable to retrieve and for which geography. By default
this function retrieves the data for all available time points and for
all available units of a named geography.

For a list of available geographies (municipalities, disricts etc.),
call `get_geographies()`. Then use `get_themes()` with the appropriate
geography identifier to obtain a list of themes for which variables are
available. Then call `get_variables()` for a list of available
variables. Not all variables are available for every geography. Use the
variable and geography identifier to call `get_data()`. To obtain a
detailed description of a variable, call `get_metadata`.

List available themes for districts (Kreise):

``` r
head( get_themes(geography="KRE") ) 
#>    ID          Bereich                  Unterbereich
#> 1 000    Absolutzahlen                 Absolutzahlen
#> 2 011 Arbeitslosigkeit                     Allgemein
#> 3 013 Arbeitslosigkeit                 Altersgruppen
#> 4 012 Arbeitslosigkeit                      Struktur
#> 5 021 Bauen und Wohnen Baulandmarkt und Bautätigkeit
#> 6 022 Bauen und Wohnen  Gebäude- und Wohnungsbestand
```

Indicators for theme “unemployment”:

``` r
head( get_variables(theme="011", geography="KRE") ) 
#>               KurznamePlus Bereich Gruppe  BU EU Zeitreihe
#> 1        Arbeitslosenquote     011     11 KRE           22
#> 2 Arbeitslosenquote Frauen     011     12 KRE           12
#> 3       Arbeitslose Frauen     011     13 KRE           25
#> 4 Arbeitslosenquote Männer     011     14 KRE           12
#> 5       Arbeitslose Männer     011     15 KRE           25
```

Retrieve data and metadata on the unemployment variable:

``` r
head( get_data(variable='11', geography="KRE") ) 
#>   Schlüssel Raumbezug Indikator Wert Zeit
#> 1     07331       KRE        11 7.07 2004
#> 2     05770       KRE        11 9.51 2004
#> 3     09574       KRE        11 6.64 2004
#> 4     05120       KRE        11 9.67 2004
#> 5     06534       KRE        11 6.99 2004
#> 6     07319       KRE        11 9.51 2004
```
### Notes 

- User reports suggest that some IDs of the database are not necessarily stable over time (see https://github.com/sumtxt/bonn/issues/1). 

### Complementary Packages

-   The R package `wiesbaden`
    [github.com/sumtxt/wiesbaden](https://github.com/sumtxt/wiesbaden)
    provides functions to directly retrieve data from databases
    maintained by the Federal Statistical Office of Germany (DESTATIS)
    in Wiesbaden
