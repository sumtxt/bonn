#' Get Available Geographies 
#'
#' \code{get_geographies} either retrieves a data frame with all available geographies or all existing units for a given geography 
#'
#' @param geography geography as string or \code{NULL} 
#'     
#' @return a \code{data.frame} either with the columns \code{Kurzname} (geography name), \code{ID} (geography identifier) 
#' and \code{NGeb} (number of units) or with the columns \code{Schlüssel} (unit identifier) and \code{Name} (unit name).
#'
#' @examples 
#' 
#'  # Available geographies  
#'  get_geographies()
#' 
#' 	# All districts 
#' 	get_geographies("KRS")
#' 
#' 
#' 
#' @export
get_geographies <- function(geography=NULL){

	if( is.null(geography)  ) {

		url <- paste0(inkar_url, "/Wizard/GetRaumbezuege")

		param <- list(
			IndicatorCollection = "",
			TimeCollection = "",
			SpaceCollection = "",
			Title = "",
			pageorder = "", 
			currentpage = "1",
			modified = "")

		r <- POST(url, body=param, encode = "json")

		jsondata <- fromJSON(content(r))[[1]][,c("Kurzname", "ID", "NGeb")]


	} else { 

		url <- paste0(inkar_url, "/Wizard/GetGebieteZumRaumbezug/")
		url <- paste(url, geography, sep="")

		r <- GET(url)

		jsondata <- fromJSON(content(r))[[1]]

	}

	return(jsondata)

	}
