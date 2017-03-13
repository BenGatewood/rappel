library(ggplot2)


bind_rows(steps, distance) %>%
        filter(isoweek(startDate) == 10 & year(startDate) == 2017) %>%
        arrange(startDate) -> lastWeek

today <- "2017/03/12"

todayData <- filter(lastWeek, date(startDate) == ymd(today))
todaySteps <- filter(todayData, type == "steps")
todayDistance <- filter(todayData, type == "distance")

grouped <- group_by(lastWeek, date(startDate), type)

groupedSum <- summarise(grouped, sum(value))

g <- ggplot(todayData, aes(startDate, value, col = type)) +
        geom_point(alpha = 0.75) +
        labs(x = "Start Time", y = "Value (Distance in Metres)") +
        scale_color_brewer(palette = "Dark2")

t <- ggplot(groupedSum, 
            aes(`date(startDate)`, `sum(value)`)) +
        geom_bar(stat = "identity") + 
        facet_grid(type ~ .) +
        geom_rug()

print(t)

#ggsave("./20170312.png")

