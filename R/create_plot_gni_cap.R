# for dev:
# country_list <- readd("analysis_countries")
# data <- readd("gni_cap_tbl")

create_plot_gni_cap <- function(data, country_list) {
 
  data <-
    data %>%
    filter(country_code %in% country_list) %>%
    get_newest_obs()
  
  data <-
    data %>%
    arrange(desc(value)) %>%
    mutate(cc_numeric = row_number())
  
  
  # God i 5 x 7 inch
    data %>%
      {ggplot(., aes(y = cc_numeric, x = value)) +	
      geom_segment(aes(y = cc_numeric, yend = cc_numeric,
                       x = 0, xend = value),
                   size = 3,
                   color = get_globals()$colors_4[4]) +
      geom_vline(xintercept = (1.90 * 365), linetype = "dashed", size = 0.8) +
          annotate("text", x = 2200, y = 13.5, label = "$1.90 poverty line") + 
      scale_y_continuous(breaks = 1:15, labels = .$country_code %>% unique()) +
      xlab("GNI per capita PPP (constant 2017 int'l $)") +
      ylab("") +
      labs(caption ="Observations are the most recent available for each country (2017-19). Data from the World Bank.") +
      theme_bw()}
}