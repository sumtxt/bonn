inkar_url <- "https://www.inkar.de"

rename_var <- function(df, old_name, new_name){
	names(df)[names(df)==old_name] <- new_name
	return(df)
	}
