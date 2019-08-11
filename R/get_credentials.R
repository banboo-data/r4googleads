#' @title Authentication of R app
#' @description get_credentials authenticates the R app at the
#' Google authentication server using OAUTH2 and receives the client token.
#' Usually you need not to run get_credentials() explicitly since the whole authentication process is managed by \code{\link{authenticate}}.
#' @importFrom utils browseURL
#' @return Client token from Google authentication server.
get_credentials <- function() {
  # This function asks for the credentials
  # (Client Id, Client Secret) from the Api project,
  # the developer token from the Google Ads MCC and
  # retrieves the client token from the Google authentication server.
  # Moreover credentials optionally can be saved to the current working directory and .gitignore is generated for credentials.
  #
  # Inputs:
  #   Client Id from Google Api project.
  #   Client secret from Google Api project.
  #   Developer token from Google Ads MCC.
  #
  # Returns:
  #   Client token from Google authentication server.
  if (!exists("credentials")) {
    cat("Authentication process needs your Client ID
        from the Google Ads API project for native apps.")
    c.id <- readline(as.character(cat(
      "\n\nPaste the Client ID here",
      ":=>"
    )))
    if (c.id == "") {
      return(print("You have to provide a Client ID
                   from the Google Ads API Project for native apps."))
    }
    else {
      credentials <- data.frame(c.id, stringsAsFactors = F)
      cat("Authentication process needs your Client
          secret from the Google Ads API project.")
      credentials$c.secret <-
        readline(as.character(cat(
          "\n\nPaste the Client secret here",
          ":=>"
        )))
      cat("Authentication process needs your
          Developer Token from the Google Ads MCC.")
      credentials$auth.developerToken <-
        readline(as.character(cat(
          "\n\nPaste the Developer Token here",
          ":=>"
        )))
    }
  }

  if (exists("credentials")) {
    url <- sprintf(
      "https://accounts.google.com/o/oauth2/auth?client_id=%s&response_type=code&scope=https://www.googleapis.com/auth/adwords&redirect_uri=urn:ietf:wg:oauth:2.0:oob&access_type=offline&approval_prompt=force",
      credentials$c.id
    )
    browseURL(url)
    # Manual next-step: input code-parameter
    # to c.token variable and run load_token()
    cat("Authentication process needs your Client
        token in order to receive the access token
        from the API. Copy the Client token from
        your webbrowser and paste it here.")
    credentials$c.token <- readline(as.character(cat(
      "\n\nPaste the client token here",
      ":=>"
    )))
  }
  # return one environment that contains all the values...
  credentials
}
