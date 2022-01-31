
Anolis %>%
  select(WEIGHT, SVL)%>%
  filter(WEIGHT<4 & SVL>20)%>%
ggplot(aes(SVL, WEIGHT))+
  geom_count(aes(size=..prop.., group=SVL))+
  ylab("Peso en gramos")+
  xlab("Tamaño del hocico a la cloaca")+
  theme(axis.title=element_text(size=14,face="bold"))+
  labs(title="Figura. Puntos en proporción a una variable")
