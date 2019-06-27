context("checks weather station status")

test_that("modem is accessible", {
  
  expect_error(httr::GET("http://166.153.133.121:9191/"),NA)
})

test_that("datalogger website is accessible", {
  
  expect_error(httr::GET("http://166.153.133.121/?command=NewestRecord&table=Status"),NA)
})

test_that("datalogger is sending data to Weather Underground", {
  
  page_content <- httr::content(httr::GET("https://www.wunderground.com/dashboard/pws/KAZSANSI14"),"text")
  expect_true(grep("Online", page_content) >0)
})

test_that("phenocam is accessible", {
  
  expect_error(httr::GET("http://166.153.133.121:5555/"),NA) 

})

test_that("phenocam is sending pics", {
  
  page_content <- httr::content(httr::GET("https://phenocam.sr.unh.edu/webcam/sites/portal/"),"text")
  pos <- regexpr('Last Date:', page_content)
  last_date <- as.Date(substr(page_content, pos+20, pos+29))
  expect_true(last_date - Sys.Date() <=1)
})
