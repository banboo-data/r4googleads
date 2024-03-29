extract_data <- function (x, raw_data) {
  UseMethod("extract_data", x)
}


extract_data.googleAdsSearchResult <- function(x, raw_data){

  if(raw_data) return(x)
  a <- fromJSON(rawToChar(x$content))

   if (x$status_code == "200") {
      df <- do.call("cbind",unlist(a$results, recursive = F))
      df
   } else {
     warning("an error occured.")
     a
   }

}


extract_data.googleAdsFieldsResult <- function(x, raw_data){

  if(raw_data) return(x)
  a <- fromJSON(rawToChar(x$content))
  a

}


extract_data.listAccessibleCustomersResult <- function(x, raw_data){

  if(raw_data) return(x)
  a <- fromJSON(rawToChar(x$content))
  a

}
