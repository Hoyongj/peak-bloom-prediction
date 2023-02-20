library(tidyverse)
library(boot)

# df <- tibble(a = c(1, 2, 3), b = c(10, 20, 30), c = c(5, 6, 7), d = c(12, 23, 34))

# cv5 <- function(degree) {
#   fit <- glm(price ~ poly(carat,degree)*clarity,data=diamonds)
#   cc <- cv.glm(diamonds,fit,K=5)
#   cc$delta[1]
# }

# model fit string
num_to_fit_string <- function(model_num) {
  model_string = "bloom_doy ~ "
  model_vec = as.integer(intToBits(model_num)) # 9 length Hence (1:512)
  col_names = colnames(cherry_trans)
  col_names = col_names[col_names!="bloom_doy"] # remove Y from explanatory variables
  idx = 0
  for (name in col_names) {
    idx = idx + 1
    if (model_vec[idx] == 0) {
      model_string = paste(model_string, name, sep = " + ")
    }
  }
  return(model_string)
}

# choose model fit
num_to_fit <- function(model_num) {
  glm(as.formula(num_to_fit_string(model_num)),data=cherry_trans) # return this glm
}

# cost of CV
abs_diff <- function(observed_value, expected_value) {abs(observed_value - expected_value)}

# calc cv value
cv5 <- function(fit) {
  cc <- cv.glm(data = cherry_trans, cost = abs_diff,glmfit = fit,K=5)
  cc$delta[1]
}

# demo
result <- 1:2**length(colnames(cherry_trans))
form <- 1:2**length(colnames(cherry_trans))
cv.err <- map_dbl(result, cv5) # It may takes some time.
