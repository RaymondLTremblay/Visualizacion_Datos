DW %>%
  drop_na(number_of_flowers)%>%
  ggplot(aes(number_of_flowers))+
  geom_bar(fill="red",color="white")+
  xlab("Cantidad de Flores")+
  ylab("Frecuencia")+
  theme(axis.title=element_text(size=14,face="bold"))

