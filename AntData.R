library(igraph)
library(dplyr)
library(oddnet)
library(tsibble)

#dat <- read_graph("~/../Desktop/DatosRedes/insecta-ant-colony5.edges")

dat2 <- read.table("data/insecta-ant-colony5.edges")


# datos originales --------------------------------------------------------


trescol <- dat2 |> select(-V3) |> dplyr::rename(day = V4)
#Datos originales, pero agrupados
ant41_red_df <- trescol |> group_by(day)
# Separados por dias (41)
ant41_red_list <-  group_split(ant41_red_df)

networks <- list()
graphs <- list()
for (i in 1:length(ant41_red_list)) {
  gr <- graph_from_data_frame(ant41_red_list[[i]])
  networks[[i]] <- as_adjacency_matrix(gr)
  graphs[[i]] <- gr
}

plot(graphs[[1]],
     # vertex 
     vertex.label = NA,
     vertex.size=7,
     # edges
     edge.arrow.size = .2,
     edge.color = "#f0f0f005")

anom <- anomalous_networks(networks)
anom

