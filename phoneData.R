library(XML)
library(lubridate)

rawXML <- xmlParse("./apple_health_export/export.xml")

nodes <- getNodeSet(rawXML, "//Record")

extractRow <- function(x) {
        
        colNames <- c("type", "sourceName", "sourceVersion",
                   "unit", "creationDate", "startDate",
                   "endDate", "value")
        
        rowList <- list(type <- xmlGetAttr(x, "type"),
                        sourceName <- xmlGetAttr(x, "sourceName"),
                        sourceVersion <- xmlGetAttr(x, "sourceVersion"),
                        unit <- xmlGetAttr(x, "unit"),
                        creationDate <- xmlGetAttr(x, "creationDate"),
                        startDate <- xmlGetAttr(x, "startDate"),
                        endDate <- xmlGetAttr(x, "endDate"),
                        value <- xmlGetAttr(x, "value"))
        
        row <- data.frame(rowList)
        
        names(row) <- colNames
        
        row
}


