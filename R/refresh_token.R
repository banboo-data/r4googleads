#' @title Refresh Access Token
#' @description refresh_token returns a new valid access token. The access token deprecates after one hour and has to updated with the refresh token.
#' Usually you need not to run refresh_token() explicitly since the whole authentication process is managed by \code{\link{authenticate}}.
#' @param google_auth list of credentials and access token
#' @return New access token with corresponding time stamp.
refresh_token <- function(google_auth) {
  # This function refreshes the access token. The access token deprecates after one hour and has to updated with the refresh token.
  #
  # Args:
  #   access.token$refreh_token and credentials as input
  # Returns:
  #   New access.token with corresponding time stamp
  raw_data <- RCurl::postForm("https://accounts.google.com/o/oauth2/token",
    refresh_token = google_auth$access$refresh_token,
    client_id = google_auth$credentials$c.id,
    client_secret = google_auth$credentials$c.secret,
    grant_type = "refresh_token",
    style = "POST",
    .opts = list(ssl.verifypeer = FALSE)
  ) # Fix SSL Certificate problem on Windows
  if (is.raw(raw_data)) {
    rt <- rjson::fromJSON(rawToChar(raw_data))
  } else {
    rt <- rjson::fromJSON(raw_data)
  }
  access <- rt
  access
}