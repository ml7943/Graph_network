# install.packages("/Users/limu/Desktop/course/ML/A12/bnlearn_4.9.3.tar.gz", repos = NULL, type = "source")
# install.packages("dagitty")

# if (!require("BiocManager", quietly = TRUE))
# install.packages("BiocManager")
# BiocManager::install("graph")

# install.packages("BiocManager")
# BiocManager::install("Rgraphviz")

# install.packages("igraph")

library(bnlearn)
library(dagitty)
library(Rgraphviz)
library(igraph)

rm(list = ls())

# load data
data <- read.table("/Users/limu/Desktop/course/ML/A12/network_assignment_data_set.txt", header = TRUE)

# to factors
data$A <- as.factor(data$A)
data$B <- as.factor(data$B)
data$C <- as.factor(data$C)
data$D <- as.factor(data$D)
data$E <- as.factor(data$E)
data$F <- as.factor(data$F)

# build and plot DAG-structured Bayesian network
network <- hc(data)
plot(network)

# moral graph
moral_graph <- empty.graph(names(data))
arcs <- network$arcs
for (i in 1:nrow(arcs)) {
  moral_graph <- set.edge(moral_graph, from=arcs[i,1], to=arcs[i,2])
  moral_graph <- set.edge(moral_graph, from=arcs[i,2], to=arcs[i,1])
}

plot(moral_graph)

# cpt E to F
fit_network <- bn.fit(network, data)
values_E <- c("a", "b", "c")
values_F <- c("a", "b", "c")

# All combinations
for (value_E in values_E) {
  for (value_F in values_F) {
    # P(F=value_F | E=value_E)
    cpt_E_to_F <- cpquery(fit_network, event=(F==value_F), evidence=(E==value_E))
    cat("P(F=", value_F, "|E=", value_E, "): ", cpt_E_to_F, "\n", sep="")
  }
}
