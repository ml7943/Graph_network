################# 1.3 to 1.5 ######################
# install.packages("igraph")
library(igraph)

edges <- matrix(c(1, 2, 2, 4, 1, 3, 3, 4, 4, 5, 5, 6, 6, 7, 6, 8, 5, 7, 7, 8), ncol = 2, byrow = TRUE)
g <- graph_from_edgelist(edges, directed = FALSE)

plot(g, layout=layout_with_kk(g), vertex.label=1:8, vertex.size=30, vertex.color="lightblue", vertex.label.color="black", edge.color="gray")

# Adjacency matrix
adj_matrix <- as_adjacency_matrix(g)
print(adj_matrix)

# Derive modules
modules <- cluster_edge_betweenness(g)

# Plot the topology
plot(modules, g, vertex.label=1:8, vertex.size=30, vertex.color=c("red", "green")[membership(modules)], vertex.label.color="black", edge.color="gray")
