SELECT campaign.id,
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
LIMIT 50