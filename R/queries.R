#' Query Strings for Query Based Services
#'
#' A built-in collection of queries, mostly for the googleAdsSearch service: default_search(), ...
#' Usually these functions are not called stand alone. Often they are used when a constructor of
#' a query based service is called.
#' A Google Ads Query Builder can be found here: \url{https://developers.google.com/google-ads/api/fields/v9/overview_query_builder}
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
           WHERE segments.date DURING LAST_30_DAYS
           AND metrics.impressions > 0
           PARAMETERS include_drafts=true")
}
