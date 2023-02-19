library(rnoaa)
library(tidyverse)

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

temperature_by_month <- function(location) {
  ghcnd_search(
    stationid = id_by_location(location),
    var = c("tmax"),
    date_min = "1991-01-01",
    date_max = "2023-02-28"
  )[[1]] %>%
    mutate(month = format(date, format = "%m")) %>%
    mutate(year = format(date, format = "%Y")) %>%
    group_by(year, month) %>%
    summarize(tmax_avg = mean(tmax, na.rm = TRUE)) %>%
    pivot_wider(
      names_from = month,
      names_prefix = "tmax_avg_",
      values_from = tmax_avg
    ) %>%
    mutate(location = location) %>%
    mutate(tmax_JanFeb = tmax_avg_01 + tmax_avg_02) %>%
    select(location, year, tmax_JanFeb)
    
}

c <- temperature_by_month("kyoto")


