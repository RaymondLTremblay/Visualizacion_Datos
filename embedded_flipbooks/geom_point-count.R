Anolis %>%
  select(WEIGHT, SVL) %>%
  filter(WEIGHT<4 & SVL>20) %>%
ggplot(aes(x=WEIGHT, y=SVL))+
  geom_point()+
    labs(title= "Figura. Relación de SVL y  el peso de Anolis en \n El Verde, Yunque, PR")+
  ylab("Snout vent length")
