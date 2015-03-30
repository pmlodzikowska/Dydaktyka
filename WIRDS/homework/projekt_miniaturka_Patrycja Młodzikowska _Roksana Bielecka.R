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
matura2011 %>% 
  filter(zdana_matura == 'TRUE') %>% # uzyskujemy tylko informacje o zdanej maturze 
  select(plec, wojewodztwo, procent) %>% # wybieramy interesujace nas kolumny  
  ggplot(data=., aes(x=wojewodztwo, y=procent, fill=plec, colour=plec)) + 
  geom_bar(stat='identity', position="dodge", colour='black') +
  geom_text(aes(label=round(procent, digits = 1)), vjust=-1, position=position_dodge(.8), size=4, colour='black') +
  theme_bw() +
  xlab('Nazwa województwa') +
  ylab('Procent zdawalności matury z matematyki podstawowej w 2011r.') +
  ggtitle('     Zdawalność matury z matematyki podstawowej
        w województwach lubuskim i wielkopolskim
          w 2011 roku w zależności od płci ')


