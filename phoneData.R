library(XML)
library(plyr)
library(lubridate)
library(dplyr)

rawXML <- xmlParse("./apple_health_export/export.xml")

nodes <- getNodeSet(rawXML, "//Record")

xmlList <- xmlToList(rawXML)

phoneData <- ldply(xmlList[4:length(xmlList) - 1])

filter(phoneData, type == "HKQuantityTypeIdentifierStepCount") %>%
        mutate(creationDate = ymd_hms(creationDate),
               startDate = ymd_hms(startDate),
               endDate = ymd_hms(endDate),
               value = as.numeric(value),
               device = NULL,
               type = "steps") -> steps
        
filter(phoneData, type == "HKQuantityTypeIdentifierFlightsClimbed") %>%
        mutate(creationDate = ymd_hms(creationDate),
               startDate = ymd_hms(startDate),
               endDate = ymd_hms(endDate),
               value = as.numeric(value),
               device = NULL,
               type = "num_stairs") -> stairs

filter(phoneData, type == "HKQuantityTypeIdentifierDistanceWalkingRunning") %>%
        mutate(creationDate = ymd_hms(creationDate),
               startDate = ymd_hms(startDate),
               endDate = ymd_hms(endDate),
               value = as.numeric(value) * 1000,
               device = NULL,
               unit = "metres",
               type = "distance") -> distance


