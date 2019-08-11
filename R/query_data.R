#' Query Google Ads Data
#'
#' Sends Google Ads Services objects to the Google Ads API.
#'
#'
#' @param mcc_id Google Ads Client Center MCC Id
#' @param google_auth auth object
#' @param service googleAds service object created by a service constructor such as \code{\link{googleAdsSearch}} or \code{\link{googleAdsFields}}.
#'
#' @return Google Services return object either with raw or processed data (default).
#'
#' @importFrom curl new_handle handle_setheaders handle_setopt curl_fetch_memory
#' @importFrom jsonlite fromJSON
#'
#' @export
query_google_ads <- function(mcc_id,
                             google_auth,
                             service
                             ) {

  access <- google_auth$access
  credlist <- google_auth$credentials

  if (as.numeric(Sys.time()) - 3600 >= access$timeStamp) {
    access <- .refresh_token(google_auth)
  }


  mcc_id <- gsub("-", "", mcc_id)
  google.auth <- paste(access$token_type, access$access_token)

  h <- build_handle(service)

  handle_setheaders(h,
    "Host" = "googleads.googleapis.com",
    "User-Agent" = "curl",
    "Content-Type" = "application/json",
    "Accept" = "application/json",
    "Authorization" = google.auth,
    "developer-token" = credlist$auth.developerToken,
    "login-customer-id" = mcc_id
  )

  req <- curl_fetch_memory(service$url, handle = h)

  a <- fromJSON(rawToChar(req$content))

  if (req$status_code == "200") {
    a$results
  } else {
    cat("an error occured.")
    a
  }
}