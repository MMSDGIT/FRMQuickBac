#' landing_page UI Function
#'
#' @noRd
mod_landing_page_ui <- function(id) {
  ns <- NS(id)
    # Top row: text left, image right
  shiny::tagList(
    shiny::fluidRow(
    shiny::column(
      width = 6,
      bs4Dash::bs4Card(
        title = "Background",
        width = 12,
        status = "primary",
        solidHeader = TRUE,
        tags$div(
          shiny::HTML(
            glue::glue(
              "<span style='font-size:1.25rem;'>
              The Milwaukee Metropolitan Sewerage District (MMSD) monitors surface water quality throughout its service area using bacterial indicators (<i>E. coli</i> and fecal coliform) and dissolved oxygen.
              Samples are collected bimonthly from April through October and monthly from November through March.
              <i>E. coli</i> is the primary bacterial indicator, while fecal coliform is measured at a subset of stations as a supplemental metric.
              Dissolved oxygen is measured in the field using a YSI multiparameter sonde.
              </span>"
            )
        )
        )
      ),
    bs4Dash::bs4Card(
  title = "Water Quality Standards",
  width = 12,
  status = "primary",
  solidHeader = TRUE,

 tags$div(
  style = "font-size:1.25rem",
  "Wisconsin's Consolidated Assessment and Listing Methodology (WisCALM) is updated every two years and provides guidance for evaluating surface water quality and supporting Clean Water Act reporting. ",
  "The reference thresholds shown throughout this dashboard are based on WisCALM and are intended to aid interpretation of the monitoring data. ",
  "Because fecal coliform is collected as a supplemental indicator within MMSD's monitoring program, the same reference threshold is used for consistency and comparison. ",
  "These values are provided for informational purposes and should not be interpreted as regulatory determinations."
),
tags$br(),
tags$div(
  style = "font-size:1.25rem;",
  tags$ul(
    tags$li(
      HTML("<i>E. coli</i> reference threshold: <b>126 MPN/100 mL</b> (values above this threshold are highlighted as exceedances).")
    ),
    tags$li(
      HTML("Fecal coliform reference threshold: <b>126 CFU/100 mL</b> (used as a supplemental reference for comparison within this dashboard).")
    ),
    tags$li(
      HTML("Dissolved oxygen reference threshold: <b>5 mg/L</b> (values below this threshold are highlighted as exceedances).")
    )
  )
)
),      
bs4Dash::bs4Card(
        title = "Weather Stations",
        width = 12,
        status = "primary",
        solidHeader = TRUE,
tags$div(
  shiny::HTML(
    glue::glue(
      "<span style='font-size:1.25rem;'>",
      "MMSD also maintains <a href='https://www.mmsd.com/about-us/milwaukee-rain-facility-information' target='_blank' style='color:#0E67A0; font-weight:600;'>a network of weather stations</a> distributed throughout its service area to monitor precipitation. ",
      "For reporting purposes, each water quality monitoring site is paired with the geographically closest weather station. ",
      "Precipitation values shown in this report reflect data from that nearest station with available data at the time the sample was collected. ",
      "The 48-hour precipitation metric represents the total inches of rainfall recorded during the 48 hours preceding the sampling time at the closest rain gauge. ",
      "</span>"
    )
  )
)
)
  ),
      shiny::column(
        width = 6,
        shiny::fluidRow(
        bs4Dash::bs4Card(
          title = "MMSD RV Pelagos",
          width = 12,
        status = "primary",
        solidHeader = TRUE,
        div(
            style = "margin: -1rem -1rem 0 -1rem;",
            tags$img(
              src = "www/pelagos.jpg",
              alt = "Bacteria report image",
              style = "
                width: 100%;
                height: auto;
                display: block;
              "
            )
          )
        )
      ),
        shiny::fluidRow(
        bs4Dash::bs4Card(
          title = "MMSD Rain Guage",
          width = 12,
        status = "primary",
        solidHeader = TRUE,
        div(
            style = "margin: -1rem -1rem 0 -1rem;",
            tags$img(
              src = "www/rain_gauge.jpg",
              alt = "Bacteria report image",
              style = "
                width: 100%;
                height: auto;
                display: block;
              "
            )
          )
        )
      )
    )
    )
  )
}

#' landing_page Server Functions
#'
#' @param sites data.frame with columns: lat, lon, site_name (customize if needed)
#' @noRd
mod_landing_page_server <- function(id, sites = NULL) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}
