rm(list = ls())
#require(fossil)
cluster <- read.csv("C:/users/nikos/Desktop/ap.spark.data/final.clusters/dataset.1.to.33.csv")
cluster2 <- read.csv("C:/users/nikos/Desktop/ap.spark.data/Dataset/label_data123.txt", 
                              header = FALSE)

cluster.1.1 <- cluster$subset[1:3000]
cluster.1.2 <- cluster$subset[3001:6000]
cluster.1.3 <- cluster$subset[6001:9000]
cluster.1.4 <- cluster$subset[9001:12000]
cluster.1.5 <- cluster$subset[12001:15000]
cluster.1.6 <- cluster$subset[15001:18000]
cluster.1.7 <- cluster$subset[18001:21000]
cluster.1.8 <- cluster$subset[21001:24000]
cluster.1.9 <- cluster$subset[24001:27000]
cluster.1.10 <- cluster$subset[27001:30000]
cluster.1.11 <- cluster$subset[30001:32256]


cluster.2.1 <- cluster2[1:3000, ]
cluster.2.2 <- cluster2[3001:6000, ]
cluster.2.3 <- cluster2[6001:9000, ]
cluster.2.4 <- cluster2[9001:12000, ]
cluster.2.5 <- cluster2[12001:15000, ]
cluster.2.6 <- cluster2[15001:18000, ]
cluster.2.7 <- cluster2[18001:21000, ]
cluster.2.8 <- cluster2[21001:24000, ]
cluster.2.9 <- cluster2[24001:27000, ]
cluster.2.10 <- cluster2[27001:30000, ]
cluster.2.11 <- cluster2[30001:32256, ]

require(fossil)
rand.index(cluster.1.1, cluster.2.1)
rand.index(cluster.1.2, cluster.2.2)
rand.index(cluster.1.3, cluster.2.3)
rand.index(cluster.1.4, cluster.2.4)
rand.index(cluster.1.5, cluster.2.5)
rand.index(cluster.1.6, cluster.2.6)
rand.index(cluster.1.7, cluster.2.7)
rand.index(cluster.1.7, cluster.2.8)
rand.index(cluster.1.9, cluster.2.9)
rand.index(cluster.1.10, cluster.2.10)
rand.index(cluster.1.11, cluster.2.11)

mean.rand.index <- (rand.index(cluster.1.1, cluster.2.1) +
                      rand.index(cluster.1.2, cluster.2.2) +
                      rand.index(cluster.1.3, cluster.2.3) +
                      rand.index(cluster.1.4, cluster.2.4) +
                      rand.index(cluster.1.5, cluster.2.5) +
                      rand.index(cluster.1.6, cluster.2.6) +
                      rand.index(cluster.1.7, cluster.2.7) +
                      rand.index(cluster.1.7, cluster.2.8) +
                      rand.index(cluster.1.9, cluster.2.9) +
                      rand.index(cluster.1.10, cluster.2.10)+
                      (2256/3000) * rand.index(cluster.1.11, cluster.2.11)
                    
) / (10 + (2256 / 3000))

mean.rand.index

adj.rand.index(cluster.1.1, cluster.2.1)
adj.rand.index(cluster.1.2, cluster.2.2)
adj.rand.index(cluster.1.3, cluster.2.3)
adj.rand.index(cluster.1.4, cluster.2.4)
adj.rand.index(cluster.1.5, cluster.2.5)
adj.rand.index(cluster.1.6, cluster.2.6)
adj.rand.index(cluster.1.7, cluster.2.7)
adj.rand.index(cluster.1.8, cluster.2.8)
adj.rand.index(cluster.1.9, cluster.2.9)
adj.rand.index(cluster.1.10, cluster.2.10)
adj.rand.index(cluster.1.11, cluster.2.11)

mean.adj.rand.index <- (adj.rand.index(cluster.1.1, cluster.2.1) +
                          adj.rand.index(cluster.1.2, cluster.2.2) +
                          adj.rand.index(cluster.1.3, cluster.2.3) +
                          adj.rand.index(cluster.1.4, cluster.2.4) +
                          adj.rand.index(cluster.1.5, cluster.2.5) +
                          adj.rand.index(cluster.1.6, cluster.2.6) +
                          adj.rand.index(cluster.1.7, cluster.2.7) +
                          adj.rand.index(cluster.1.8, cluster.2.8) +
                          adj.rand.index(cluster.1.9, cluster.2.9) +
                          adj.rand.index(cluster.1.10, cluster.2.10) + 
                          (2256/3000) * adj.rand.index(cluster.1.11, cluster.2.11)
) / (10 + (2256/3000))
cat("Average of rand index is: ", mean.rand.index, "\n")
cat("Average of adjusted Rand index is: ", mean.adj.rand.index)
