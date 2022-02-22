
Anolis %>%  # pipe
  select(WEIGHT, SVL) %>%  # Seleccionar solamente la siguientes columnas
 filter(WEIGHT<4 & SVL>20)%>%
  head()%>%            # solo muestra los primeros seis
  gt()

