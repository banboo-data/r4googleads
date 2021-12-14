#' Construct googleAdsSearch Class (S3)
#'
#' Create an instance of a googleAdsSearch class.
#' A list of Google's ads services can be found here:
#' \url{https://developers.google.com/google-ads/api/rest/reference/rest}.
#'
#' @param aid character Google account id
#' @param query character query string or function that returns a character query string. See also
#' \link[RGoogleAds]{queries}.
#'
#'
#' @export
googleAdsSearch <- function(aid, query = default_search()){
  # this makes both notations works, with and w/o '-'
  aid <- gsub("-", "", aid)
  l <- list(
    service_name = "googleAdsSearch",
    url = sprintf(
      "https://googleads.googleapis.com/v9/customers/%s/googleAds:searchStream",
      aid),
    query = query
  )
  attr(l, "class") <- "googleAdsSearch"
  l
}


#' Construct googleAdsFields Class (S3)
#'
#' Create an instance of a googleAdsFields class.
#' A list of Google's ads services and their arguments can be found here:
#' \url{https://developers.google.com/google-ads/api/rest/reference/rest/v9/googleAdsFields}.
#'
#' @param tbl character table argument
#'
#' @export
googleAdsFields <- function(tbl){
  l <- list(
    service_name = "googleAdsFields",
    url = sprintf(
      "https://googleads.googleapis.com/v9/googleAdsFields/%s",
      tbl
    )
  )
  attr(l, "class") <- "googleAdsFields"
  l
}

#' Construct listAccessibleCustomers Class (S3)
#'
#' Create an instance of a listAccessibleCustomers class.
#' \url{https://developers.google.com/google-ads/api/rest/reference/rest/v9/customers/listAccessibleCustomers}.
#'
#' @export
listAccessibleCustomers <- function(){
  l <- list(
    service_name = "listAccessibleCustomers",
    url = "https://googleads.googleapis.com/v9/customers:listAccessibleCustomers"
  )
  attr(l, "class") <- "listAccessibleCustomers"
  l
}
