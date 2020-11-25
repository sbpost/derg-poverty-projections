reformat_wb_data <- function(df, meta_data) {
    
    # for some reason, the wb data always also reads in an empty 
    # column at the end. in this case, it is x66.
    df <- 
      df %>%
      select(-X66)
    
    df <- 
      df %>%
      gather(
        -c(`Country Name`,
           `Country Code`,
           `Indicator Name`,
           `Indicator Code`),
        key = year,
        val = value
      ) %>%
      select(
        country_name = `Country Name`,
        country_code = `Country Code`,
        year,
        value,
        metric = `Indicator Name`
      )
    
    # Remove missing values in "value"
    df <- 
      df %>%
      drop_na(value)
    
    # Prep meta data and filter df based on region = SSA
    meta_data <- 
      meta_data %>%
      select(
        country_code = `Country Code`,
        region = Region
        )
    
    df <- 
      df %>%
      left_join(meta_data, by = "country_code") %>%
      filter(region == "Sub-Saharan Africa")
    
    return(df)
}

get_newest_obs <- function(df) {
  
  df %>%
    group_by(country_code) %>%
    filter(year == max(year)) %>%
    ungroup()
  
}
