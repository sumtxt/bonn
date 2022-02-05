#' Get Metadata for a Variable
#'
#' \code{get_metadata} retrieves the metadata for a single variable
#' 
#' @param variable variable identifier as character string
#'
#' @details 
#' To get a list of available variables use \code{\link{get_variables}}. 
#'     
#' @return a \code{data.frame} with columns \code{Name} (variable name), \code{Kurzname} (short name), 
#' \code{Algorithmus} (information on measurement), \code{Quelle} (source) and \code{Anmerkungen} (notes).
#'
#' @seealso \code{\link{get_variables}} \code{\link{get_data}} 
#'
#' @examples 
#' 
#' 	# Metadata for GDP variable
#'  get_metadata("010")
#' 
#' 
#' 
#' 
#' @export
get_metadata <- function(variable){

	if( length(variable)!=1 ) stop ("Can not retrieve metadata for more than one variable at a time.")

	url <- paste0(inkar_url, "/Wizard/GetIndikatorInfo/")
	url <- paste(url, variable, sep="")

	r <- GET(url)

	jsondata <- fromJSON(content(r))[[1]]

	return(jsondata)
	}

