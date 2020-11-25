gni_cap_raw <-
  read_csv(
  file = "data/API_NY.GNP.PCAP.PP.KD_DS2_en_csv_v2_1625248.csv",
  skip = 4
)

get_gni_data <- function(data, meta_countries_raw) {
  
  df <- 
  data %>%
    select(-X66) # Remove empty column
 
  # Make data frame long instead of wide 
  df <- 
    df %>%
    gather(
      -c(`Country Name`,
         `Country Code`,
         `Indicator Name`,
         `Indicator Code`),
      key = year,
      val = gni_cap
    ) %>%
    select(
      country_name = `Country Name`,
      country_code = `Country Code`,
      year,
      gni_cap
    ) %>%
    filter(!is.na(gni_cap))
  
  # Remove countries not in 15 countries chosen
}