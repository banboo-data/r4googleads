#' Query Strings for Query Based Services
#'
#' A built-in collection of queries, mostly for the googleAdsSearch service: default_search(), campaign_sample(),
#' adgroup_sample(), adgroup_sample_1(), hotel_ads_sample(), keyword_sample(), keyword_sample_1(), keyword_sample_2().
#' Usually these functions are not called stand alone. Often they are used when a constructor of
#' a query based service is called. A 'Google Ads Query Builder' can be found here: \url{https://developers.google.com/google-ads/api/fields/v9/overview_query_builder}
#'
#' @return character query statement
#' @rdname queries
#' @export
#' @examples
#' default_search()
#' campaign_sample()
#' adgroup_sample()
#' adgroup_sample_1()
#' hotel_ads_sample()
#' keyword_sample()
#' keyword_sample_1()
#' keyword_sample_2()
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

#' @rdname queries
#' @export
campaign_sample <- function() {
  sprintf("SELECT campaign.name,
          campaign.status,
          segments.device,
          metrics.impressions,
          metrics.clicks,
          metrics.ctr,
          metrics.average_cpc,
          metrics.cost_micros
          FROM campaign
          WHERE segments.date DURING LAST_30_DAYS")
}

#' @rdname queries
#' @export
adgroup_sample <- function()  {
  sprintf("SELECT campaign.id,
          campaign.name,
          ad_group.id,
          ad_group.name,
          metrics.impressions,
          metrics.clicks,
          metrics.cost_micros
          FROM ad_group
          WHERE segments.date DURING LAST_7_DAYS")
}

#' @rdname queries
#' @export
adgroup_sample_1 <- function()  {
  sprintf("SELECT ad_group.id,
           ad_group_ad.ad.id,
           ad_group_ad.ad.expanded_text_ad.headline_part1,
           ad_group_ad.ad.expanded_text_ad.headline_part2,
           ad_group_ad.status
           FROM ad_group_ad
           WHERE ad_group_ad.ad.type = EXPANDED_TEXT_AD")
}

#' @rdname queries
#' @export
hotel_ads_sample <- function()  {
  sprintf("SELECT campaign.id,
          campaign.advertising_channel_type,
          ad_group.id,
          ad_group.status,
          metrics.impressions,
          metrics.hotel_average_lead_value_micros,
          segments.hotel_check_in_day_of_week,
          segments.hotel_length_of_stay
          FROM hotel_performance_view
          WHERE segments.date DURING LAST_7_DAYS
          AND campaign.advertising_channel_type = 'HOTEL'
          AND ad_group.status = 'ENABLED'
          ORDER BY metrics.impressions DESC
          LIMIT 50")
}

#' @rdname queries
#' @export
keyword_sample <- function()  {
  sprintf("SELECT campaign.id,
          campaign.name,
          ad_group.id,
          ad_group.name,
          ad_group_criterion.criterion_id,
          ad_group_criterion.keyword.text,
          ad_group_criterion.keyword.match_type,
          metrics.impressions,
          metrics.clicks,
          metrics.cost_micros
          FROM keyword_view
          WHERE segments.date DURING LAST_7_DAYS
          AND campaign.advertising_channel_type = 'SEARCH'
          AND ad_group.status = 'ENABLED'
          AND ad_group_criterion.status IN ('ENABLED', 'PAUSED')
          ORDER BY metrics.impressions DESC
          LIMIT 50")
}

#' @rdname queries
#' @export
keyword_sample_1 <- function()  {
  sprintf("SELECT
          ad_group_criterion.keyword.text,
          ad_group.name,
          campaign.name,
          metrics.impressions,
          metrics.clicks,
          metrics.ctr,
          metrics.average_cpc
          FROM keyword_view
          WHERE segments.date DURING LAST_30_DAYS")
}

#' @rdname queries
#' @export
keyword_sample_2 <- function()  {
  sprintf("SELECT
              ad_group.id,
              ad_group_criterion.type,
              ad_group_criterion.criterion_id,
              ad_group_criterion.keyword.text,
              ad_group_criterion.keyword.match_type
          FROM ad_group_criterion
          WHERE ad_group_criterion.type = KEYWORD")
}
