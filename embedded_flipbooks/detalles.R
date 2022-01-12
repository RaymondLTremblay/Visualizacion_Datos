Anolis %>%
  select(WEIGHT, SVL)%>%
  filter(WEIGHT<4 & SVL>20)%>%
ggplot(aes(SVL, WEIGHT))+
  geom_point()+
  ylab("Peso en gramos")+
  xlab("Tamaño del hocico a la cloaca")+
  theme(axis.title.x=
    element_text(size=10,face="italic", 
                 colour="darkorchid4"))+
  theme(axis.title.y=
    element_text(size=10,
                 face="bold", 
                 colour="darkred"))+
  theme(title=
    element_text(size=18,
                 face="bold", 
                 colour="green"))+
  ggtitle("Título con tipo/tamaño/aspecto que Ud desee")

