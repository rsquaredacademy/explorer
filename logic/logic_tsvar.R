observe({
    updateSelectInput(session,
      inputId = "var_tsvartest1",
      choices = names(data()),
      selected = '')
    updateSelectInput(session,
      inputId = "var_tsvartest2",
      choices = names(data()),
      selected = '')
    updateSelectInput(session,
      inputId = "var_tsvartestg1",
      choices = names(data()),
      selected = '')
    updateSelectInput(session,
      inputId = "var_tsvartestg2",
      choices = names(data()),
      selected = '')
})

observeEvent(input$finalok, {
    num_data <- final()[, sapply(final(), is.numeric)]
    f_data <- final()[, sapply(final(), is.factor)]
    if (is.null(dim(num_data))) {
            k <- final() %>% map(is.numeric) %>% unlist()
            j <- names(which(k == TRUE))
            numdata <- tibble::as_data_frame(num_data)
            colnames(numdata) <- j
            updateSelectInput(session, 'var_tsvartest1',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'var_tsvartest2',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'var_tsvartestg1',
              choices = names(numdata), selected = names(numdata))
        } else if (ncol(num_data) < 1) {
             updateSelectInput(session, 'var_tsvartest1',
              choices = '', selected = '')
             updateSelectInput(session, 'var_tsvartest2',
              choices = '', selected = '')
             updateSelectInput(session, 'var_tsvartestg1',
              choices = '', selected = '')
        } else {
             updateSelectInput(session, 'var_tsvartest1', choices = names(num_data))
             updateSelectInput(session, 'var_tsvartest2', choices = names(num_data))
             updateSelectInput(session, 'var_tsvartestg1', choices = names(num_data))
        }
    if (is.null(dim(f_data))) {
        k <- final() %>% map(is.factor) %>% unlist()
        j <- names(which(k == TRUE))
        fdata <- tibble::as_data_frame(f_data)
        colnames(fdata) <- j
        updateSelectInput(session, inputId = "var_tsvartestg2",
            choices = names(fdata))
        } else {
          updateSelectInput(session, 'var_tsvartestg2', choices = names(f_data))
        }
})

d_tsvartest <- eventReactive(input$submit_tsvartest, {
	validate(need((input$var_tsvartest1 != '' & input$var_tsvartest2 != ''), 'Please select variables.'))
  req(input$var_tsvartest1)
  req(input$var_tsvartest2)
  data <- final()[, c(input$var_tsvartest1, input$var_tsvartest2)]
  k <- var_test_shiny(data, as.character(input$var_tsvartest1), as.character(input$var_tsvartest2), 
      alternative = input$tsvartest_type)
  k
})

d_tsvartestg <- eventReactive(input$submit_tsvartestg, {
	validate(need((input$var_tsvartestg1 != '' & input$var_tsvartestg2 != ''), 'Please select variables.'))
  req(input$var_tsvartestg1)
  req(input$var_tsvartestg2)
  data <- final()[, c(input$var_tsvartestg1, input$var_tsvartestg2)]
  validate(need(nlevels(data[, 2]) == 2, 'Please select a binary variable.'))
  k <- var_test(data[, 1], group_var = data[, 2], alternative = input$tsvartestg_type)
  k
})

output$tsvartest_out <- renderPrint({
  d_tsvartest()
})

output$tsvartestg_out <- renderPrint({
  d_tsvartestg()
})
