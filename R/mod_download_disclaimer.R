#' download_disclaimer UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_download_disclaimer_ui <- function(id) {
  ns <- NS(id)
   tagList(
    bs4Dash::bs4Card(
      title = "Data Disclaimer",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      closable = FALSE,
      collapsible = TRUE,
      collapsed = FALSE,
      shiny::uiOutput(ns("text"))
    )
  )
}
    
#' download_disclaimer Server Functions
#'
#' @noRd 
    mod_download_disclaimer_server <- function(id){
  moduleServer(id, function(input, output, session){

    output$text <- renderUI({

      shiny::HTML(
        glue::glue("
<div style='
  background:#FFF9E8;
  border:1px solid #E8D89B;
  border-left:5px solid #D4A017;
  border-radius:12px;
  padding:16px 18px;
  font-family:Poppins, Arial, sans-serif;
  color:#3F3A2B;
  line-height:1.5;
'>

  <div style='
    font-weight:600;
    font-size:1rem;
    margin-bottom:8px;
    color:#7A5B00;
  '>
    <i class=\"fa-solid fa-circle-exclamation\" style=\"margin-right:6px;\"></i>
    Data Availability Notice
  </div>

  <div style='font-size:0.95rem;'>

    This download contains the requested monitoring results, but it does
    <strong>not</strong> include laboratory or field collection flags.

    <br><br>

    Missing values do not necessarily indicate that data are unavailable.
    They may result from laboratory or field quality assurance procedures,
    sample collection issues, or because the selected parameter was not
    routinely collected at a particular monitoring location.

    <br><br>

    If you require a more complete dataset, including laboratory and field
    flags or additional monitoring information, please submit an official
    data request to
    <a href='mailto:esauer@mmsd.com'>Beth Sauer (esauer@mmsd.com)</a>.

  </div>

</div>
")
      )

    })

  })
}
## To be copied in the UI
# mod_download_disclaimer_ui("download_disclaimer_1")
    
## To be copied in the server
# mod_download_disclaimer_server("download_disclaimer_1")
