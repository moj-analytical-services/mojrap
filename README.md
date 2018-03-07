# ASD_RAP_Library

## Contents
* [What is this repo for?](#what-is-this-repo-for)
* [Using the package](#using-the-package)
* [Package infrastructure](#package-infrastructure)
* [Contributing to the package](contributiong-to-the-package)

## What is this repo for?

This repository is for general functions for RAP (Reproducible Analytical Pipelines) that you have made and think others may find useful. 

This is an internal, ASD library which is intended to be a safe space for sharing some of your work and collaborating with others doing similar work. We encourage people to try out the functions and if you think an improvement can be made/find a bug you can open a Pull Request with your changes and work with the function creator to find the best solution.

Once you are happy that your function is working as intended, you may want to try and add it to our external [RAP_code_library](https://github.com/moj-analytical-services/RAP_code_library). This is a public facing repo/package that we are using to promote our work to the public and any other government analysts who are using RAP. Adding to the public repo requires a bit more work on the QA side of things, but we feel it is really worthwhile to try and contribute to the wider community. More information on contributing to the public library can be found [here](https://github.com/moj-analytical-services/RAP_code_library).

## Getting Started

### Using the package

If you just want to make use of the package, do the following:

* Create a Github [Public Access Token (PAT)](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)
* Assign this value to a variable `GITHUB_PAT`
* Run `devtools::install_github("moj-analytical-services/ASD_RAP_library", access_token = GITHUB_PAT)`
* Load the package using `library(asdrap)`

You will now have access to all the functions in the library, using the following syntax:

Example: to use FUNCTION from the asdrap package, type `asdrap::FUNCTION()`

## Package Infrastructure
A whistle stop tour of the package for those who aren't as familiar with R/package development 

### R/
This is where most of the code which does the analysis lives. All the code is functions, only some of which are avaiable when you install the package.

### man/
This is where the package documentation that can usually be found running ?function_name 

### tests/
The code here simply tests the functions in the package are working as expected. None of this code does any of the analysis the package was designed for, instead acting as quality assurance for the functions that have been created to do the analysis.

### README.md
Contains the text for this document in Markdown format. This is the sole documentation for the package, other than occasional comments in the source code. The source code should be transparent enough that it is best to read the source code to understand how functions in the package work.

### NAMESPACE
Is a config file that should not be updated manually - instead use roxygen comments in the code. http://r-pkgs.had.co.nz/namespace.html

### DESCRIPTION
Is a config file. Most fields are self explanatory. http://r-pkgs.had.co.nz/description.html


### Contributing to the package

To be added
