library(tidyverse)
library(boot)

# # cost of CV
# abs_diff <- function(observed_value, expected_value) {abs(observed_value - expected_value)}

model_terms = c(1,0,0,0,0,0,0,0,0) # Which means only `year` is used for regression model

model_creation <- function(model_temrs_vector) {
  model = "bloom_doy ~"
  if (model_terms[1] == 1) {
    model = paste(model,"location", sep = " + ")
  }
  if (model_terms[2] == 1) {
    model = paste(model,"lat", sep = " + ")
  }
  if (model_terms[3] == 1) {
    model = paste(model,"long", sep = " + ")
  }
  if (model_terms[4] == 1) {
    model = paste(model,"alt", sep = " + ")
  }
  if (model_terms[5] == 1) {
    model = paste(model,"year", sep = " + ")
  }
  if (model_terms[6] == 1) {
    model = paste(model,"year_sin", sep = " + ")
  }
  if (model_terms[7] == 1) {
    model = paste(model,"year_cos", sep = " + ")
  }
  if (model_terms[8] == 1) {
    model = paste(model,"lat_sin", sep = " + ")
  }
  if (model_terms[9] == 1) {
    model = paste(model,"lat_cos", sep = " + ")
  }
  return(model)
}


md <- model_creation(model_terms)

base_fit <- glm(as.formula(base_model),data=cherry_trans)

cc <- cv.glm(data = cherry_trans,glmfit = fit,K=5)
cc$delta[1]



# df <- tibble(a = c(1, 2, 3), b = c(10, 20, 30), c = c(5, 6, 7), d = c(12, 23, 34))


# # model fit string
# num_to_fit_string <- function(model_num) {
#   model_string = "bloom_doy ~ "
#   model_vec = as.integer(intToBits(model_num)) # 9 length Hence (1:512)
#   col_names = colnames(cherry_trans)
#   col_names = col_names[col_names!="bloom_doy"] # remove Y from explanatory variables
#   idx = 0
#   for (name in col_names) {
#     idx = idx + 1
#     if (model_vec[idx] == 0) {
#       model_string = paste(model_string, name, sep = " + ")
#     }
#   }
#   return(model_string)
# }
# 
# # choose model fit
# num_to_fit <- function(model_num) {
#   glm(as.formula(num_to_fit_string(model_num)),data=cherry_trans) # return this glm
# }
# 
# # cost of CV
# abs_diff <- function(observed_value, expected_value) {abs(observed_value - expected_value)}
# 
# # calc cv value
# cv5 <- function(num) {
#   fit = num_to_fit(num)
#   cc <- cv.glm(data = cherry_trans, cost = abs_diff,glmfit = fit,K=5)
#   cc$delta[1]
# }
# 
# # # demo
# # result <- 1:2**length(colnames(cherry_trans))
# # form <- 1:2**length(colnames(cherry_trans))
# # cv.err <- map_dbl(result, cv5) # It may takes some time.
