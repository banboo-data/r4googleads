#' @title Query Google Ads Data
#' @description Queries data from Google Ads API.
#' @param mcc_id Google Ads Client Center MCC Id
#' @param google_auth auth object
#' @param query Google Ads query
#' @importFrom curl new_handle handle_setheaders handle_setopt curl_fetch_memory
#' @importFrom jsonlite fromJSON
#' @return Dataframe
#' @export
query_google_ads <- function(mcc_id,
                             google_auth,
                             service
                             ) {
  if (is.function(query)) {
    query <- query()
  } else if (is.character(query)) {
    query <- query
  } else {
    stop("Either choose a query constructor function or pass a fully customized SQL string.")
  }

  access <- google_auth$access
  credlist <- google_auth$credentials

  if (as.numeric(Sys.time()) - 3600 >= access$timeStamp) {
    access <- refresh_token(google_auth)
  }

  account_id <- gsub("-", "", account_id)
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

  req <- curl_fetch_memory(url, handle = h)

  a <- fromJSON(rawToChar(req$content))

  if (req$status_code == "200") {
    a$results
  } else {
    cat("an error occured.")
    a
  }
}