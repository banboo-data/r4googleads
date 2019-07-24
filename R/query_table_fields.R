#' @title Query Google Ads Fields Service
#' @description Queries table information from Google Ads Fields Service.
#' @param account_id Google Ads Account ID
#' @param mcc_id Google Ads Client Center MCC Id
#' @param google_auth auth object
#' @param table Google Ads report tables
#' @importFrom curl new_handle handle_setheaders handle_setopt curl_fetch_memory
#' @importFrom jsonlite fromJSON
#' @return List with field information of resource table
query_table_fields <- function(account_id,
                               mcc_id,
                               google_auth,
                               table = "campaign"){

  access <- google_auth$access
  credlist <- google_auth$credentials

  if(as.numeric(Sys.time())-3600 >= access$timeStamp){
    access <- refresh_token(google_auth)
  }

  account_id <- gsub("-", "", account_id)
  mcc_id <- gsub("-", "", mcc_id)
  google.auth <- paste(access$token_type, access$access_token)

  table <- tolower(gsub(" ", "_", table))

  url <- sprintf("https://googleads.googleapis.com/v2/googleAdsFields/%s", table)

  h <- new_handle()
  handle_setheaders(h,
                    "Host" = "googleads.googleapis.com",
                    "User-Agent" = "curl",
                    "Content-Type" = "application/json",
                    "Accept" = "application/json",
                    "Authorization" = google.auth,
                    "developer-token" = credlist$auth.developerToken,
                    "login-customer-id" = mcc_id
  )
  req <- curl_fetch_memory(url,
                           handle = h)

  a <- fromJSON(rawToChar(req$content))

  a
}