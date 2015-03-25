library(XLConnect)
library(dplyr)
library(tidyr)
library(ggplot2)

matura2011 <- matury %>% 
  select(rok, plec, wojewodztwo, matura_nazwa, wyniki_matur) %>% 
  filter(rok=='2011', 
         wojewodztwo==c('wielkopolskie','lubuskie'), 
         matura_nazwa==c('matematyka podstawowa')) %>% 
  mutate(zdana_matura = (wyniki_matur >= 15)) %>% 
  count(rok, plec, wojewodztwo, matura_nazwa, zdana_matura) %>%  # grupowanie po parametrach w nawiasach. dostaniemy kolumnę "n" która zawiera ilosc osob ktore zdały i nie zdały matury z mat. podstawowej  
  mutate(procent = n/sum(n) * 100) # nowa kolumna procent ktora zawiera infomracje jaki procent kobiet/mezczyzn zdalo i nie zdało matury

#wykres
matura2010 %>% 
  filter(zdana_matura == 'TRUE') %>% # uzyskujemy tylko informacje o zdanej maturze 
  select(plec, wojewodztwo, procent) %>% # wybieramy interesujace nas kolumny  
  ggplot(data=., aes(x=wojewodztwo, y=procent, fill=plec, colour=plec)) + 
  geom_bar(stat='identity', position="dodge", colour='black') +
  theme_bw() +
  xlab('Województwo') +
  ylab('Zdawalność matury z matematyki podstawowej w 2010r') +
  ggtitle('     Procent zdawalności matury 
          w naszych województwach 
          w 2010r w zależności od płci')

