# Title: Mean Absolute Error (MAE) based Cross Validation (CV)
# Author: Hoyong Jung
# Date: Feb. 20, 2023


library(tidyverse)
library(boot)

# Notes
# As following functions use CV Algorithm,
# Results can differ from the given file.


# cost of MAE CV
cost_mae <- function(observed_value, expected_value) {
  mean(abs(observed_value - expected_value))
}

# This function get `model term` vector
# returns `model` string
model_creation <- function(model_terms_vector) {
  model = "bloom_doy ~ year"
  if (model_terms_vector[1] == 1) {
    model = paste(model,"alt", sep = " + ")
  }
  if (model_terms_vector[2] == 1) {
    model = paste(model,"lat", sep = " + ")
  }
  if (model_terms_vector[3] == 1) {
    model = paste(model,"long", sep = " + ")
  }
  if (model_terms_vector[4] == 1) {
    model = paste(model,"year_cos", sep = " + ")
  }
  if (model_terms_vector[5] == 1) {
    model = paste(model,"year_sin", sep = " + ")
  }
  if (model_terms_vector[6] == 1) {
    model = paste(model,"lat_cos", sep = " + ")
  }
  if (model_terms_vector[7] == 1) {
    model = paste(model,"lat_sin", sep = " + ")
  }
  return(model)
}


# This function get `model term` vector
# returns MAE of leave one out CV (LOOCV)
model_mae_cv <- function(model_terms_vector) {
  cmodel <- model_creation(model_terms_vector)
  cfit <- glm(as.formula(cmodel),data=cherry_trans)
  mae_cv <- cv.glm(data = cherry_trans, cost = cost_mae,glmfit = cfit,K=nrow(cherry_trans))
  return(mae_cv$delta[1])
}


# This function get `void`
# return the `model` string with lowest MAE
stepwise_cv_model_selection <- function() {
  cur_vector <- c(0,0,0,0,0,0,0)
  cur_mae <- model_mae_cv(cur_vector)
  go <- TRUE
  while (go) {
    go <- FALSE
    min_idx = 0
    for (i in 1:7) {
      new_mae <- change_vector_mae(cur_vector,i)
      # print("")
      # print(new_mae)
      # print(model_creation(change_vector_mode(cur_vector, i)))
      if (new_mae < cur_mae) {
        cur_mae <- new_mae
        min_idx <- i
      }
    }
    if (min_idx) {
      cur_vector <- change_vector_mode(cur_vector,min_idx)
      go <- TRUE
    }
  }
  print(paste("final MAE:", cur_mae))
  print(paste("final model:", model_creation(cur_vector)))
  return(model_creation(cur_vector))
}

# This function get `vector`
# and change vector mode at the given position
change_vector_mode <- function(model_terms_vector, posi) {
  if (model_terms_vector[posi] == 0) {
    model_terms_vector[posi] <- 1
  } else {
    model_terms_vector[posi] <- 0
  }
  return(model_terms_vector)
}

# get changed vector mode 
# return MAE of changing
change_vector_mae <- function(model_terms_vector, posi) {
  return(model_mae_cv(change_vector_mode(model_terms_vector, posi)))
}

# model_terms = c(1,0,0,0,0,0,0,0,0) # Which means only `year` is used for regression model
#
# md <- model_creation(model_terms)
#
# base_fit <- glm(as.formula(base_model),data=cherry_trans)
# 
# cc <- cv.glm(data = cherry_trans,glmfit = base_fit,K=5)
# cc$delta[1]
# 
# cc <- cv.glm(data = cherry_trans, cost = abs_diff,glmfit = base_fit,K=5)
# cc$delta[1]


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

#[1] 5.073898
#[1] "bloom_doy ~ year + alt + lat_cos"

#[1] 5.076894
#[1] "bloom_doy ~ year + year_sin"

