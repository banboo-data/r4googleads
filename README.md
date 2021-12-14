RGoogleAds
========================================================

## R client library for the Google Ads API

Welcome to the official documentation of the R software package **RGoogleAds** for Google Ads. **RGoogleAds** enables users of the R Language for Statistical Computing to directly access their Google Ads account in order to consume and analyze information provided by the Google Ads API.

The Google Ads API is the modern programmatic interface to Google Ads and the next generation of the AdWords API. It enables developers to interact directly with the Google Ads platform, vastly increasing the efficiency of managing large or complex Google Ads accounts and campaigns.

## Developed by the creators of RAdwords

**RGoogleAds** is R client library for the Google Ads API developed by [Matthias Bannert](https://github.com/mbannert) and [Johannes Burkhardt](https://github.com/jburkhardt), the creators of the **RAdwords** package.

## Scope of Functions

* Authorization with the Google Ads API
* List top-level Google Ads accounts
* Query Google Ads API reports with the Google Ads Query Language
* Load statistics, metrics and KPIs from Google Ads API including account, campaign, adgroup and keyword data
* Load data schema of Google Ads API reports including resource metadata, resource fields, segments and metrics

## Requirements

* Google Cloud Project (client ID, client secret)
* Google Ads MCC (my client center) account
* Google Ads API Developer Token

### Setup Google Cloud Project

How to setup a Google Cloud Project: [Google Cloud Project for Google Ads API](https://developers.google.com/google-ads/api/docs/first-call/oauth-cloud-project)

### Google Ads Developer Token

How to obtain a [Google Ads Developer Token](https://developers.google.com/google-ads/api/docs/first-call/dev-token)?

## Quickstart Guide

### Installation

```R
require(devtools)
install_github('banboo-data/RGoogleAds')
```

### Authentication

```R
library(RGoogleAds)
google_ads_auth <- authenticate()
```

### Load Data

```R
sql_query = "SELECT campaign.name, campaign.status,
             segments.device, metrics.impressions,
             metrics.clicks, metrics.ctr,
             metrics.average_cpc, metrics.cost_micros
             FROM campaign
             WHERE segments.date DURING LAST_30_DAYS
             AND metrics.impressions > 0
             PARAMETERS include_drafts=true"

query_service = googleAdsSearch(
  aid = '***-****-***', # Google Ads Account ID
  query = sql_query,
  api_version = 'v9'
  )

data <- query_google_ads(
  mcc_id = '***-***-****', # Google Ads My Client Center ID
  google_auth = google_ads_auth,
  service = query_service,
  raw_data = F
)
```

### Google Ads Query Language

In order to write your own SQL queries, Google provides a [Google Ads Query Language Builder](https://developers.google.com/google-ads/api/fields/v9/overview_query_builder). You find a list of available reports and you can validate the SQL queries.

### Explore Report Data Schema

```R
report_schema = googleAdsFields(
  tbl = "campaign", # e.g. campaign report
  api_version = 'v9'
  )

campaign_report_schema <- query_google_ads(
  mcc_id = '***-***-****', # Google Ads My Client Center ID
  google_auth = google_ads_auth,
  service = report_schema,
  raw_data = F
)
```

#### List Customers / Accounts

```R
list_customer_service <- listAccessibleCustomers(api_version = 'v9')

customers <- query_google_ads(
  mcc_id = '***-***-****', # Google Ads My Client Center ID
  google_auth = google_ads_auth,
  service = list_customer_service,
  raw_data = F
)
```

## Contribution and Package Extension

**RGoogleAds** makes use of the [REST interface](https://developers.google.com/google-ads/api/rest/overview) of the Google Ads API. For each REST resource / service of the Google Ads API we construct a S3 Class in `R/google_services_construtors.R`. This modular approach enables the extension of **RGoogleAds** service by service.

## Bug Reporting

Please make sure you run with the latest **RGoogleAds** version before you report any issues. If you are still in trouble, please report the issue on Github: [https://github.com/banboo-data/RGoogleAds/issues](https://github.com/banboo-data/RGoogleAds/issues)

We appreciate if you provide the following information along with the issue:

* Operating System
* R Version
* RGoogleAds version
* the R code which leads to the error
* the error message, prompt output
* code as text rather than screenshots
