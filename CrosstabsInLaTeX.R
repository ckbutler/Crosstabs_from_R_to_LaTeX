######################################
# Title: Crosstabs with LaTeX Output
# Author: Christopher K. Butler
# Last updated: 2018-09-14
######################################

# This script shows how to create a crosstab with a chi-square statistic,
# how to create a LaTeX version of that crosstab, and how to create a graph
# of that crosstab.

# Working Directory ===========================================================
if (Sys.info()['user'] == 'cassydorff') {
  gpath    = '~/ProjectsGit/netproj/code/'
  graphics = '~/Dropbox/netproj/graphics/'
}

if (Sys.info()['user'] == 'ckbutler') {
  setwd('/home/ckbutler/Dropbox/581_Fall2018_Shared/R_Tutorials/Crosstabs/')
}

# Clean up workspace ==========================================================
rm(list = ls(all = TRUE))

# Functions ===================================================================
detachAllPackages <- function() {
  basic.packages <-
    c(
      "package:stats",
      "package:graphics",
      "package:grDevices",
      "package:utils",
      "package:datasets",
      "package:methods",
      "package:base"
    )
  package.list <-
    search()[ifelse(unlist(gregexpr("package:", search())) == 1,
                    TRUE, FALSE)]
  package.list <- setdiff(package.list, basic.packages)
  if (length(package.list) > 0)
    for (package in package.list)
      detach(package, character.only = TRUE)
  # https://stackoverflow.com/questions/7505547/detach-all-packages-while-working-in-r
  # Answer from mjaniec
}

# Libraries ===================================================================
# First unload all packages:
detachAllPackages()

# Then load libraries that are needed:
# library(tidyverse)
# library(gmodels)
# library(Kendall)
# library(vcd)
# library(vcdExtra)
library(xtable)
library(descr)

# Load Data ===================================================================
data(tli, package = 'xtable') # from Texas Assessment of Academic Skills (TAAS)
help(tli) # Opens description/codebook of the data

# Data Analysis ===============================================================

# Get summary statistics of the data
print(summary(tli))

# Create a crosstab of disadvg by ethnicity with only the statistics we want:
print(
  CrossTable(
    tli$disadvg,
    tli$ethnicty,
    expected = FALSE,
    prop.t = FALSE,
    prop.chisq = FALSE,
    prop.r = FALSE,
    prop.c = TRUE,
    chisq = TRUE
  )
)

# Exclude OTHER in the ethnicity category (as there are too few cases):
tli <-
  subset(tli, ethnicty != 'OTHER', select = c(disadvg, ethnicty))

ct <- crosstab(
  tli$disadvg,
  tli$ethnicty,
  digits = list(
    expected = 1,
    prop = 3,
    percent = 1,
    others = 3
  ),
  prop.c = TRUE,
  chisq = TRUE,
  drop.levels = TRUE,
  dnn = c("Disadvantaged", "Ethnicity"),
  plot = FALSE
)

print(ct)

print(xtable(ct))

# Output for publication ======================================================

# Make a nicer looking LaTeX table:
# Add to the preamble of your LaTeX document:
# \usepackage{booktabs}
# \usepackage{multirow}
print(
  xtable(
    ct,
    align = "llrrrr",
    multirow = TRUE,
    hline = TRUE,
    row.labels = TRUE,
    percent = TRUE,
    caption = "Economically disadvantaged by ethnicity",
    label = "tab:disadvgXethnicty"
  ),
  booktabs = TRUE,
  include.rownames = FALSE,
  caption.placement = 'top',
  sanitize.text.function = function(x)
    x,
  file = "tab-disadvgXethnicty.tex"
)

# Create a graph of the crosstab:
plot(ct)
dev.copy(png, 'fig-disadvgXethnicty.png')
dev.off()

# stop("I stopped the script early")
