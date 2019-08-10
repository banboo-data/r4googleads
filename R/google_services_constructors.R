#' constructor for Search Class
#' @export
googleAdsSearch <- function(aid, query = default_search()){
  l <- list(
    url = sprintf(
      "https://googleads.googleapis.com/v2/customers/%s/googleAds:search",
      aid),
    query = query
  )
  attr(l, "class") <- "googleAdsSearch"
  l
}


#' @export
googleAdsFields <- function(tbl){
  l <- list(
    url = sprintf(
      "https://googleads.googleapis.com/v2/googleAdsFields/%s",
      tbl
    )
  )
  attr(l, "class") <- "googleAdsFields"
  l
}



xx <- googleAdsSearch("123")
build_handle(xx)
