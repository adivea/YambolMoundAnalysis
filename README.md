# Yambol Mound Analysis

this repository contains the processing scripts, visualisation and bootstrapped analysis of Yambol mound data aggregate from years 2009-2022. This analysis serves as a baseline for the comparison of burial mound locational choices with other regions or among subsets. 

## Script guide:

* 00a - loads the features (mounds and other things from FAIMS) and enriches them with raster data (TPI, TRI, prom, elev, ...)

* 00b - deduplicates spatial points that are 10m or closer as they are duplicates - revisits of the same feature in subsequent seasons. Often, the first time capture TRAP ID of the mounds is in AKB, so use the dd_early version if you need to X-ref with AKB. Otherwise later records may be more consistent with the post-2017 methodology so consider dd_later dataset for analysis.

* 00c - enriches data with azimuth and distance to administrative village/zemlishte and crops by Yambol region for the purpose of AKB entry and submission

* 01a - wrangles mounds out of the feature dataset: by type, checks for duplicate attributes, streamlines attributes such as condition, type etc. to strip anotations, question marks, etc.

* 01b - wrangles early version of features to streamline attributes and visualize (oldest script and perhaps least useful now)

* 02 - visualisation of the mound dataset within Yambol region in simple plot or mapview libraries

* 03 - Monte Carlo on mound elevations and 1000 random points in Yambol

* 04 - Monte Carlo on prominence values in mounds and 1000 random points in Yambol, re-used in the article on Yambol BA mounds for Volker Heyd

* 05 - Mann-Whitney test of the MC tests

* 07 - Frequency analysis???

* 08 - Inter-Visibility analysis from mound to mound via a raster profile

* 09 - BA mounds: scrip for Volker Heyd's analysis including MC prominence calculation and initial manual coding of excavated results (which did not make it into survey dataset)

* 10 - Bunkers: elaboration for Mathias' article, mostly visualisations of bunker features at different scales; needs arrows

* 11 - attempts to bring in literature (AOR) mounds for comparison