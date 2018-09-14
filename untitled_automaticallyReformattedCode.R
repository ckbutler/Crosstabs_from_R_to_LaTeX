setwd('Dropbox/581_Fall2018_Shared/R_Tutorials/Crosstabs/')
library(xtable)
data(tli)
tli <- subset(tli, ethnicty != 'OTHER', select = c(disadvg, ethnicty))
library(descr)
ct <-
  crosstab(
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
plot(ct)
dev.copy(png, 'fig-disadvgXethnicty.png')
dev.off()
