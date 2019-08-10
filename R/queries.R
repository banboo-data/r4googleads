#' @export
default_search <- function() {
  sprintf("SELECT campaign.name, campaign.status, segments.device,
           metrics.impressions, metrics.clicks, metrics.ctr,
           metrics.average_cpc, metrics.cost_micros
           FROM campaign
           WHERE segments.date DURING LAST_30_DAYS")
}
