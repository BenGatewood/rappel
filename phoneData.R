library(XML)
library(plyr)
library(lubridate)

rawXML <- xmlParse("./apple_health_export/export.xml")

nodes <- getNodeSet(rawXML, "//Record")

xmlList <- xmlToList(rawXML)

phoneData <- ldply(xmlList[4:length(xmlList) - 1])

