library(rnoaa)
library(tidyverse)

# Convert name to id

id_by_location <- function(location) {
  if (location == "washingtondc") {
    return("USC00186350")
  }
  if (location == "liestal") {
    return("GME00127786")
  }
  if (location == "kyoto") {
    return("JA000047759")
  }
  if (location == "vancouver") {
    return("CA001108395")
  }
}

# location name -> year, location, last 4 months' temperature

temperature_last_4 <- function(location) {
  tem_tb <- ghcnd_search(
    stationid = id_by_location(location),
    var = c("tmax"),
    date_min = "1990-11-01",
    date_max = "2023-02-28"
  )[[1]] %>%
    mutate(month = format(date, format = "%m")) %>%
    mutate(year = format(date, format = "%Y")) %>%
    group_by(year, month) %>%
    summarize(tmax_avg = mean(tmax, na.rm = TRUE)) %>%
    pivot_wider(
      names_from = month,
      names_prefix = "tmax_",
      values_from = tmax_avg
    ) %>%
    mutate(location = location) %>%
    select(location, year, tmax_01, tmax_02, tmax_11, tmax_12)
  # mutate(tmax_last_4 = lag(tmax_12)) # lag not working
  tem_tb$tmax_11_prev <-
    c(NA, tem_tb$tmax_11[-length(tem_tb$tmax_11)]) # Alternative Implementation of `lag`
  tem_tb$tmax_12_prev <-
    c(NA, tem_tb$tmax_12[-length(tem_tb$tmax_12)])
  tem_tb %>%
    # select(-c(tmax_11,tmax_12)) %>%
    mutate(tmax_last_4 = (tmax_11_prev + tmax_12_prev + tmax_01 + tmax_02) /
             4) %>%
    select(location,
           year,
           tmax_11_prev,
           tmax_12_prev,
           tmax_01,
           tmax_02,
           tmax_last_4)
}

# # temperature_last_4 demo
# c <- temperature_last_4("kyoto")
