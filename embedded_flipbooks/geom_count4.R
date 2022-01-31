#names(Anolis) # para mostrar los nombres de las columnas

  
Anolis %>%
  select(WEIGHT, SVL, SEASON, Survey_Site, PERCH_SUBSTRATE)%>%
  filter(WEIGHT<4 & SVL>20)%>%
ggplot(aes(SVL, WEIGHT, colour=SEASON))+
  geom_count(aes(size=..prop.., group=WEIGHT))+
  ylab("Peso en gramos")+
  xlab("Tamaño del hocico a la cloaca")+
  facet_wrap(~PERCH_SUBSTRATE)+
  theme(axis.title=element_text(size=10,face="bold"))+
  scale_color_manual(values = c("orange", "red"))+
  labs(title="Figura. Grupos separados por variable discreta")



