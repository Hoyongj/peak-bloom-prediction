library(rnoaa)
library(tidyverse)


a <- ghcnd_search(
  stationid = "USC00186350",
  var = c("tmax"),
  date_min = "2021-01-01",
  date_max = "2023-01-31"
)[[1]] %>%
  mutate(month = format(date, format = "%m")) %>%
  group_by(id, month) %>%
  summarize(tmax_avg = mean(tmax, na.rm = TRUE)) %>%
  pivot_wider(names_from = month, names_prefix = "tmax_avg_", values_from = tmax_avg)

historic_temperatures <-tibble(
  location = "washingtondc", get_temperature("USC00186350")) %>%
  bind_rows(tibble(location = "liestal", get_temperature("GME00127786"))) %>%
  bind_rows(tibble(location = "kyoto", get_temperature("JA000047759"))) %>%
  bind_rows(tibble(location = "vancouver", get_temperature("CA001108395"))
)