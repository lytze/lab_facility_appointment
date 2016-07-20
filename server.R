require(shiny)
require(shinysky)
require(shinythemes)
renderTimeTable <- function(expr, env = parent.frame(), quoted = FALSE) {
    exprToFunction(expr, env, quoted)
}

shinyServer(function(input, output, session) {
    today <- Sys.Date()
    qry <- reactiveValues(
        date = Sys.Date(),
        info_refresh = 0
    )
    
    observeEvent(input$prevDay, {
        qry$date <- qry$date - 1
    })
    observeEvent(input$nextDay, {
        qry$date <- qry$date + 1
    })
    output$dateTime <- renderUI({
        date_diff = qry$date - today
        if (date_diff == 0) {
            list(format(qry$date, '%Y-%m-%d %a'), tags$strong('Today'))
        } else if (date_diff == 1) {
            list(format(qry$date, '%Y-%m-%d %a'), tags$strong('Tomorrow'))
        } else if (date_diff == -1) {
            list(format(qry$date, '%Y-%m-%d %a'), tags$strong('Yesterday'))
        } else {
            format(qry$date, '%Y-%m-%d %a')
        }
    })
    output$addiInfo <- renderUI({
        if (input$machineID %in% c('A', 'B', 'C')) {
            list(
                hr(),
                h4('Additional Information',
                   tags$small(a(class = 'fa fa-question-circle', `data-toggle` = 'tooltip',
                                `data-title` = 'Detailed info makes it easier to share a run!'))),
                numericInput('tubeNum', 'Number of Samples', value = NA),
                numericInput('annlTep', 'Annealing Temperature', value = NA),
                numericInput('extnTim', 'Extension Time (in sec)', value = NA),
                numericInput('cycNum', 'Number of Cycles', value = NA)
            )
        } else {
            list(
                hr(),
                textInput('addInfo', 'Additional Comment')
            )
        }
    })
    output$timetableHandler <- renderTimeTable({
        qry$info_refresh
        sel_date <- qry$date
        sel_mach <- input$machineID
        d_timetable <- paste0('machine/', sel_mach, '/', sel_date)
        if (!file.exists(d_timetable)) {
            dir.create(d_timetable)
        }
        nm_timeblock <- dir(paste0(d_timetable))
        rt <- list()
        if (length(nm_timeblock)) {
            for (i in 1:length(nm_timeblock)) {
                i <- i
                rt[[i]] <- fromJSON(paste0(d_timetable, '/', nm_timeblock[i]))
            }
        }
        rt
    })
    observeEvent(input$addApt, {
        sel_date <- qry$date
        sel_mach <- input$machineID
        d_timetable <- paste0('machine/', sel_mach, '/', sel_date)
        time_occupied <- as.numeric(dir(paste0(d_timetable)))
        time_selected <- (input$startTime - 8) * 2 + 1
        time_selected[2] <- time_selected[2] - 1
        if (any(time_occupied >= time_selected[1] & time_occupied <= time_selected[2])) {
            showshinyalert(session, 'popAlert', 'Appointment Time Conflict',
                           styleclass = 'warning')
        } else {
            if (input$userName == '') {
                showshinyalert(session, 'popAlert', 'Name of User Cannot be Empty',
                               styleclass = 'warning')
            } else {
                for (t in time_selected[1]:time_selected[2]){
                    t <- t
                    li <- list(time = t, name = input$userName, veri = input$veriInfo)
                    if (input$machineID %in% c('A', 'B', 'C')) {
                        if (!is.na(input$tubeNum)) li$samp = input$tubeNum
                        if (!is.na(input$annlTep)) li$antm = input$annlTep
                        if (!is.na(input$extnTim)) li$extn = input$extnTim
                        if (!is.na(input$cycNum)) li$cycl = input$cycNum
                    } else {
                        if (input$addInfo != '') li$addi = input$addInfo
                    }
                    writeLines(toJSON(li), paste0(d_timetable, '/', t))
                }
                qry$info_refresh <- qry$info_refresh + 1
                showshinyalert(session, 'popAlert', 'Success',
                               styleclass = 'success')
            }
        }
    })
    observeEvent(input$editApt, {
        sel_date <- qry$date
        sel_mach <- input$machineID
        d_timetable <- paste0('machine/', sel_mach, '/', sel_date)
        time_occupied <- as.numeric(dir(paste0(d_timetable)))
        time_selected <- (input$startTime - 8) * 2 + 1
        time_selected[2] <- time_selected[2] - 1
        if (!any(time_occupied >= time_selected[1] & time_occupied <= time_selected[2])) {
            showshinyalert(session, 'popAlert', 'No Exsistent Appointment Selected',
                           styleclass = 'warning')
        } else if (input$userName == '') {
            showshinyalert(session, 'popAlert', 'Name of User Cannot be Empty',
                           styleclass = 'warning')
        } else {
            cond <- T
            for (t in time_selected[1]:time_selected[2]){
                t <- t
                info <- fromJSON(paste0(d_timetable, '/', t))
                if (info$veri == input$veriInfo) {
                    li <- list(time = t, name = input$userName, veri = input$veriInfo)
                    if (input$machineID %in% c('A', 'B', 'C')) {
                        if (!is.na(input$tubeNum)) li$samp = input$tubeNum
                        if (!is.na(input$annlTep)) li$antm = input$annlTep
                        if (!is.na(input$extnTim)) li$extn = input$extnTim
                        if (!is.na(input$cycNum)) li$cycl = input$cycNum
                    } else {
                        if (input$addInfo != '') li$addi = input$addInfo
                    }
                    writeLines(toJSON(li), paste0(d_timetable, '/', t))
                } else {
                    cond <- F
                }
            }
            qry$info_refresh <- qry$info_refresh + 1
            if (cond) {
                showshinyalert(session, 'popAlert', 'Success',
                               styleclass = 'success')
            } else {
                showshinyalert(session, 'popAlert', 'Not All Cases are Succesfully Edited',
                               styleclass = 'warning')
            }
        }
    })
    observeEvent(input$cancelApt, {
        sel_date <- qry$date
        sel_mach <- input$machineID
        d_timetable <- paste0('machine/', sel_mach, '/', sel_date)
        time_occupied <- as.numeric(dir(paste0(d_timetable)))
        time_selected <- (input$startTime - 8) * 2 + 1
        time_selected[2] <- time_selected[2] - 1
        if (!any(time_occupied >= time_selected[1] & time_occupied <= time_selected[2])) {
            showshinyalert(session, 'popAlert', 'No Exsistent Appointment Selected',
                           styleclass = 'warning')
        } else {
            cond <- T
            for (t in time_selected[1]:time_selected[2]){
                t <- t
                info <- fromJSON(paste0(d_timetable, '/', t))
                if (info$veri == input$veriInfo) {
                    file.remove(paste0(d_timetable, '/', t))
                } else {
                    cond <- F
                }
            }
            qry$info_refresh <- qry$info_refresh + 1
            if (cond) {
                showshinyalert(session, 'popAlert', 'Success',
                               styleclass = 'success')
            } else {
                showshinyalert(session, 'popAlert', 'Not All Cases are Succesfully Canceled',
                               styleclass = 'warning')
            }
        }
    })
})
