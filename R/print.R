# Print Methods for S3 Classes in this package
# not anything spectacular. This is one of
# few cases where to code speaks for itself.
# definitely no further documentation needed.
# If you feel otherwise, drop us an issue
# on github: https://github.com/rstats-lab/RGoogleAds/issues.
print.googleAdsSearch <- function(x){
  cat(x$query)
}
