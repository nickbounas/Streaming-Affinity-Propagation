data.1 <- read.csv("C:/users/nikos/Desktop/ap.spark.data/mixed.data/data1.txt", sep = "\t")
data.2 <- read.csv("C:/users/nikos/Desktop/ap.spark.data/mixed.data/data2.txt", sep = "\t")
data.3 <- read.csv("C:/users/nikos/Desktop/ap.spark.data/mixed.data/data3.txt", sep = "\t")
names(data.1) <- names(data.2)
names(data.3) <- names(data.2)
data <- rbind(data.1, data.2, data.3)
require(apcluster)
#graphs loop
for (y in 1:33){
  k = y * 1000
  l = k -1000 + 1
  if (k > NROW(data)){
    k <- NROW(data)
  }
  data.subset <- data[l:k, ]
  sim <- negDistMat(data.subset, r = 2)
  exemplar.cluster.0 <- apcluster(sim, details = TRUE, q = 0.0229)
  #creation of graph of the first subset
  plot(exemplar.cluster.0, data.subset)
  plot.file.path <- paste("C:/users/nikos/Desktop/ap.spark.data/graphs.without.weights/", y, ".png")
  plot.file.path <- gsub(" ", "", plot.file.path)
  plot.file.path
  png(filename=plot.file.path)
  plot(exemplar.cluster.0, data.subset)
  dev.off()
}