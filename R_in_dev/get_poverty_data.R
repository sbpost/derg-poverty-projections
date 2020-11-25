prepare_poverty_data <- function(data) {
  
  # Prepare data --------------------------------------------------------
    # For some reason, the WB data always also reads in an empty 
    # column at the end. In this case, it is X66.
    df <- 
      data %>%
      select(-X66)
    
    df <- 
      df %>%
      gather(
        -c(`Country Name`,
           `Country Code`,
           `Indicator Name`,
           `Indicator Code`),
        key = year,
        val = percentage_of_pop_below
      ) %>%
      select(
        country_name = `Country Name`,
        country_code = `Country Code`,
        year,
        percentage_of_pop_below,
        metric
      )
    
    
}