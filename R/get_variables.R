#' Get Available Variables
#'
#' \code{get_variables} retrieves a data frame with available variables
#'
#' @param theme theme as character string 
#' @param geography geography as character string  
#'
#' @details 
#' To get a list of available geographies use \code{\link{get_geographies}}. To 
#' get a list of available themes use \code{\link{get_themes}}. 
#'     
#' @return a \code{data.frame} with columns \code{KurznamePlus} (variable name), \code{Bereich} (theme identifier), 
#' \code{Gruppe} (variable identifier), \code{BU}, \code{EU}, \code{Zeitreihe} (all three unknown).
#'
#' @seealso \code{\link{get_geographies}} \code{\link{get_themes}} 
#'
#' @examples 
#' 
#' # The SSL vertification seems to fail for some Linux systems. 
#' # This is likely because of a SSL certificate issue on the INKAR server. 
#' # Disabling SSL verification comes with risks: 
#' # https://curl.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html
#' httr::set_config(config(ssl_verifypeer = 0L))
#' 
#' # Retrieves list of available variables in the  
#' # theme "unemployment" for districts 
#' get_variables(theme="011", geography="KRE")
#' 
#' # Reset configuration  
#' httr::reset_config()
#' 
#' 
#' 
#' @export
get_variables <- function(theme,geography){

	if( length(geography)!=1 ) stop ("Can not retrieve variables for more than one theme at a time.")
	if( length(geography)!=1 ) stop ("Can not retrieve variables for more than one geography at a time.")

	url <- paste0(inkar_url, "/Wizard/GetIndikatorenZuBereich")

	p1 <- "{SpaceCollection:[{level:"
	p2 <- "}]}"

	p <- paste(p1,geography,p2,sep=intToUtf8(0x00A7))

	param <- list(
		bereichsID = theme,
		wiz = p)

	r <- POST(url, body=param, encode = "json")

	jsondata <- fromJSON(content(r))[[1]]

	return(jsondata)
	}

