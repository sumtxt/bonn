#' Merge Data 
#'
#' \code{merge_data} retrieves a data frame with all available values for a variable
#'
#' @param variable variable identifier as vector of character strings
#' @param geography geography identifier as character string 
#' @param zeit time identifier as vector of character strings
#'
#' @details 
#' To get a list of available geographies use \code{\link{get_geographies}}. To 
#' get a list of available variables use \code{\link{get_variables}}. 
#' 
#' The function retrieves all values for all available years by default. 
#' 
#' Note that the variables need to be available on the same geographic unit.
#'     
#' @return a \code{data.frame} with columns \code{Schlüssel} (unit identifier), 
#' \code{Raumbezug} (geography identifier),  
#' \code{variable1}, ..., \code{variableN} (variable indicators) and \code{Zeit} (year or time period). 
#'
#' @seealso \code{\link{get_geographies}} \code{\link{get_variables}} \code{\link{get_metadata}} \code{\link{get_data}}
#'
#' @examples 
#' 
#' 	# Matrix of indicators 11,12,13 on "Kreis" level
#'  variables <- c("11", "12", "13")
#'  merge_data(variables, geography )
#' 
#' 
#' 
#' 
#' 
#' @export

merge_data <- function(variable,geography, zeit=NULL){
  if( length(geography)!=1 ) stop ("Can not retrieve data for more than one geography at a time.")
  
  data <- list()
  nvars <- length(variable)
  for (i in 1:nvars){
  data[[i]] <- get_data(variable=variable[i], geography="KRE", zeit) 
  colnames(data[[i]])[4] <- get_metadata(data[[i]][1,3])["Kurzname"]
  data[[i]] <- data[[i]][,-c(2,3)]
  }
  
  merged_data <- Reduce(function(x, y) merge(x, y, by = c("Schlüssel", "Zeit"), all=TRUE), data)
  merged_data <- cbind( rep(geography, nrow(merged_data)),merged_data)
  colnames(merged_data)[1] <- "Raumbezug"
  
  
  
  return(merged_data)
}