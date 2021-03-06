observe({
    updateSelectInput(session, 'var_chict1', choices = names(data()))
    updateSelectInput(session, 'var_chict2', choices = names(data()))
})

observeEvent(input$finalok, {
    f_data <- final()[, sapply(final(), is.factor)]
    if (is.null(dim(f_data))) {
        k <- final() %>% map(is.factor) %>% unlist()
        j <- names(which(k == TRUE))
        fdata <- tibble::as_data_frame(f_data)
        colnames(fdata) <- j
        updateSelectInput(session, 'var_chict1', choices = names(fdata))
    		updateSelectInput(session, 'var_chict2', choices = names(fdata))
        } else {
          updateSelectInput(session, 'var_chict1', choices = names(f_data))
    			updateSelectInput(session, 'var_chict2', choices = names(f_data))
        }
})


d_chict <- eventReactive(input$submit_chict, {
	validate(need((input$var_chict1 != '' & input$var_chict2 != ''), 'Please select variables.'))
    data <- final()[, c(input$var_chict1, input$var_chict2)]
})

output$chict_out <- renderPrint({
  chisq_test(d_chict()[, 1], d_chict()[, 2])
})
