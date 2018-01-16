# ASD_RAP_Library

## What is this repo for?

This repository is for general functions for RAP (Reproducible Analytical Pipelines) that you have made and think others may find useful. 

This is an internal, ASD library which is intended to be a safe space for sharing some of your work and collaborating with others doing similar work. We encourage people to try out the functions and if you think an improvement can be made/find a bug you can open a Pull Request with your changes and work with the function creator to find the best solution.

Once you are happy that your function is working as intended, you may want to try and add it to our external [RAP_code_library](https://github.com/moj-analytical-services/RAP_code_library). This is a public facing repo/package that we are using to promote our work to the public and any other government analysts who are using RAP. Adding to the public repo requires a bit more work on the QA side of things, but we feel it is really worthwhile to try and contribute to the wider community. More information on contributing to the public library can be found [here](https://github.com/moj-analytical-services/RAP_code_library/blob/master/vignettes/How_to_contribute.Rmd).

## Getting Started

### Using the package

If you just want to make use of the package, do the following:

* Create a Github [Public Access Token (PAT)](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)
* Assign this value to a variable `GITHUB_PAT`
* Run `devtools::install_github("moj-analytical-services/ASD_RAP_library")`
* Load the package using `library(asdrap)`

You will now have access to all the functions in the library, using the following syntax:

Example: to use FUNCTION from the asdrap package, type `asdrap::FUNCTION()`

### Contributing to the package

To be added