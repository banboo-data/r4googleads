SELECT campaign.id,
       ad_group.id,
       metrics.impressions,
       metrics.clicks,
       metrics.cost_micros
FROM ad_group
WHERE segments.date DURING LAST_7_DAYS