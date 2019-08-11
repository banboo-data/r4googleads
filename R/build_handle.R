build_handle <- function (x) {
  UseMethod("build_handle", x)
}


build_handle.googleAdsSearch <- function(x){
  statement <- sprintf('{"query" : "%s"}', x$query)
  h <- new_handle()
  handle_setopt(h, postfields = statement)
  h
}


build_handle.googleAdsFields <- function(x){
  new_handle()
}
