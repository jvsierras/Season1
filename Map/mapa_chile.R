rm(list=ls())
library(readxl)
library(ggplot2)
library(scales)

load("Map/ShapeChileRegiones.RData")
unique(ShapeChileRegiones$id)

pobreza <- read_excel("Map/Pobreza_2020Chile.xlsx")

pobreza_mapa <- merge(ShapeChileRegiones, pobreza, by = "id")

mapa <- ggplot(pobreza_mapa) + 
  geom_polygon(aes(x=long, y=lat, 
                   group = group, 
                   fill = Pobreza/100),
               colour ="white",
               size = 0.1) +
  labs(x="",y="", fill = "",
       title="Incidencia de pobreza de Chile",
       caption = "@hanwengutierrez") +
  scale_fill_gradient2(
    low ='chartreuse4', 
    mid="darkgoldenrod2", 
    high='coral2',
    midpoint=0.11,
    labels = percent,
    na.value="white")  + 
  theme_void() + 
  theme(plot.title=element_text(size=16, hjust=-1, face="bold", vjust=-1)) 

ggsave(mapa, filename = "Map/mapa_chile.jpeg", width = 10, height = 16, units = "cm")
