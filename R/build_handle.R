# Internal Generic to prepare curl request
# When extending the package to further services
# new service specific methods need to be added here.
# modifies the curl handle object
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
