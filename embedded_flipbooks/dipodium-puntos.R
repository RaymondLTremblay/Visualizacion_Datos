
dipodium %>%
  select(number_of_fruits, species_name, tree_species)%>%
  filter(species_name=="r")%>%   # r representa la especie de Dipodium roseum
  ggplot(aes(number_of_fruits))+
  geom_dotplot(stackratio=.5, fill="magenta", colour = "red")+
  labs(x="Número de Frutos", y="Frecuencia")+
  theme(axis.title=element_text(size=10,face="bold"))
