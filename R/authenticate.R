#' @title Invoke the Authentication Process with Google
#' @description This function starts the authentication process with Google.
#' Note that this function needs user interaction.
#' @param save logical denotes whether authentication information should be saved on disk. Defaults to TRUE.
#' @return Dataframe with the credential information which is cached in working space
#   and optionally saved as RData file in current working directory.
#' @export
authenticate <- function(save = T) {
  # do user interaction to store credentials in list
  # does not expire
  if (file.exists(".google.auth.RData")) {
    load(".google.auth.RData")
  } else {
    credentials <- get_credentials()
    access_token <- load_token(credentials)
    # credentials can be saved in workspace
    # for use with cron jobs etc
    google_auth <- list()
    google_auth$credentials <- credentials
    google_auth$access <- access_token

    if (save) {
      save("google_auth", file = ".google.auth.RData")

      # make sure your credentials are ignored by svn and git ####
      if (!file.exists(".gitignore")) {
        cat(".google.auth.RData", file = ".gitignore", sep = "\n")
      }
      if (file.exists(".gitignore")) {
        suppressWarnings(gitignore <- paste(readLines(".gitignore"), collapse = " "))
        if(!grepl(".google.auth.RData", gitignore)) {
          cat(".google.auth.RData", file = ".gitignore",
              append = TRUE)
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