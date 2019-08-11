SELECT campaign.id,
       campaign.name,
       ad_group.id,
       ad_group.name,
       metrics.impressions,
       metrics.clicks,
       metrics.cost_micros
FROM ad_group
WHERE segments.date DURING LAST_7_DAYS