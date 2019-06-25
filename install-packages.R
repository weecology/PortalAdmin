# Install pacman

if ("pacman" %in% rownames(installed.packages()) == FALSE) install.packages("pacman")

# Install packages using pacman

pacman::p_load(httr, testthat)
