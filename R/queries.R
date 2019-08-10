#' Query Strings for Query Based Services
#'
#' A built-in collection of queries, mostly fot the googleAdsSearch service: default_search(), ...
#' Usually these functions are not called stand alone. Often they are used when a constructor of a query based service is called.
#'
#' @return character query statement
#' @rdname queries
#' @export
default_search <- function() {
  sprintf("SELECT campaign.name, campaign.status,
           segments.device, metrics.impressions,
           metrics.clicks, metrics.ctr,
           metrics.average_cpc, metrics.cost_micros
           FROM campaign
           WHERE segments.date DURING LAST_30_DAYS")
}
