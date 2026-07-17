#' plot_filter_sum_tbl UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_plot_filter_sum_tbl_ui <- function(id) {
  ns <- NS(id)
  tagList()
}
    
#' plot_filter_sum_tbl Server Functions
#'
#' @noRd 
mod_plot_filter_sum_tbl_server <- function(id, selected_inputs, param){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    dat <- load_survey_data()

shiny::reactive({

  year <- selected_inputs()[["years"]]
  site <- selected_inputs()[["site"]]

  survey_data <- dat |>
    dplyr::filter(
      SiteCode == site,
      LabelName == param
    ) |>
    dplyr::collect()

  dplyr::bind_rows(

    # Selected year only
    survey_data |>
      dplyr::filter(as.character(Year) == as.character(year)) |>
      dplyr::mutate(CurrentYear = as.character(year)),

    # Complete dataset, including the selected year
    survey_data |>
      dplyr::mutate(CurrentYear = "Other")

  ) |>
    dplyr::group_by(CurrentYear, LabelName) |>
    dplyr::summarise(
      Maximum = max(ReadingNum, na.rm = TRUE),
      Mean    = mean(ReadingNum, na.rm = TRUE),
      Median  = median(ReadingNum, na.rm = TRUE),
      Minimum = min(ReadingNum, na.rm = TRUE),
      .groups = "drop"
    ) |>
    tidyr::pivot_longer(
      cols = c("Maximum", "Mean", "Median", "Minimum")
    ) |>
    tidyr::pivot_wider(
      names_from = CurrentYear,
      values_from = value
    )
    })
    })
}
    
## To be copied in the UI
# mod_plot_filter_sum_tbl_ui("plot_filter_sum_tbl_1")
    
## To be copied in the server
# mod_plot_filter_sum_tbl_server("plot_filter_sum_tbl_1")
