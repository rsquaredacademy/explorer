observe({
    updateSelectInput(session, 'var_cochran', choices = names(data()))
})

observeEvent(input$finalok, {
    f_data <- final()[, sapply(final(), is.factor)]
    if (is.null(dim(f_data))) {
            k <- final() %>% map(is.factor) %>% unlist()
            j <- names(which(k == TRUE))
            fdata <- tibble::as_data_frame(f_data)
            colnames(fdata) <- j
            updateSelectInput(session, 'var_cochran',
              choices = names(fdata), selected = names(fdata))
        } else if (ncol(f_data) < 1) {
             updateSelectInput(session, 'var_cochran',
              choices = '', selected = '')
        } else {
             updateSelectInput(session, 'var_cochran', choices = names(f_data))
        }
 
})

d_cochran <- eventReactive(input$submit_cochran, {
	validate(need((input$var_cochran != ''), 'Please select variables.'))
  req(input$var_cochran)
  data <- final()[, c(input$var_cochran)]
  validate(need(data %>% map(nlevels) %>% `<`(3) %>% all(), 'Only binary variables must be selected.'))
  k <- cochran_test(data)
  k
})

output$cochran_out <- renderPrint({
  d_cochran()
})
