the_plan <-
  drake::drake_plan(
    
    # Read in data -------------------------------------------------------------
    
    # GNI/capita
    gni_cap_raw = read_csv(
      file = file_in("data/gni-cap/API_NY.GNP.PCAP.PP.KD_DS2_en_csv_v2_1625248.csv"),
      skip = 4
    ),
    
    # Meta (country regions)
    meta_countries_raw = read_csv(
      file = file_in("data/gni-cap/Metadata_Country_API_NY.GNP.PCAP.PP.KD_DS2_en_csv_v2_1625248.csv")
    ),
    
    # Population data
    pop_raw = read_csv(
      file = file_in("data/pop/API_SP.POP.TOTL_DS2_en_csv_v2_1593924.csv"),
      skip = 4
    ),
    
    # Poverty data (< $1.90) 
    percentage_below_190_raw = read_csv(
      file = file_in("data/poverty/API_SI.POV.DDAY_DS2_en_csv_v2_1563017.csv"),
      skip = 4
    ),
    
    # Tidy data ----------------------------------------------------------------
    # Prepare poverty data
    poverty_tbl = reformat_wb_data(
      df = percentage_below_190_raw,
      meta_data = meta_countries_raw
    ),
    
    # Prepare pop data
    pop_tbl = reformat_wb_data(
      df = pop_raw,
      meta_data = meta_countries_raw
    ),
    
    # Prepare GNI/capita data
    gni_cap_tbl = reformat_wb_data(
      df = gni_cap_raw,
      meta_data = meta_countries_raw
    ),
    
    # TODO: Get list of selected countries (15 countries covering the 80% total poverty)
    analysis_countries = get_analysis_countries(
      poverty_data = poverty_tbl,
      pop_data = pop_tbl
    ),
    
    # GNI/CAP by poverty line --------------------------------------------------
    # TODO: Bar chart with GNI/capita and a line for $1.90 poverty line
    gni_cap_plot = create_plot_gni_cap(data, country_list),
    
    # Projections of poverty in 2015-2020-2030 ---------------------------------
    # TODO: A curve showing the development of poverty in selected countries in 
    # 2015, 2020, 2030.
    # TODO: Get growth-poverty elasticity for each individual country and for 
    # all countries as total
    # TODO: Get several estimates of growth-poverty elasticity based on scholarly 
    # literature. Find methods.
    
    # Projection of necessary country growth to eliminate extreme poverty by
    # 2030 ---------------------------------------------------------------------
    # TODO: A chart that shows how high economic growth is needed in the 15 
    # countries to eliminate extreme poverty by 2030. Assume the % of population
    # as function of growth continues as lates numbers available. 
  )
