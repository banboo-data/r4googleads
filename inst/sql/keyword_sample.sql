SELECT campaign.id,
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
LIMIT 50