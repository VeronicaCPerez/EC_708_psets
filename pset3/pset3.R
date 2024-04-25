# Load necessary libraries
library(plm)
library(xtable)

setwd("/Users/veronica/Dropbox/PhD/2024_1/EC_708_Econometrics/EC_708_psets/pset3/")

# Load the dataset
data <- read.csv("pset3.csv")

# Define the model formula
formula <- log(emp) ~ lag(log(emp), 1:2) + lag(log(wage), 0:1) +
  lag(log(capital), 0:2) + lag(log(output), 0:2) | lag(log(emp), 2:ncol(data))

# Estimate using one-step GMM
model_one_step <- pgmm(formula, data = data, effect = "twoways", model = "onestep")

# Estimate using two-step GMM
model_two_step <- pgmm(formula, data = data, effect = "twoways", model = "twostep")

# Print summaries
summary(model_one_step)
summary(model_two_step, robust = FALSE)

# Perform Wald test
car::linearHypothesis(model_two_step, c("lag(log(capital), 0:2)1 = 0", 
                                        "lag(log(capital), 0:2)2 = 0"), vcov = vcov)

# Sargan test for overidentifying restrictions
sargan(model_two_step)

# Export summary tables as LaTeX fragments
table_one_step <- xtable(summary(model_one_step))
table_two_step <- xtable(summary(model_two_step), align = "l")

print.xtable(table_one_step, file = "model_one_step.tex", floating = FALSE, include.rownames = FALSE)
print.xtable(table_two_step, file = "model_two_step.tex", floating = FALSE, include.rownames = FALSE)