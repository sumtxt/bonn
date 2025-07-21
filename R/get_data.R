#' Get Data 
#'
#' \code{get_data} retrieves a data frame with all available values for a variable
#'
#' @param variable variable identifier as character string
#' @param geography geography identifier as character string 
#' @param time time identifier as vector of character strings
#'
#' @details 
#' To get a list of available geographies use \code{\link{get_geographies}}. To 
#' get a list of available variables use \code{\link{get_variables}}. 
#' 
#' The function retrieves all values for all available years by default. 
#'     
#' @return a \code{data.frame} with columns \code{Schlüssel} (unit identifier), 
#' \code{Raumbezug} (geography identifier), \code{Indikator} (variable identifier), 
#' \code{Wert} (value) and \code{time} (year or time period). 
#'
#' @seealso \code{\link{get_geographies}} \code{\link{get_variables}} \code{\link{get_metadata}} 
#'
#' @examples 
#' # The SSL vertification seems to fail for some Linux systems. 
#' # This is likely because of a SSL certificate issue on the INKAR server. 
#' # Disabling SSL verification comes with risks: 
#' # https://curl.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html
#' httr::set_config(config(ssl_verifypeer = 0L))
#' 
#' # GDP for all districts/all available years
#' get_data(variable="011", geography="KRE")
#' 
#' # Reset configuration  
#' httr::reset_config()
#' 
#' 
#' 
#' 
#' 
#' @export
get_data <- function(variable,geography,time=NULL){
  
  if( length(variable)!=1 ) stop ("Can not retrieve data for more than one variable at a time.")
  if( length(geography)!=1 ) stop ("Can not retrieve data for more than one geography at a time.")
  
  url <- paste0(inkar_url, "/Table/GetDataTable")
  
  # Zeitbezug
  zeitbezug <- get_zeitbezuege(
    raumbezug=geography,
    variable=variable)
  
  
  zeitbezug_ <- zeitbezug[,c("Zeit", "IndID", "ZeitID")]
  if(is.null(time)==FALSE){
    zeitbezug_ <- zeitbezug_[zeitbezug_[,"Zeit"] %in% time,]}
  
  zeitbezug <- zeitbezug[, c("Gruppe", "IndID", "ZeitID", "RaumID")]
  
  zeitbezug <- rename_var(zeitbezug, 'Gruppe', 'group')
  zeitbezug <- rename_var(zeitbezug, 'RaumID', 'level')
  zeitbezug <- rename_var(zeitbezug, 'IndID', 'indicator')
  zeitbezug <- rename_var(zeitbezug, 'ZeitID', 'time')	
  if(is.null(time)==FALSE){
    zeitbezug <- zeitbezug[zeitbezug[,"time"] %in% time,]}
  
  i <- list(Gruppe=variable)
  
  s <- list(level=geography)
  
  param <- list(
    IndicatorCollection = list(i),
    TimeCollection = zeitbezug,
    SpaceCollection = list(s),
    pageorder = "1")
  
  r <- POST(url, body=param, encode = "json")
  
  if(status_code(r)==500){ 
    warning("The API returned an error. No data retrieved.")
    return(NULL)
  }

  jsondata <- fromJSON(content(r))[[1]]
  
  jsondata <- merge(jsondata, zeitbezug_, 
                    by.x=c("ID", "ZeitID"), 
                    by.y=c("IndID", "ZeitID"), 
                    all.y=TRUE)
  
  jsondata$ZeitID <- NULL
  jsondata$ID <- NULL
  
  return(jsondata)
}



