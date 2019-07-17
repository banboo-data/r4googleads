#' @title Loading the Access Token
#' @description load_token loads the access token using credentials provided by \code{\link{get_credentials}}. Execution of function is possible only once per authentication process.
#' Usually you need not to run load_token() explicitly since the whole authentication process is managed by \code{\link{authenticate}}.
#' @param credlist list of credentials
#' @importFrom curl new_handle handle_setform curl_fetch_memory
#' @importFrom jsonlite fromJSON
#' @return Access token with corresponding time stamp.
load_token <- function(credlist) {
  # This function loads the access token using credentials from get_credentials(). Execution of function is only possible once.
  #
  # Args:
  #   None - credentials as input.
  #
  # Returns:
  #   access.token with corresponding time stamp
  h <- curl::new_handle()
  curl::handle_setform(h,
                       code = credlist$c.token,
                       client_id = credlist$c.id,
                       client_secret = credlist$c.secret,
                       redirect_uri = "urn:ietf:wg:oauth:2.0:oob",
                       grant_type = "authorization_code",
                       style = "POST")

  req <- curl::curl_fetch_memory("https://accounts.google.com/o/oauth2/token", handle = h)

  a <- jsonlite::fromJSON(rawToChar(req$content))

  if (length(a) == 1) {
    print("You need to update the token - run authenticate()")
  } else {
    a$timeStamp <- as.numeric(Sys.time())
  }

  a
}