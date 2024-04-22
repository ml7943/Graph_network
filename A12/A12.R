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

# Read the data
data <- read.table("/Users/limu/Desktop/course/ML/A12/network_assignment_data_set.txt", header = TRUE)

# Check the structure of the data
str(data)

# Convert character variables to factors
data$A <- as.factor(data$A)
data$B <- as.factor(data$B)
data$C <- as.factor(data$C)
data$D <- as.factor(data$D)
data$E <- as.factor(data$E)
data$F <- as.factor(data$F)

# Build the Bayesian network using the hill climbing algorithm
network <- hc(data)

# Plot the inferred network
plot(network)

# Check the class of the network object
class(network)

# Inspect the structure of the network object
str(network)

# Plot the moral graph of the inferred DAG
graphviz.plot(network)

# Moral graph of inferred DAG
class(moral_graph)
moral_graph <- moralize(network)
plot(moral_graph, layout=layout_as_tree)

# Extract the CPT for the edge E->F
cpt_edge_EF <- cpt(network, "F", evidence = "E")

# Print the conditional probability table
print(cpt_edge_EF)

