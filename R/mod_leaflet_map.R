#' leaflet_map Server Functions
#'
#' @noRd 
#' leaflet_map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_leaflet_map_ui <- function(id) {
  ns <- shiny::NS(id)
  bs4Dash::bs4Card(
    title = "Map",
    status = "primary",
    solidHeader = TRUE,
    width = 12,
    closable = FALSE,
    collapsible = TRUE,
    collapsed = FALSE,
    div(
      style = "height: 79vh; min-height: 400px;",
      leaflet::leafletOutput(ns("map"), height = "100%")
    )
  )
}
    
#' leaflet_map Server Functions
#'
#' @noRd 

#' @noRd

#' @noRd
mod_leaflet_map_server <- function(id, dat_filt, map_inputs, map_selection) {
  moduleServer(id, function(input, output, session) {

    # ---- Static spatial data ----
    mke_basin_sf <- readRDS("data/mke_basin_sf.rds")
    mke_rivers_sf <- readRDS("data/mke_rivers_sf.rds")
    ws_lookup_sf <- readRDS("data/ws_lookup_sf.rds")

    # ---- Render map with permanent geographic layers ----
    output$map <- leaflet::renderLeaflet({

      watershed_levels <- c(
        "Cedar Creek",
        "Menomonee River",
        "Kinnickinnic River",
        "Lower Milwaukee River"
      )

      pal2 <- leaflet::colorFactor(
        palette = "viridis",
        domain = watershed_levels
      )

      map <- leaflet::leaflet() |>
        leaflet::addProviderTiles(
          leaflet::providers$Esri.WorldStreetMap,
          group = "Street Map"
        ) |>
        leaflet::addProviderTiles(
          leaflet::providers$Esri.WorldImagery,
          group = "Satellite"
        ) |>
        leaflet::setView(
          lng = -87.99,
          lat = 43.15,
          zoom = 10
        )

      # ---- Permanent watershed polygons ----
      if (inherits(mke_basin_sf, "sf") && nrow(mke_basin_sf) > 0) {
        map <- map |>
          leaflet::addPolygons(
            data = mke_basin_sf,
            group = "basins",
            options = leaflet::pathOptions(zIndex = 200),
            color = "gray50",
            opacity = 0.8,
            fillOpacity = 0.22,
            weight = 1,
            fillColor = ~pal2(HUC10_NAME)
          )
      }

      # ---- Permanent rivers ----
      if (inherits(mke_rivers_sf, "sf") && nrow(mke_rivers_sf) > 0) {
        map <- map |>
          leaflet::addPolylines(
            data = mke_rivers_sf,
            color = "blue",
            weight = 2,
            group = "rivers",
            options = leaflet::pathOptions(zIndex = 400)
          )
      }

      # ---- Permanent weather stations ----
      ws_icon <- leaflet::makeIcon(
        iconUrl = "www/raindrop.png",
        iconWidth = 16,
        iconHeight = 23,
        iconAnchorX = 0,
        iconAnchorY = 0
      )

      if (inherits(ws_lookup_sf, "sf") && nrow(ws_lookup_sf) > 0) {
        map <- map |>
          leaflet::addMarkers(
            data = ws_lookup_sf,
            icon = ws_icon,
            group = "Rain Gauges",
            popup = ~render_template(
              "ws_popup",
              WeatherStation = WeatherStation,
              Description = Description
            ),
            options = leaflet::pathOptions(zIndex = 600)
          )
      }

      # ---- Layer controls ----
      map |>
        leaflet::addLayersControl(
          baseGroups = c("Street Map", "Satellite"),
          overlayGroups = c("Rain Gauges")
        ) |>
        leaflet::hideGroup("Rain Gauges")
    })

    # ---- Dynamic site markers ----
    observe({

      df <- dat_filt()

      proxy <- leaflet::leafletProxy(
        "map",
        session = session
      )

      # Only clear sites and dynamic controls
      # Watersheds, rivers, and rain gauges remain untouched
      proxy |>
        leaflet::clearGroup("sites") |>
        leaflet::clearControls()

      # ---- No data ----
      if (is.null(df) || nrow(df) == 0) {
        proxy |>
          leaflet::addControl(
            html = paste0(
              "<b style='color:red;font-size:1.2rem;'>",
              "No data available for this selection ",
              "— please change filters.</b>"
            ),
            position = "topright"
          )

        return()
      }

      # ---- Site markers ----
      proxy |>
        leaflet::addCircleMarkers(
          data = df,
          lng = ~Longitude,
          lat = ~Latitude,
          color = "black",
          weight = 1,
          fillColor = ~Color,
          radius = 7,
          fillOpacity = 1,
          group = "sites",
          options = leaflet::pathOptions(zIndex = 800),
          popup = ~render_template(
            "leaflet_popup",
            Result = Result,
            Site = Site,
            WaterBody = WaterBody,
            SiteDescription = SiteDescription,
            Time = Time,
            Precip72Hr = Precip72Hr,
            HoursDry = HoursDry,
            Color = Color,
            WeatherStation = WeatherStation
          )
        )

      # ---- Legend ----
      proxy |>
        leaflet::addControl(
          html = htmltools::HTML(
            build_leaflet_legend(watersheds = 1)
          ),
          position = "bottomleft"
        )
    })
  })
}

## To be copied in the UI
# mod_leaflet_map_ui("leaflet_map_1")

## To be copied in the server
# mod_leaflet_map_server("leaflet_map_1")


