context("checks weather station status")

test_that("modem is accessible", {
  
  expect_error(httr::GET("http://166.153.133.121:9191/"),NA)
})

test_that("datalogger website is accessible", {
  
  expect_error(httr::GET("http://166.153.133.121/?command=NewestRecord&table=Status"),NA)
})

test_that("datalogger is sending data to Weather Underground", {
  
  page_content <- read_html("https://www.wunderground.com/dashboard/pws/KAZSANSI14")
  
  tables <- page_content %>% 
    html_nodes("table") %>% 
    html_table(fill = TRUE)
  
  expect_true(!is.na(tables[[1]]$Average[1]))
  expect_error(tables[[1]]$Average[1],NA)
})

test_that("phenocam is accessible", {
  
    if(substr(format(Sys.time(),tz = "MST",usetz=TRUE), 12, 16) > "12:00" &&
     substr(format(Sys.time(),tz = "MST",usetz=TRUE), 12, 16) < "15:30") 
    {
  expect_error(httr::GET("http://166.153.133.121:5555/popup.html?0"),NA) 
    } 
})

test_that("phenocam is sending pics", {
  
  page_content <- read_html("https://phenocam.nau.edu/webcam/sites/portal/")
  pos <- regexpr('Last Date:', page_content)
  last_date <- as.Date(substr(page_content, pos+20, pos+29))
  expect_true(last_date - Sys.Date() <=1)
})
