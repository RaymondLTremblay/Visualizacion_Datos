
Anolis %>%
  select(WEIGHT, SVL)%>%
  filter(WEIGHT<4 & SVL>20)%>%
ggplot(aes(SVL, WEIGHT))+
  geom_count(aes(size=..prop.., group=1))+
   ylab("Peso en gramos")+
  xlab("Tamaño del hocico a la cloaca")+
  theme(axis.title=element_text(size=10,face="bold"))+
  labs(title="Figura. Puntos en proporción a la frecuencia")
