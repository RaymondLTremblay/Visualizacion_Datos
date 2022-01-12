Anolis %>%
  select(WEIGHT, SVL) %>%
  filter(WEIGHT<4 & SVL>20) %>%
ggplot(aes(SVL, WEIGHT)) +
  geom_point() +
    labs(title= "Figura. Relación de SVL y el peso \n de Anolis en El Verde, Yunque, PR")
