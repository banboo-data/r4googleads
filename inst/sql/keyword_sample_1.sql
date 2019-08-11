SELECT
    ad_group_criterion.keyword.text,
    ad_group.name,
    campaign.name,
    metrics.impressions,
    metrics.clicks,
    metrics.ctr,
    metrics.average_cpc
FROM keyword_view
WHERE segments.date DURING LAST_30_DAYS