library(ggplot2)
library(scales)
library(dplyr)

df <- readRDS("data/data.rds")

## Create MSA Names List
msa.names <- df[!duplicated(df$series_id),]$msa.name
msa.names <- msa.names[order(msa.names)]

## Create base plot

## Jan 2000 = 100
plot1 <- ggplot(df, aes(x=date, y=y2k.emp.indx, group = series_id)) + geom_line(color=alpha("#222222", .1)) + scale_x_date() + theme(axis.title.x = element_blank(), axis.title.y = element_blank())

## Nov 2007 = 100
plot2 <- ggplot(df, aes(x=date, y=emp.indx, group = series_id)) + geom_line(color=alpha("#222222", .1)) + scale_x_date() + theme(axis.title.x = element_blank(), axis.title.y = element_blank())
