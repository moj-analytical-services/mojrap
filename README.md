# RAP_code_library

## Contents
* [What is this repo for?](#what-is-this-repo-for)
* [Using the package](#using-the-package)
* [Functions in the package](#functions-in-the-package)
* [Contributing to the package](contributiong-to-the-package)
* [Package infrastructure](package-infrastructure)
* [Other RAP Resources](other-resources)

## What is this repo for?
This repository is for generalised functions for RAP (Reproducible Analytical Pipelines). If there are any functions in your RAP that will be useful to other people, please use this space to share them. 

## Using the package

If you just want to make use of the package, do the following:

* Run `devtools::install_github("moj-analytical-services/RAP_code_library")` to download the package
* Load the package using `library(mojrap)`

You will now have access to all the functions in the library, using the following syntax:

Example: to use FUNCTION from the asdrap package, type `mojrap::FUNCTION()`

## Functions in the package

* `as_number.R` - Turns numerical strings into number format
* `connector.R` - Produces a connecting word for a compound sentence
* `date_type.R` - Takes standard dates and outputs them in specified formats
* `format_num.R` - Formats numerical values as thousand delimitted absolute values. Values of less than 10 are words
* `format_perc.R` - Formats fractions as percentages, with percentage signs
* `getThursday.R` - Predicts the next publication date for quarterly publications
* `incdec.R` - Quantifies changes in values eg. "increased by ..."
* `quarter_dates.R` - Caculates quarter dates


## Package Infrastructure
A whistle stop tour of the package for those who aren't as familiar with R/package development 

### R/
This is where most of the code which does the analysis lives. All the code is functions, only some of which are avaiable when you install the package.

### man/
This is where the package documentation that can usually be found running ?function_name lives. 

### tests/
The code here simply tests the functions in the package are working as expected. None of this code does any of the analysis the package was designed for, instead acting as quality assurance for the functions that have been created to do the analysis.

### README.md
Contains the text for this document in Markdown format. This is the sole documentation for the package, other than occasional comments in the source code. The source code should be transparent enough that it is best to read the source code to understand how functions in the package work.

### NAMESPACE
Is a config file that should not be updated manually - instead use roxygen comments in the code. http://r-pkgs.had.co.nz/namespace.html

### DESCRIPTION
Is a config file. Most fields are self explanatory. http://r-pkgs.had.co.nz/description.html

## Contributing to this package

To add to this repository, your function must meet the following criteria:
* Must have been used in a publication
* Must have unit testing
* Must pass unit testing of entire package
* Must have documentation around functions with examples

More in-depth contribution guidlines to follow

## Other resources

For bespoke code please see:
* [OMSQ_RAP](https://github.com/moj-analytical-services/OMSQ_RAP)
* [JDL_RAP](https://github.com/moj-analytical-services/JDL_RAP)
* [CCSQ_RAP](https://github.com/moj-analytical-services/CCSQ_RAP)
