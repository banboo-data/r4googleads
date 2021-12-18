r4googleads -<br> Load Google Ads Data Into Your R Session
==========================================================

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/r4googleads)](https://CRAN.R-project.org/package=r4googleads)
[![CRAN monthly downloads](https://cranlogs.r-pkg.org/badges/r4googleads)](https://cran.r-project.org/package=r4googleads)
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->


Welcome to the official documentation of the R {**r4googleads**} software package!
{**r4googleads**} enables users of the R Project for Statistical Computing to smoothly access their Google Ads account to load and analyze information provided by the Google Ads API.

The Ads API is Google's modern application programming interface (API) to its Ads platform and the next generation of the AdWords API. The Ads API enables Google Ads customers to interact with Google's advertising platform using a programming language. Implement your advertising performance analytics in R and increase your efficiency, make your reports reproducible and flexible enough to managing even large, complex Google Ads accounts and campaigns.

## Developed by the Creators of RAdwords

{**r4googleads**} is the leading R client library for the Google Ads API developed by [Matthias Bannert](https://github.com/mbannert) and [Johannes Burkhardt](https://github.com/jburkhardt). Since 2014, the duo has developed and maintained **RAdwords**, the #1 R client library for Google's predecessor Adwords API. That's 66K+ downloads and, more importantly, *7* years of experience and reliable maintenance of an open source package. 

Let's move on to the all new {**r4googleads**} ! (check our migration guide!)

## Why {**r4googleads**} ? 

**Connect** your Google Ads reports to the R Language for Statistical Computing. Unlock the next level of campaign and marketing performance analytics -> Learn how to **analyze** Google Ads statistics and Key Performance Indicators (KPIs) using a license cost freeeee open source programming language. **Automate** your reports on accounts, campaigns, adgroups and keywords data reliably.

* authenticate with the Google Ads API
* light dependencies on other R packages for stable long term production 
* List top-level Google Ads accounts
* query Google Ads API reports with the Google Ads Query Language
* Load statistics, metrics and KPIs from Google Ads API including account, campaign, adgroup and keyword data
* Load data schema of Google Ads API reports including resource metadata, resource fields, segments and metrics

## What Does {**r4googleads**} Not Do? 

- the package does not sign you up @Google (you need an existing acocunt) 
- the package does not implement statistical methods. (the R language is second to none when it comes the amount of methodological extension packages. Pick your methods for statistical analysis from more than 18K extension packages. ) 

<!-- 
Add some link to our paid info content here (help with choice of methods statistical analysis)


-->


## Quick Start Guide

### Requirements 

This guide assumes you have set up a working Google Ads API *Developer Token* and a *Google Cloud Project*. 
If you are starting from scratch or have trouble wrapping your head around Google's complex portfolio, stay tuned for 
our ultimate guide dropping in Spring 2022 !

<!--
* Google Cloud Project (client ID, client secret)
* Google Ads MCC (my client center) account
* Google Ads API Developer Token

### Setup Google Cloud Project

How to setup a Google Cloud Project: [Google Cloud Project for Google Ads API](https://developers.google.com/google-ads/api/docs/first-call/oauth-cloud-project)

### Google Ads Developer Token

How to obtain a [Google Ads Developer Token](https://developers.google.com/google-ads/api/docs/first-call/dev-token)?


 -->


### R Package Installation Notes

Install the latest stable version of {**r4googleads**} from R's official Comprehensive R Archive Network (CRAN) or 

```r{eval=FALSE,message=FALSE, warning=FALSE}
install.packages("r4googleads")
```

install the latest development release from GitHub using the [{remotes}](https://cran.r-project.org/web/packages/remotes/index.html) R package. 
(the below example code assumes the {remotes} package is installed.)

```R
remotes::install_github("banboo-data/r4googleads")
```


### Authentication

Ok, once {**r4googleads**} is installed, the stage is set (Google accounts are set up and dev tokens are available, too) and the air is clear, start to authenticate at Google's servers. 

```R
library(r4googleads)
google_auth <- authenticate()
```

This will start an interactive 1-2-3 process:

1. Spin up your default web browser and display Google's login form
2. login using your credentials
3. receive a token that's kept in your session (*google_auth variable*) and stored in an .RData file 

congrats, you are ready to load data into your R session! 

### Load Data

To specify which data data you want to load into your R session you can use Google's own [SQL reminiscant query language](https://developers.google.com/google-ads/api/fields/v9/overview_query_builder). Visit the link to find out about available reports and validate your queries online.

```R
g_query <- "SELECT
                campaign.name, 
                campaign.status,
                segments.device, 
                metrics.impressions,
                metrics.clicks, 
                metrics.ctr,
                metrics.average_cpc, 
                metrics.cost_micros
              FROM campaign
              WHERE segments.date DURING LAST_30_DAYS
              AND metrics.impressions > 0
              PARAMETERS include_drafts=true"
```

The next step is to create a *service object* that contains the query string, your Google Ads Account ID and the API version
you want to use. The example uses one of our 3 constructors to create different service objects: *googleAdsSearch*, *googleAdsFields*,
*listAccessibleCustomers*. 

```R
query_service <- googleAdsSearch(
  aid = '***-****-***', # Google Ads Account ID
  query = sql_query,
  api_version = 'v9'
  )
```

the resulting service query object can be passed on to the *query_google_ads* functions which sends the service object to Google's actual 
API service. Note, that a *MCC* ID is needed here. The handler inside *query_google_ads* processes the service object depending on its class and starts the corresponding request. 

```R
data <- query_google_ads(
  mcc_id = '***-***-****', # Google Ads My Client Center ID
  google_auth = google_auth,
  service = query_service,
  raw_data = F
)
```


Display the data object right here. For more advanced usage such as Report Schemas, Listing Customer of Contributing to the package, please 
refer to the developer guide.... 








