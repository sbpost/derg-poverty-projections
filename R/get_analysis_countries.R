get_analysis_countries <- function(poverty_data, pop_data) {
  
  # Use only most recent observation for each country
  newest_pov_tbl <-
    poverty_data %>% 
    get_newest_obs()
  
  # Rename pop variables to avoid name clashing
  pop_data <- 
  pop_data %>%
    select(
      country_code,
      year,
      pop = value
    )
  # Add population data
  newest_pov_tbl <-
    newest_pov_tbl %>%
    left_join(pop_data, by = c("country_code", "year"))
  
  # Calculate total number of poor in observation
  newest_pov_tbl <-
  newest_pov_tbl %>%
    mutate(
      share = value / 100,
      poor_pop = share * pop
    ) %>%
    select(-share)
  
  # Calculate cumulative sum of poor
  total_poor <- sum(newest_pov_tbl$poor_pop)
  
  newest_pov_tbl <-
  newest_pov_tbl %>%
    arrange(desc(poor_pop)) %>%
    mutate(
      cumulative_poor = cumsum(poor_pop),
      cumulative_perc = cumulative_poor / total_poor * 100
    ) %>%
    select(-metric)
  
  analysis_countries <- 
  newest_pov_tbl %>% 
    filter(cumulative_perc < 81) %>%
    pull(country_code)
  
  return(analysis_countries)
  
}