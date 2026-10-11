library(shiny)
library(shinydashboard)
library(data.table)

# Sample R Code
open_connection2 <- function(host,password,user=""){
  tryCatch({open_connection(host,password,user)},
           error=function(e){return("ERROR")})
}
