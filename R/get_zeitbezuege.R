get_zeitbezuege <- function(raumbezug, variable){

	if (is.null(raumbezug) | is.null(variable)) stop()

	url <- paste0(inkar_url, "/Wizard/GetM%C3%B6glich")

	raumbezug <- list(level=raumbezug)
	variable <- list(Gruppe=variable)

	param <- list(
		IndicatorCollection = list(variable),
		TimeCollection = "",
		SpaceCollection = list(raumbezug))

	r <- POST(url, body=param, encode = "json")

	jsondata <- fromJSON(content(r))

	jsondata <- rbind(jsondata[[1]], 
				make.row.names=FALSE,
	      stringsAsFactors=FALSE)

	return(jsondata)
	}



