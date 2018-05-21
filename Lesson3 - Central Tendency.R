Pay <- c(48670, 57320, 38150, 41290, 53160, 500000)
sum(Pay)
mean(Pay)
median(Pay)

FF <-read.csv("C:/Student/Udacity/FF2.csv", header = FALSE)
V_FF <- FF[[2]]
mean(V_FF)
median(V_FF)


# install.packages("googlesheets")
# library(googlesheets)
# gs_ls()
# FF_GS <- gs_title("FF")
