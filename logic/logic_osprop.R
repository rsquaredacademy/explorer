observe({
    updateSelectInput(session,
                      inputId = "var_osproptest",
                      choices = names(data()),
                      selected = '')
})

observeEvent(input$finalok, {
    f_data <- final()[, sapply(final(), is.factor)]
    if (is.null(dim(f_data))) {
        k <- final() %>% map(is.factor) %>% unlist()
        j <- names(which(k == TRUE))
        fdata <- tibble::as_data_frame(f_data)
        colnames(fdata) <- j
        updateSelectInput(session, inputId = "var_osproptest",
            choices = names(fdata))
        } else {
          updateSelectInput(session, 'var_osproptest', choices = names(f_data))
        }
})

d_osproptest <- eventReactive(input$submit_osproptest, {
  req(input$var_osproptest)
  data <- final()[, c(input$var_osproptest)]
  validate(need(nlevels(data) == 2, 'Please select a binary variable.'))
  out <- prop_test(data, input$osproptest_prob, input$osproptest_type)
  out 
})

output$osproptest_out <- renderPrint({
  d_osproptest()
})

ospropcalc <- eventReactive(input$submit_ospropcalc, {
  prop_test(n = input$n_ospropcalc, phat = as.numeric(input$p_ospropcalc), prob = input$prob_ospropcalc,
      alternative = input$ospropcalc_type)
})

output$ospropcalc_out <- renderPrint({
  ospropcalc()
})



