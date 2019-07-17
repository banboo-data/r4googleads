#' @title Refresh Access Token
#' @description refresh_token returns a new valid access token. The access token deprecates after one hour and has to updated with the refresh token.
#' Usually you need not to run refresh_token() explicitly since the whole authentication process is managed by \code{\link{authenticate}}.
#' @param google_auth list of credentials and access token
#' @importFrom curl new_handle handle_setform curl_fetch_memory
#' @importFrom jsonlite fromJSON prettify
#' @return New access token with corresponding time stamp.
refresh_token <- function(google_auth) {
  # This function refreshes the access token. The access token deprecates after one hour and has to updated with the refresh token.
  #
  # Args:
  #   access.token$refreh_token and credentials as input
  # Returns:
  #   New access.token with corresponding time stamp
  h <- curl::new_handle()
  curl::handle_setform(h,
                       refresh_token = google_auth$access$refresh_token,
                       client_id = google_auth$credentials$c.id,
                       client_secret = google_auth$credentials$c.secret,
                       grant_type = "refresh_token",
                       style = "POST")
  req <- curl::curl_fetch_memory("https://accounts.google.com/o/oauth2/token", handle = h)
  a <- jsonlite::fromJSON(jsonlite::prettify(rawToChar(req$content)))
  a
}