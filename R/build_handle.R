# Internal Generic to prepare curl request
# When extending the package to further services
# new service specific methods need to be added here.
# modifies the curl handle object

#' Prepare Curl Request
#'
#' Create

#' @param x object of class googleAdsSearch, googleAdsFields
#' listAccessibleCustomers
#'
#' @return curl dandle object
#'
#' @export
build_handle <- function (x) {
  UseMethod("build_handle", x)
}


# Build Handle Method for the googleAdsSearch class
# see also google_services_constructors.R
build_handle.googleAdsSearch <- function(x){
  statement <- sprintf('{"query" : "%s"}', x$query)
  h <- new_handle()
  handle_setopt(h, postfields = statement)
  h
}


# Build Handle Method for the googleAdsFields class
# see also google_services_constructors.R
build_handle.googleAdsFields <- function(x){
  new_handle()
}

# Build Handle Method for the listAccessibleCustomers class
# see also google_services_constructors.R
build_handle.listAccessibleCustomers <- function(x){
  new_handle()
}
