tabPanel('Summary', value = 'tab_summary',
         
    fluidPage(
        
        fluidRow(

            column(3, align = 'right', 

                br(),
                br(), 
                h5('Variable:')

            ),
            
            column(3, align = 'left',

                br(),
                   
                selectInput("var_summary", label = '',
                               choices = "", selected = "", width = '150px'
                ),
                bsTooltip("var_summary", "Select a variable.",
                              "bottom", options = list(container = "body"))

            ),

            column(3, align = 'right', 

                br(),
                br(), 
                h5('Filter')

            ),

            column(3, align = 'left',

                br(),
                   
                sliderInput("filter_summary", label = '', min = 0, max = 100, step = 10, value = c(20, 80), width = '150px'),
                bsTooltip("filter_summary", "Filter data using th slider.",
                              "bottom", options = list(container = "body"))

            )

        ),

        fluidRow(

            column(12, align = 'center',

                # checkbox for filtering data
                checkboxInput('summary_filter', 'Filter Data', FALSE),

                # conditional panel for filtering data
                conditionalPanel(

                    condition = "input.summary_filter == true",

                    column(6, align = 'center', 

                        selectInput("var_fsummary", label = 'Filter Variable:',
                               choices = "", selected = "", width = '150px'
                        ),
                        bsTooltip("var_fsummary", "Select a variable to filter the data.",
                              "bottom", options = list(container = "body"))

                    ),

                    column(3, align = 'center',

                        checkboxGroupInput(inputId = 'check_summary', label = '', choices = "", selected = "", width = '150px'),
                        bsTooltip("check_summary", "Filter data.",
                              "left", options = list(container = "body"))


                    )
                )

            )

        ),

        fluidRow(


            column(12, align = 'center',

                br(),
                br(),
                
                actionButton(inputId = 'submit_summary', label = 'Submit', width = '120px', icon = icon('check')),
                bsTooltip("submit_summary", "Click here to view summary statistics.",
                              "bottom", options = list(container = "body"))

            )

        ),

        fluidRow(

            br(),
            br(),
            
            column(12, align = 'center',
                   
                verbatimTextOutput('summary')
                
            )
            
        ),

        fluidRow(

            column(12, align = 'center',

                br(),

                downloadButton('download_summary', 'Download'),
                bsTooltip("download_summary", "Click here to download summary statistics.",
                              "top", options = list(container = "body")),

                br(),
                br()

            )

        ),

        fluidRow(

            column(4, align = 'left',

                br(),
                br(),
                img(src = 'screen.png', height = 50, width = 50),
                actionButton(inputId = 'summary_screen', label = 'Screen', width = '120px'),
                bsTooltip("summary_screen", "Click here to screen data.",
                              "top", options = list(container = "body")),

                br(),
                br()

            ),

            column(4, align = 'center',

                br(),
                br(),
                img(src = 'home_icon.png', height = 50, width = 50),
                actionButton(inputId = 'summary_home', label = 'Home', width = '120px'),
                bsTooltip("summary_home", "Click here to return to home.",
                              "top", options = list(container = "body")),
                br(),
                br()

            ),

            column(4, align = 'right',

                br(),
                br(),
                img(src = 'frequency.png', height = 50, width = 50),
                actionButton(inputId = 'summary_fqual', label = 'Frequency - I', width = '120px'),
                bsTooltip("summary_fqual", "Click here to view frequency table of categorical variables.",
                              "top", options = list(container = "body")),

                br(),
                br()

            )



        )
                

        
        
    )
    
)