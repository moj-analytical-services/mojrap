[![Coverage status](https://codecov.io/gh/moj-analytical-services/RAP_code_library/branch/master/graph/badge.svg)](https://codecov.io/github/moj-analytical-services/RAP_code_library?branch=master)

# RAP_code_library

This repository is for generalised functions for RAP (Reproducible Analytical Pipelines). If there are any functions in your RAP that will be useful to other people, please use this space to share them.

# Contents

* `as_number.R` - Turns numerical strings into number format
* `connector.R` - Produces a connecting word for a compound sentence
* `date_type.R` - Takes standard dates and outputs them in specified formats
* `format_num.R` - Formats numerical values as thousand delimitted absolute values. Values of less than 10 are words
* `format_perc.R` - Formats fractions as percentages, with percentage signs
* `getThursday.R` - Predicts the next publication date for quarterly publications
* `incdec.R` - Quantifies changes in values eg. "increased by ..."
* `quarter_dates.R` - Caculates quarter dates

# Contributing to this repository

To add to this repository, your function must meet the following criteria:
* Must have been used in a publication
* Must have unit testing
* Must pass unit testing of entire package
* Must have documentation around functions with examples

For in-depth guidance on contributing, see [How to contribute](https://github.com/moj-analytical-services/RAP_code_library/blob/master/vignettes/How_to_contribute.Rmd)

# Other resources

For bespoke code please see:
* [OMSQ_RAP](https://github.com/moj-analytical-services/OMSQ_RAP)
* [JDL_RAP](https://github.com/moj-analytical-services/JDL_RAP)
* [CCSQ_RAP](https://github.com/moj-analytical-services/CCSQ_RAP)


