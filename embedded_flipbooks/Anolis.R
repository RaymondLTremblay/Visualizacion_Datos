
Anolis %>%  # pipe
  select(WEIGHT, SVL)%>%  # selecciona
  filter(WEIGHT<4 & SVL>20)%>%
  head()%>%            # solo muestra los primeros seis
  gt()

