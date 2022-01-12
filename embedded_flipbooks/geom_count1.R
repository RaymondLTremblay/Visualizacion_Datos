
Anolis %>%
  select(WEIGHT, SVL)%>%
  filter(WEIGHT<4 & SVL>20)%>%
ggplot(aes(SVL, WEIGHT))+
  geom_count()+
  ylab("Peso en gramos")+
  xlab("Tamaño del hocico a la cloaca")+
  theme(axis.title=element_text(size=14,face="bold"))+
  labs(title="Figura. Puntos de acuerdo a la frecuencia")

