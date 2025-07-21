#' Get Available Themes
#'
#' \code{get_themes} retrieves a data frame with all available themes
#' 
#' @param geography geography as character string  
#'
#' @details 
#' To get a list of available geographies use \code{\link{get_geographies}}. 
#'     
#' @return a \code{data.frame} with columns \code{ID} (theme identifier), \code{Bereich} (theme name)
#' and \code{Unterbereich} (sub-theme name).
#'
#' @seealso \code{\link{get_geographies}} 
#'
#' @examples 
#' 
#' # The SSL vertification seems to fail for some Linux systems. 
#' # This is likely because of a SSL certificate issue on the INKAR server. 
#' # Disabling SSL verification comes with risks: 
#' # https://curl.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html
#' httr::set_config(httr::config(ssl_verifypeer = 0L))
#' 
#' # Available themes  
#' get_themes("KRE")
#' 
#' # Reset configuration  
#' httr::reset_config()
#' 
#' 
#' 
#' @export
get_themes <- function(geography){

	if( length(geography)!=1 ) stop ("Can not retrieve data for more than one geography at a time.")

	url <- paste0(inkar_url, "/Wizard/GetBereiche")

	param <- list(SpaceCollection = list(list(level=geography)))

	r <- POST(url, body=param, encode = "json")

	jsondata <- fromJSON(content(r))[[1]]

	return(jsondata)
	}