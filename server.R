library("tidyverse")

rainzwe_data <- read_csv("data/zwe_rain.csv")

district_and_wards <- read_csv("data/districts.csv") %>%
  filter(wardcode %in% rainzwe_data$wardcode)

year <- read_csv("data/yearcode.csv")

function(input, output, session) {
  
  updateSelectInput(session,
                    "selected_district",
                    choices = unique(district_and_wards$district))
  
  observeEvent(input$selected_district,
               {
                 ward_in_district <- district_and_wards %>%
                   filter(district == input$selected_district) %>%
                   pull(wardcode)
                 
                 updateSelectInput(session,
                                   "selected_wardcode",
                                   choices = ward_in_district)
                 
               })
  
  updateSelectInput(session,
                    "selected_year",
                    choices = setNames(year$yearcode, year$yearname))
  
  
  output$zwe_rain_chart <- renderPlot({
    
    selected_year_name <- year %>%
      filter(yearcode == input$selected_year) %>%
      pull(yearname)
    
    rainzwe_data %>%
            filter(
        wardcode == input$selected_wardcode
      ) %>%
      filter(year == input$selected_year) %>%
      filter(!is.na(rainfall)) %>%
      ggplot(aes(x = month, y = rainfall, group = 1)) +
      geom_path() +
      labs(
        title = paste("Total monthly rainfall in mm", "in", input$selected_district),
              )
  })
  
}