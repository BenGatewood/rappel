library(ggplot2)

stepsDay <- group_by(steps, day = floor_date(startDate, "day"))

distanceDay <- group_by(distance, day = floor_date(startDate, "day"))

combinedDay <- bind_rows(stepsDay, distanceDay)

combinedDaySum <- summarise(group_by(combinedDay, day, type), sum(value))

t <- ggplot(filter(combinedDaySum, year(day) == 2017), 
            aes(day, `sum(value)`, col = type)) +
        geom_point() + geom_smooth(method = "lm", se = FALSE)

print(t)

ggsave("t.png")