# observe({
#     updateSelectInput(session = session,
#                       inputId = "var_summary",
#                       choices = names(data()))
# })

observeEvent(input$finalok, {
    num_data <- final()[, sapply(final(), is.numeric)]
    if (is.null(dim(num_data))) {
        k <- final() %>% map(is.numeric) %>% unlist()
        j <- names(which(k == TRUE))
        numdata <- tibble::as_data_frame(num_data)
        colnames(numdata) <- j
        updateSelectInput(session, inputId = "var_summary",
            choices = names(numdata), selected = names(numdata))
        updateSliderInput(session = session, 
                        inputId = 'filter_summary',
                        min = min(numdata),
                        max = max(numdata),
                        step = 1,
                        value = c(min(numdata), max(numdata))
        )
      } else if (ncol(num_data) < 1) {
        updateSelectInput(session, inputId = "var_summary",
            choices = '', selected = '')
        updateSliderInput(session = session, 
                        inputId = 'filter_summary',
                        value = '')
      } else {
          updateSelectInput(session, 'var_summary', 
            choices = names(num_data), selected = names(num_data))
          updateSliderInput(session = session, 
                        inputId = 'filter_summary',
                        min = min(num_data),
                        max = max(num_data),
                        step = 1,
                        value = c(min(num_data), max(num_data))
          )
      }

    # updateSelectInput(session = session,
    #                   inputId = "var_fsummary",
    #                   choices = names(f_data),
    #                   selected = names(f_data))

    # updateCheckboxGroupInput(session,
    #                          inputId = 'check_summary',
    #                          choices = levels(f_data[, 1]),
    #                          selected = levels(f_data[, 1])
    # )
})

# f_data <- reactive({
#   final()[, sapply(final(), is.factor)]
# })

# # filter data
# f_summary <- reactive({
#   data <- final()[, input$var_fsummary]
# })


# selected data
d_summary <- eventReactive(input$submit_summary, {
  validate(need(input$var_summary != '', 'Please select a variable.'))
  req(input$var_summary)
  data <- final()[, c(input$var_summary)]
})


# update filter slider
observe({
  updateSliderInput(session = session, 
                      inputId = 'filter_summary',
                      min = min(d_summary()),
                      max = max(d_summary()),
                      step = 1,
                      value = c(min(d_summary()), max(d_summary()))
    )
})

# # filter categorical data
# observe({
#   updateCheckboxGroupInput(session,
#                            inputId = 'check_summary',
#                            choices = levels(f_summary()),
#                            selected = levels(f_summary())
#   )
# })

# # filters
fil_data <- reactive({

  min_data <- input$filter_summary[1]
  max_data <- input$filter_summary[2]

  # f_data <- d_summary()[d_summary()[, 1] >= min_data & d_summary()[, 1] <= max_data, 1]
  f_data <- d_summary()[d_summary() >= min_data & d_summary() <= max_data]
})




# output
output$summary <- renderPrint({
    summary_stats(fil_data())
})

