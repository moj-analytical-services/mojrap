# ASD_RAP_Library

## Contents
* [What is this repo for?](#what-is-this-repo-for)
* [Using the package](#using-the-package)
* [Package infrastructure](#package-infrastructure)
* [Contributing to the package](contributiong-to-the-package)
* [Found a bug?](found-a-bug)

## What is this repo for?

This repository is for general functions for RAP (Reproducible Analytical Pipelines) that you have made and think others may find useful. 

This is an internal, ASD library which is intended to be a safe space for sharing some of your work and collaborating with others doing similar work. We encourage people to try out the functions and if you think an improvement can be made/find a bug you can open a Pull Request with your changes and work with the function creator to find the best solution.

Once you are happy that your function is working as intended, you may want to try and add it to our external [RAP_code_library](https://github.com/moj-analytical-services/RAP_code_library). This is a public facing repo/package that we are using to promote our work to the public and any other government analysts who are using RAP. Adding to the public repo requires a bit more work on the QA side of things, but we feel it is really worthwhile to try and contribute to the wider community. More information on contributing to the public library can be found [here](https://github.com/moj-analytical-services/RAP_code_library).

## Getting Started

## Using the package

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

### packrat/
This folder contains all of the code/data needed for packrat. Packrat is used to manage package dependencies for your functions in the R folder.

### README.md
Contains the text for this document in Markdown format. This is the sole documentation for the package, other than occasional comments in the source code. The source code should be transparent enough that it is best to read the source code to understand how functions in the package work.

### NAMESPACE
Is a config file that should not be updated manually - instead use roxygen comments in the code. http://r-pkgs.had.co.nz/namespace.html

### DESCRIPTION
Is a config file. Most fields are self explanatory. http://r-pkgs.had.co.nz/description.html



## Contributing to the package

Now that you have created a reusable function, how do you share it with everyone?

1) Clone this repo:
In the terminal, run `git clone git@github.com:moj-analytical-services/ASD_RAP_library.git`

2) Create a new branch and add your function(s) to it - see the [platform guidance](https://moj-analytical-services.github.io/platform_user_guidance/using-github-with-r-studio.html#working-on-a-branch.) if you aren't familiar with doing this

3) Open a [Pull Request](https://help.github.com/articles/creating-a-pull-request/) to merge your functions into the package. 

4) Get someone to [review](https://help.github.com/articles/about-pull-request-reviews/) your pull request. This isn't a a test or anything, its just that getting someone to have a quick look over your code is a good way to learn and imporve. We want to try and build a culture of people sharing their knowledge so if you post your pull requests in the #rap channel of the ASD slack someone should be able to review it for you - and hopefully you will start reviewing for others too!

5) Merge your pull request.

Congratulations! You have now contibuted to the asdrap package! If you [reinstall the package](#using-the-package) you will be able to use your functions.

## Found a bug?

You can also contribute by helping to improve the existing functions. If you find a bug, or think there is a better way of doing something, raise an issue or open a pull request with your suggested solution.
