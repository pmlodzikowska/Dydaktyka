library(XLConnect)
library(ggplot2)
library(dplyr)
fName <- "C:/Users/Patrycja/Desktop/gospodarstwa.xls"
wb <- loadWorkbook(fName)
getSheets(wb)
gosp <- readWorksheet(wb, sheet = "gospodarstwa")

gosp %>%
  mutate(ID=row_number()) %>%
  ggplot(data=., aes(x=ID, y=dochg))  + geom_point()

gosp %>%
  ggplot(data=., aes(x=dochg)) + 
  geom_histogram(binwidth=10)  + 
  scale_x_continuous(limits=c(0,20000)) +
  theme_bw() 


gosp %>%
  ggplot(data=., aes(x=dochg)) + 
  geom_histogram(binwidth=100)  + 
  scale_x_continuous(limits=c(0,10000)) +
  theme_bw()  +
  facet_wrap(~woj) # stosujemy zeby okreslic wg czego chcem grupowaæ 

gosp %>%
  ggplot(data=., aes(x=wydg)) + 
  geom_histogram(fill="NA",
                 colour="black")  + 
  scale_x_log10() +
  theme_bw()  +
  facet_wrap(~woj)

#wykres gestosci

gosp %>% # dzialamy na tym zbiorze gosp
  ggplot(data=., aes(x=dochg)) + 
  geom_density() +
  theme_bw() +
  scale_x_continuous(limits=c(0,20000))

gosp<-gosp %>% 
  mutate(klm=factor(x=klm,
                    levels=6:1, 
                    labels=c("wieœ",
                             "<20",
                             "[20,100]",
                             "[100,200]", 
                             "[200,500]",
                             ">500"),
                    ordered=T))

gosp %>%
  ggplot(data=., aes(x=dochg)) + 
  geom_density() +
  theme_bw() +
  scale_x_continuous(limits=c(0,20000))
facet_wrap(~klm)
  
gosp %>%
  ggplot(data=., aes(x=dochg,
                     fill=klm)) + 
  geom_density() +
  theme_bw() +
  scale_x_continuous(limits=c(0,20000)) +
  theme_bw() +
  facet_wrap(~klm)

gosp %>%
  ggplot(data=., aes(x=dochg,
                     fill=klm)) + 
  geom_density(alpha=0.3) +
  theme_bw() +
  scale_x_log10()

gosp %>%
  ggplot(data=., aes(x=dochg,
                     colour=klm)) + 
  geom_density() +
  theme_bw() +
  scale_x_log10()

#wykres pude³kowy

gosp %>%
  ggplot(data=., aes(x=klm, y=dochg)) +
  geom_boxplot() +
  scale_y_log10() +
  theme_bw()

gosp %>%
  ggplot(data=., aes(x=klm, y=dochg)) +
  geom_jitter(alpha=0.3) +
  geom_boxplot() +
  scale_y_log10() +
  theme_bw()


gosp %>%
  ggplot(data=., aes(x=klm, y=dochg)) +
  geom_violin() +
  scale_y_log10() +
  theme_bw()

gosp %>%
  ggplot(data=., aes(x=woj, y=dochg)) +
  geom_jitter(alpha=0.3) +
  geom_boxplot() +
  scale_y_log10() +
  theme_bw()













