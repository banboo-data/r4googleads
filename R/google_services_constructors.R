#' Construct googleAdsSearch Class (S3)
#'
#' Create an instance of a googleAdsSearch class.
#' A list of Google's ads services can be found here:
#' \url{https://developers.google.com/google-ads/api/rest/reference/rest}.
#'
#' @param aid character Google account id
#' @param query character query string or function that returns a character query string. See also
#' \link[r4googleads]{queries}.
#' @param api_version Google Ads API version e.g 'v9'
#'
#' @export
googleAdsSearch <- function(aid, query = default_search(), api_version = 'v9'){
  # this makes both notations works, with and w/o '-'
  aid <- gsub("-", "", aid)
  l <- list(
    service_name = "googleAdsSearch",
    url = sprintf(
      "https://googleads.googleapis.com/%s/customers/%s/googleAds:searchStream",
      api_version,
      aid),
    query = query
  )
  attr(l, "class") <- "googleAdsSearch"
  l
}

#' @rdname r4googleads-deprecated
#' @export
statement <- function() {
  .Deprecated("googleAdsSearch")
  message("For more details on the Google's phase out of the Adwords API read our migration guide https://banboo-data.github.io/r4googleads")
}


#' Construct googleAdsFields Class (S3)
#'
#' Create an instance of a googleAdsFields class.
#' A list of Google's ads services and their arguments can be found here:
#' \url{https://developers.google.com/google-ads/api/rest/reference/rest/v9/googleAdsFields}.
#'
#' @param tbl character table argument
#' @param api_version Google Ads API version e.g 'v9'
#'
#' @export
googleAdsFields <- function(tbl, api_version = 'v9'){
  l <- list(
    service_name = "googleAdsFields",
    url = sprintf(
      "https://googleads.googleapis.com/%s/googleAdsFields/%s",
      api_version,
      tbl
    )
  )
  attr(l, "class") <- "googleAdsFields"
  l
}

#' Deprecated Function
#'
#' For more details on the Google's phase out of the Adwords API read our migration guide https://banboo-data.github.io/r4googleads
#' @rdname r4googleads-deprecated
#' @export
reports <- function(...) {
  .Deprecated("googleAdsFields")
  message("For more details on the Google's phase out of the Adwords API read our migration guide https://banboo-data.github.io/r4googleads")
}

#' @rdname r4googleads-deprecated
#' @export
metrics <- function(...) {
  .Deprecated("googleAdsFields")
  message("For more details on the Google's phase out of the Adwords API read our migration guide https://banboo-data.github.io/r4googleads")
}


#' Construct listAccessibleCustomers Class (S3)
#'
#' Create an instance of a listAccessibleCustomers class.
#' \url{https://developers.google.com/google-ads/api/rest/reference/rest/v9/customers/listAccessibleCustomers}.
#' @param api_version Google Ads API version e.g 'v9'
#'
#' @export
listAccessibleCustomers <- function(api_version = 'v9'){
  l <- list(
    service_name = "listAccessibleCustomers",
    url = sprintf(
      "https://googleads.googleapis.com/%s/customers:listAccessibleCustomers",
      api_version
    )
  )
  attr(l, "class") <- "listAccessibleCustomers"
  l
}
