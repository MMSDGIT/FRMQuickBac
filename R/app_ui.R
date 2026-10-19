
#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'   DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {

  shiny::tagList(
    golem_add_external_resources(),

    tags$head(
      tags$script(src = "www/loc-map.js"),
      tags$script(
        src = "https://cdn.jsdelivr.net/npm/d3-textwrap@3/dist/d3-textwrap.min.js"
      ),
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "www/custom.css"
      )
    ),

    fresh::use_theme(bs4DashTheme),

    bs4Dash::bs4DashPage(
      title = "River Health Report",
      dark = NULL,
      help = NULL,
      fullscreen = TRUE,

      # ---- Header ----
      header = bs4Dash::bs4DashNavbar(
        title = tags$div(
      class = "river-report-brand",
      tags$div(
        class = "river-report-name",
        "River Health Report"
      ),
      tags$div(
        class = "river-report-subtitle",
        "Preliminary Water Quality Results"
      )
    ),
        skin = "light",
        br(),
        tags$a(
          href = "https://www.mmsd.com/",
          target = "_blank",
          style = "cursor: pointer;",

          tags$img(
            src = "www/mmsd_logo.jpg",
            style = "
              display: block;
              margin-left: 35px;
              width: 186px;
              transition: transform 0.15s ease, opacity 0.15s ease;
            ",
            onmouseover = "
              this.style.transform='scale(1.03)';
              this.style.opacity='0.85';
            ",
            onmouseout = "
              this.style.transform='scale(1)';
              this.style.opacity='1';
            "
          )
        )
      ),

      # ---- Sidebar ----
      sidebar = bs4Dash::bs4DashSidebar(
        skin = "dark",
        status = "primary",
        minified = TRUE,

        br(),

        tags$div(
          style = "padding: 12px 0;"
        ),

        mod_sidebar_menu_ui("sidebar_menu_1")
      ),

      # ---- Body ----
      body = bs4Dash::bs4DashBody(
        mod_dashboard_body_ui("dashboard_body_1")
      ),

      # ---- Footer ----
      footer = bs4Dash::bs4DashFooter(
        left = "MMSD River Health Report - Preliminary Water Quality Results",

        right = tags$span(
          style = "
            font-size: 0.9rem;
            color: #555;
            white-space: nowrap;
          ",
          tags$b("Most Recent Survey Date: "),
          get_most_recent_survey_date(),
          tags$b( " | Data Updated at: "),
          get_last_updated()
        )
      )
    )
  )
}
