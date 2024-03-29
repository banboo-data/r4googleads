#' Query 'Google Ads' Data
#'
#' Sends 'Google Ads' Services objects to the 'Google Ads API'.
#'
#'
#' @param mcc_id Google Ads Client Center MCC Id
#' @param google_auth auth object
#' @param service googleAds service object created by a service constructor such as \code{\link{googleAdsSearch}} or \code{\link{googleAdsFields}}.
#' @param raw_data TRUE / FALSE returns raw data or content only
#' @param convert_micros converts micros data: divides data by 1e6, if NULL no conversion will be applied.
#'
#' @return Google Services return object either with raw or processed data (default).
#'
#' @importFrom curl new_handle handle_setheaders handle_setopt curl_fetch_memory
#' @importFrom jsonlite fromJSON
#'
#' @export
query_google_ads <- function(mcc_id,
                             google_auth,
                             service,
                             raw_data = FALSE,
                             convert_micros = 1e6
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
  class(req) <- append(class(req), paste0(service$service_name, "Result"))

  df <- extract_data(req, raw_data)
  df[,grepl("metrics.", names(df))] <- sapply(df[,grepl("metrics.", names(df))], as.numeric)
  if(!is.null(convert_micros)){df[,grepl("Micros|Cpc", names(df))] <- sapply(df[,grepl("Micros|Cpc", names(df))], function(x){x/convert_micros})}
  df
}


#' @rdname r4googleads-deprecated
#' @return message with deprecation notice
#' @export
get_data <- function(...) {
  .Deprecated("query_google_ads")
  message("For more details on the phase out of the Google Adwords API read our migration guide https://banboo-data.github.io/r4googleads/")
}
