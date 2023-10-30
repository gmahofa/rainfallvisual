library("DT")

navbarPage(
  "Total Monthly rainfall in ward",
  tabPanel(
    
    fluidPage(fluidRow(
      column(
        selectInput("selected_district",
                    "Select a district",
                    choices = NULL),
        width = 3
      ),
      column(
        selectInput("selected_wardcode",
                    "Select a ward",
                    choices = NULL),
        width = 4
      ),
      column(
        selectInput("selected_year",
                    "Select a year",
                    choices = NULL,
                    width = "100%"),
        width = 5
      )
    )),
    plotOutput("zwe_rain_chart")
  ),
  collapsible = TRUE
)