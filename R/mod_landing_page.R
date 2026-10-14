
#' landing_page UI Function
#'
#' @noRd
mod_landing_page_ui <- function(id) {

  ns <- NS(id)

  shiny::tagList(
    shiny::fluidRow(

      # ---- Left Column: Information ----
      shiny::column(
        width = 6,

        # ---- Background ----
  bs4Dash::bs4Card(
    title = "Background",
    width = 12,
    status = "primary",
    solidHeader = TRUE,

    tags$div(
      style = "font-size:1.25rem;",

      "The Freshwater Resources Monitoring group conducts routine surface water monitoring at nearly 100 fixed monitoring sites within the MMSD Planning Area and Lake Michigan. Field measurements and grab samples are taken at these sites in all weather conditions and brought to the in-house certified laboratory to be analyzed for almost 40 different parameters.",

      tags$br(),
      tags$br(),

      "A subset of sites and parameters (",
      tags$i("E. coli"),
      ", fecal coliform, and dissolved oxygen) were selected for this report to support early detection of water quality issues. ",

      "Only surface measurements and samples are included in this dashboard, including at locations where monitoring occurs at multiple depths."
    )
  ),
        # ---- Water Quality Thresholds ----
        bs4Dash::bs4Card(
          title = "Water Quality Thresholds",
          width = 12,
          status = "primary",
          solidHeader = TRUE,

          tags$div(
            style = "font-size:1.25rem;",

            "The thresholds shown throughout this dashboard are based on the Wisconsin Department of Natural Resources' Wisconsin Consolidated Assessment and Listing Methodology (WisCALM) and are intended to aid interpretation of the monitoring data. These values are provided for informational purposes and should not be interpreted as regulatory determinations.",

            tags$br(),
            tags$br(),

            tags$ul(
              tags$li(
                tags$i("E. coli"),
                " threshold: ",
                tags$b("126 MPN/100 mL"),
                " (values above this threshold are highlighted as exceedances)."
              ),

              tags$li(
                "Fecal coliform threshold: ",
                tags$b("126 CFU/100 mL"),
                " (the ",
                tags$i("E. coli"),
                " threshold is applied to fecal coliform solely for comparison within this dashboard)."
              ),

              tags$li(
                "Dissolved oxygen threshold: ",
                tags$b("5 mg/L"),
                " (values below this threshold are highlighted as exceedances)."
              )
            )
          )
        ),

        # ---- Rain Gauges ----
        bs4Dash::bs4Card(
          title = "Rain Gauges",
          width = 12,
          status = "primary",
          solidHeader = TRUE,

          tags$div(
            style = "font-size:1.25rem;",

            "MMSD also maintains ",

            tags$a(
              "a network of rain gauges",
              href = "https://www.mmsd.com/about-us/milwaukee-rain-facility-information",
              target = "_blank",
              rel = "noopener noreferrer",
              style = "color:#0E67A0; font-weight:600;"
            ),

            " distributed throughout its service area to monitor precipitation. For reporting purposes, each water quality monitoring site is paired with the geographically closest weather station. Precipitation values shown in this report reflect data from that nearest station with available data at the time the sample was collected. The 48-hour precipitation metric represents the total inches of rainfall recorded during the 48 hours preceding the sampling time at the closest rain gauge."
          )
        )
      ),

# ---- Right Column: Tabbed Images ----
shiny::column(
  width = 6,

  bs4Dash::bs4TabCard(
    title = "MMSD Monitoring",
    width = 12,
    status = "primary",
    solidHeader = TRUE,

    shiny::tabPanel(
      title = "Research Vessel Pelagos",

      tags$img(
        src = "www/pelagos.jpg",
        alt = "Reasearch Pelagos",
        style = "
          width: 100%;
          height: auto;
          display: block;
        "
      )
    ),

    shiny::tabPanel(
      title = "Rain Gauge",

      tags$img(
        src = "www/rain_gauge.jpg",
        alt = "MMSD rain gauge",
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
}


#' landing_page Server Functions
#'
#' @param sites data.frame with columns: lat, lon, site_name
#' @noRd
mod_landing_page_server <- function(id, sites = NULL) {

  moduleServer(id, function(input, output, session) {

    ns <- session$ns

  })
}
