#' Invoke the Authentication Process with Google
#'
#' This function starts the authentication process with
#' Google. Note that this function needs user interaction.
#'
#' @param save logical, should the authentication information should be saved on disk? Defaults to TRUE.
#'
#' @return data.frame containing credentials, optionally saved as .RData in the current working directory
#'
#' @export
authenticate <- function(save = T) {
  # do user interaction to store credentials in list
  # does not expire
  if (file.exists(".google.auth.RData")) {
    load(".google.auth.RData")
  } else {
    credentials <- .get_credentials()
    access_token <- .load_token(credentials)
    # credentials can be saved in workspace
    # for use with cron jobs etc
    google_auth <- list()
    google_auth$credentials <- credentials
    google_auth$access <- access_token

    if (save) {
      save("google_auth", file = ".google.auth.RData")
      # make sure your credentials are
      # ignored by svn and git
      if (!file.exists(".gitignore")) {
        cat(".google.auth.RData",
          file = ".gitignore",
          sep = "\n"
        )
      }
      if (file.exists(".gitignore")) {
        gitignore <- readLines(".gitignore")
        if (!is.element(".google.auth.RData", gitignore)) {
          cat(".google.auth.RData",
            file = ".gitignore",
            append = TRUE, fill = TRUE
          )
        }
      }
    }
  }
  if (exists("google_auth")) {
    google_auth
  } else {
    cat("an error occurred.")
  }
}

#' Deprecated Function
#'
#' For more details on the Google's phase out of the Adwords API read our migration guide https://banboo-data.github.io/r4googleads
#' @param ... arguments to to be passed on to the underlying functions. (note that this functions is deprecated, use authenticate().)
#' @rdname r4googleads-deprecated
#' @export
do_auth <- function(...) {
  .Deprecated("authenticate")
  message("For more details on the Google's phase out of the Adwords API read our migration guide https://banboo-data.github.io/r4googleads")
}
