#' Construct googleAdsSearch Class (S3)
#'
#' Create an instance of a googleAdsSearch class.
#'
#' @param aid character Google account id
#' @param query character query string or function that returns a character query string. See also
#' \link[RGoogleAds]{queries}.
#'
#' @rdname services
#' @export
googleAdsSearch <- function(aid, query = default_search()){
  # this makes both notations works, with and w/o '-'
  aid <- gsub("-", "", aid)
  l <- list(
    service_name = "googleAdsSearch",
    url = sprintf(
      "https://googleads.googleapis.com/v2/customers/%s/googleAds:search",
      aid),
    query = query
  )
  attr(l, "class") <- "googleAdsSearch"
  l
}


#' @rdname services
#' @export
googleAdsFields <- function(tbl){
  l <- list(
    service_name = "googleAdsFields",
    url = sprintf(
      "https://googleads.googleapis.com/v2/googleAdsFields/%s",
      tbl
    )
  )
  attr(l, "class") <- "googleAdsFields"
  l
}


