ui <- navbarPage(
  
  id = "main_page",
  
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
  
  title = div(class="mycontainer", img(src="white_logo.png", class="lillylogo")),
  
  tabPanel(title = "Home",
           div(class="mycontainer",
             fluidRow(
               column(12, class="title_holder",
                      div(id="teal_title", "teal Marketplace"),
                      div(id="teal_subtitle", "Streamlined analytics for smarter clinical trials."),
                      actionButton(inputId = "getstarted", label = "Get Started")
                      )))),
  tabPanel(title = "My Application", div(id="my_teal_application"))
)
