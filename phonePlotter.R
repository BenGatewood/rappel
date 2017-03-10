library(ggplot2)

`%between%` <- function(x,rng) x>rng[1] & x<rng[2]

stepsDay <- group_by(steps, day = floor_date(startDate, "day"))

distanceDay <- group_by(distance, day = floor_date(startDate, "day"))

combinedDay <- bind_rows(stepsDay, distanceDay)

combinedDaySum <- summarise(group_by(combinedDay, day, type), sum(value))

bind_rows(steps, distance) %>%
        filter(isoweek(startDate) == 9 & year(startDate) == 2017) %>%
        arrange(startDate) -> lastWeek

g <- ggplot(lastWeek, aes(startDate, value, col = type)) +
        geom_point()

glommed <- data.frame(startDate = lastWeek$startDate,
                      steps = filter(lastWeek, type == "steps")$value,
                      distance = filter(lastWeek, type == "distance")$value)


print(t)



