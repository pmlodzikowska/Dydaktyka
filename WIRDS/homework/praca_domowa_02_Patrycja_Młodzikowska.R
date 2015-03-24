library(XLConnect)
library(dplyr)
library(tidyr)
library(ggplot2)

dane2 <- readWorksheetFromFile(file='C:/Users/Patrycja/Desktop/R/zadanieR.xlsx',
                               sheet=1)
dane_liniowy <- dane %>% gather(rok, y, -kategoria)


ggplot(data=dane_liniowy,
       aes(x=rok,
           y=y,
           colour=kategoria,
           group=kategoria,
           label=kategoria))+
  geom_point() +
  geom_line() +
  geom_text(size=3) + 
  theme_bw() + 
  xlab('Rok spisu') +
  ylab('Udzia³ w (%)') + 
  ggtitle('Udzia³...') +

  napis = paste("[" , y,"]")+
    text(x, y+0.05, napis)
  