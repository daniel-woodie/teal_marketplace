server <- function(input, output, session) {
  
  marketplaceCheckboxInput <- function(inputId, label_icon = "r-project", 
                                       icon_height = "6rem", icon_fill = "black",
                                       label_text = "Data Table", 
                                       thumbnail_img = "module_thumbnails/data_table_thumbnail.png", ...) {
    
    div(class="gallery-container tooltip",
        checkboxInput(inputId = "module_include_data_table", 
                      label = list(fa(name = label_icon, fill = icon_fill, height = icon_height),
                                   # bsicons::bs_icon(label_icon, size = icon_size), 
                                   HTML(paste0('<br>', 
                                               label_text, 
                                               '<span class="tooltiptext"><img src="', 
                                               thumbnail_img, 
                                               '" alt="', label_text, '"></span>')))))
    
  }
  
  params <- reactiveValues(adam_data_to_include = NULL)
  
  data_modal <- function(selected_data_choices = NULL) {
    
      modalDialog(
        title = NULL,
        footer = NULL,
        tabsetPanel(type = "pills",
                    tabPanel("Use Synthetic Data",
                             list(fluidRow(column(width = 12, style = "text-align: center;", "Select a few ADaM standard datasets to begin.")),
                                  fluidRow(column(width = 6, offset = 3,
                                                  selectInput(inputId = "adam_data_to_include",
                                                              selected = selected_data_choices,
                                                              label = "", choices = c("adsl", "adab", "adae", "adaette",
                                                                                      "adcm", "addv", "adeg", "adex", "adhy",
                                                                                      "adlb", "admh", "adpc", "adpp", "adqlqc",
                                                                                      "adqs", "adrs", "adsub", "adtr", "adtte",
                                                                                      "advs", "adqlqc"), multiple = TRUE))),
                                  fluidRow(column(width = 4, offset = 8, div(class="parent",
                                                                             actionButton(inputId = "cancel", label = "Cancel"),
                                                                             actionButton(inputId = "select_data", label = "Select Data")))))),
                    tabPanel("Import Data",
                             fluidRow(column(width = 12, style = "text-align: center;", "This capability is not yet enabled.")))
        )
        
      )
  }
  
  observeEvent(input$getstarted, {showModal(data_modal(selected_data_choices = params$adam_data_to_include))})
  
  observeEvent(input$select_data, {
    
    params$adam_data_to_include <- input$adam_data_to_include
    
    removeModal()
    
    showModal(modalDialog(
      size = "l",
      title = NULL,
      footer = NULL,
      list(fluidRow(column(width = 12, style = "text-align: center;", "Select which modules you'd like to include.")),
           fluidRow(
                    column(width = 4, 
                           marketplaceCheckboxInput(inputId = "module_include_file_viewer",
                                                    label_icon = "file",
                                                    icon_size = "6rem",
                                                    label_text = "File Viewer",
                                                    thumbnail_img = "module_thumbnails/data_table_thumbnail.png")
                           ),
                    column(width = 4, 
                           marketplaceCheckboxInput(inputId = "module_include_variable_browser",
                                                    label_icon = "magnifying-glass",
                                                    icon_size = "6rem",
                                                    label_text = "Variable Browser",
                                                    thumbnail_img = "module_thumbnails/data_table_thumbnail.png")
                    ),
                    column(width = 4, 
                           marketplaceCheckboxInput(inputId = "module_include_data_table",
                                                    label_icon = "table",
                                                    icon_size = "6rem",
                                                    label_text = "Data Table",
                                                    thumbnail_img = "module_thumbnails/data_table_thumbnail.png")
                    )),
           fluidRow(
             column(width = 4, 
                    marketplaceCheckboxInput(inputId = "module_include_km",
                                             label_icon = "chart-gantt",
                                             icon_size = "6rem",
                                             label_text = "Kaplan Meier",
                                             thumbnail_img = "module_thumbnails/data_table_thumbnail.png")
             ),
             column(width = 4, 
                    marketplaceCheckboxInput(inputId = "module_include_ancova",
                                             label_icon = "chart-simple",
                                             icon_size = "6rem",
                                             label_text = "ANCOVA",
                                             thumbnail_img = "module_thumbnails/data_table_thumbnail.png")
             ),
             column(width = 4, 
                    marketplaceCheckboxInput(inputId = "module_include_mmrm",
                                             label_icon = "circle-user",
                                             icon_size = "6rem",
                                             label_text = "MMRM",
                                             thumbnail_img = "module_thumbnails/data_table_thumbnail.png")
             )),
           fluidRow(column(width = 4, offset = 8, div(class="parent", 
                                                      actionButton(inputId = "go_back_to_start", label = "Go Back"), 
                                                      actionButton(inputId = "set_parameters", label = "Set Parameters")))))
      
    ))
  })
  
  
  observeEvent(input$set_parameters, {
    
    removeModal()
    
    showModal(
      
      modalDialog(
        title = NULL,
        footer = NULL,
        size = 'l',
        list(fluidRow(column(width = 12, style = "text-align: center;", "Set the parameter values for each module.")),
             fluidRow(column(width = 12, h2("File Viewer"))),
             fluidRow(column(width = 6, textInput(inputId = "file_viewer_label", label = "Label")),
                      column(width = 6, div(class="form-group shiny-input-container",
                                            shiny::tags$label("Set Input Path"), HTML("<br>"), shinyDirButton(id = "file_viewer_input_path", label = "Input Path", title = "Testing")))),
             fluidRow(column(width = 12, h2("Variable Browser"))),
             fluidRow(column(width = 3, textInput(inputId = "variable_browser_label", label = "Label")),
                      column(width = 3, selectInput(inputId = "variable_browser_datasets_selected",
                                                    label = "Datasets", choices = c("adsl", "adab", "adae", "adaette",
                                                                            "adcm", "addv", "adeg", "adex", "adhy",
                                                                            "adlb", "admh", "adpc", "adpp", "adqlqc",
                                                                            "adqs", "adrs", "adsub", "adtr", "adtte",
                                                                            "advs", "adqlqc"), multiple = TRUE)),
                      column(width = 3, textInput(inputId = "variable_browser_pre_output", label = "Pre Output Text")),
                      column(width = 3, textInput(inputId = "variable_browser_post_output", label = "Post Output Text"))),
             fluidRow(column(width = 3, checkboxInput(inputId = "variable_browser_parent_dataname", label = "Parent Dataname"))),
             fluidRow(column(width = 12, h2("Data Table"))),
             fluidRow(column(width = 3, textInput(inputId = "data_table_label", label = "Label")),
                      column(width = 3, selectInput(inputId = "data_table_datasets_selected",
                                                    label = "Datasets", choices = c("adsl", "adab", "adae", "adaette",
                                                                                    "adcm", "addv", "adeg", "adex", "adhy",
                                                                                    "adlb", "admh", "adpc", "adpp", "adqlqc",
                                                                                    "adqs", "adrs", "adsub", "adtr", "adtte",
                                                                                    "advs", "adqlqc"), multiple = TRUE)),
                      column(width = 3, selectInput(inputId = "data_table_columns_selected",
                                                    label = "ADSL Columns", choices = c("adsl", "adab", "adae", "adaette",
                                                                                    "adcm", "addv", "adeg", "adex", "adhy",
                                                                                    "adlb", "admh", "adpc", "adpp", "adqlqc",
                                                                                    "adqs", "adrs", "adsub", "adtr", "adtte",
                                                                                    "advs", "adqlqc"), multiple = TRUE))),
             fluidRow(column(width = 3, offset = 9, div(class="parent", 
                                                        actionButton(inputId = "go_back_to_modals", label = "Go Back"), 
                                                        actionButton(inputId = "create_project", label = "Create Project")))))
        
      )
    )
  })
  
  observeEvent(input$go_back_to_start, {
    
    removeModal()
    
    showModal(data_modal(selected_data_choices = params$adam_data_to_include))
    
  })
  
  # When you click cancel, remove the modal
  observeEvent(input$cancel, {removeModal()})
  
  # When you click cancel, remove the modal & Change Tabs
  observeEvent(input$create_project, {
    
    source("create_application.R")
    
    my_app()$server()
    
    insertUI(selector = "#my_teal_application",
             where = "beforeEnd",
             ui = tagList(my_app()$ui),
             immediate = TRUE)
    
    removeModal()
    
    updateNavbarPage(session = getDefaultReactiveDomain(),
                     inputId = "main_page",
                     selected = "My Application")
    
  })
  
}
