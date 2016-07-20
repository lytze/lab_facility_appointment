require(shiny)
require(shinysky)
require(shinythemes)
shinyUI(
    fluidPage(theme = shinytheme("united"),
              tags$head(
                  tags$title('HE LAB TOOLs - Facility Online Appointment System'),
                  tags$link(rel = "stylesheet", href = "lib/font-awesome/css/font-awesome.min.css"),
                  tags$script(type = 'text/javascript', src = 'custom.js'),
                  tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
              ),
              div(class = 'holder',
                  div(class = 'panel panel-primary',
                      div(class = 'panel-heading', h4('HE LAB TOOLs'), span('Facility Online Appointment System')),
                      div(class = 'panel-body',
                          div(class = 'row',
                              div(class = 'col-xs-12 col-sm-6',
                                  div(class = 'row date-toggle',
                                      div(class = 'col-xs-3',
                                          actionLink('prevDay', '< PREV')
                                      ),
                                      uiOutput(class = 'col-xs-6', outputId = 'dateTime'),
                                      div(class = 'col-xs-3',
                                          actionLink('nextDay', 'NEXT >')
                                      )
                                  ),
                                  div(class = 'row time-table-handler', id = 'timetableHandler',
                                      div(class = 'col-xs-6',
                                          div(class = 'time-block', id = 'timeblock1', '08:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock2', '08:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock3', '09:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock4', '09:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock5', '10:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock6', '10:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock7', '11:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock8', '11:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock9', '12:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock10', '12:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock11', '13:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock12', '13:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock13', '14:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock14', '14:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock15', '15:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock16', '15:30', span(class = 'time-block-info'))
                                      ),
                                      div(class = 'col-xs-6',
                                          div(class = 'time-block', id = 'timeblock17', '16:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock18', '16:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock19', '17:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock20', '17:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock21', '18:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock22', '18:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock23', '19:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock24', '19:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock25', '20:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock26', '20:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock27', '21:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock28', '21:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock29', '22:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock30', '22:30', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock31', '23:00', span(class = 'time-block-info')),
                                          div(class = 'time-block', id = 'timeblock32', '23:30', span(class = 'time-block-info'))
                                      )
                                  )
                              ),
                              div(class = 'col-xs-12 col-sm-6',
                                  wellPanel(
                                      selectInput('machineID', 'Choose Machine',
                                                  c('PCR Machine - Left' = 'A', 'PCR Machine - Middle' = 'B', 'PCR Machine - Right' = 'C',
                                                    'Dissection Microscope - Left' = 'D', 'Dissection Microscope - Right' = 'E',
                                                    'Flourencent Microscope' = 'F')),
                                      sliderInput('startTime', 'Choose Appointment Time',
                                                  min = 8, max = 24, step = 0.5,
                                                  (value = as.numeric(format(Sys.time(), '%H'))) +
                                                      ceiling(as.numeric(format(Sys.time(), '%M'))/ 30)/2 + c(0, 1),
                                                  width = '100%'),
                                      textInput('userName', 'Name of User', width = '100%'),
                                      textInput('veriInfo', span('Verification Code',
                                          a(class = 'fa fa-question-circle', `data-toggle` = 'tooltip',
                                            `data-title` = 'Upon canceling/editing appointments, exact text is required')),
                                          value = 'verify', width = '100%'),
                                      div(class = 'form-group',
                                          actionButton('addApt', 'Make Appointment', styleclass = 'primary', style = 'width:49%;'),
                                          actionButton('editApt', 'Edit', styleclass = 'info', style = 'width:24%;'),
                                          actionButton('cancelApt', 'Cancel', styleclass = 'info', style = 'width:24%;')
                                      ),
                                      singleton(tags$head(tags$script(src = "shinysky/shinyalert.js"))),
                                      tags$div(id = 'popAlert', class = 'shinyalert alert out', 'data-alert' = 'alert',
                                               'click-hide' = FALSE, 'data-auto-close-after' = 4, style = 'display:none;'),
                                      uiOutput('addiInfo')
                                  )
                              )
                          )
                      )
                  ),
                  br(),
                  p('This site is developed by',
                    a(tags$i(class = 'fa fa-github'), 'Lytze', href = 'https://github.com/lytze', target = '_blank',
                      `data-toggle` = 'tooltip', `data-title` = 'Find Lytze on GitHub'),
                    'with',
                    a('R-Shiny', href = 'shiny.rstudio.com/', target = '_blank',
                      `data-toggle` = 'tooltip', `data-title` = 'R-Shiny Homepage')),
                  tags$script(type = 'text/javascript', src = 'tooltip-regist.js')
              ),
              tags$footer(
                  tags$script(type = 'text/javascript', src = 'time-table-selected.js')
              )
    )
)