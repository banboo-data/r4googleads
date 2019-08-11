SELECT
  ad_group.id,
  ad_group_ad.ad.id,
  ad_group_ad.ad.expanded_text_ad.headline_part1,
  ad_group_ad.ad.expanded_text_ad.headline_part2,
  ad_group_ad.status
FROM ad_group_ad
WHERE ad_group_ad.ad.type = EXPANDED_TEXT_AD