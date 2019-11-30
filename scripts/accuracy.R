#import datasets
dataset.urls <- list.files (path = "C:/users/nikos/Desktop/ap.spark.data/datasets/")
dataset.urls <- paste0("C:/users/nikos/Desktop/ap.spark.data/datasets/", dataset.urls)
dataset.urls <- dataset.urls[1:33]

#import of dataset1 at dataset.1
dataset.1 <- read.csv(dataset.urls[1])
#import of dataset2 at dataset.2
dataset.2 <- read.csv(dataset.urls[2])

#NA fill in the 1st dataset
dataset.1$subset[dataset.1$exemplar == unique(dataset.1$exemplar)[1]] <- 1
dataset.1$subset[dataset.1$exemplar == unique(dataset.1$exemplar)[2]] <- 2
dataset.1$subset[dataset.1$exemplar == unique(dataset.1$exemplar)[3]] <- 3

#label set in previous dataset
dataset.1$subset[dataset.1$subset == 1] <- dataset.2$subset[1001]
dataset.1$subset[dataset.1$subset == 2] <- dataset.2$subset[1002]
dataset.1$subset[dataset.1$subset == 3] <- dataset.2$subset[1003]

#rbind all data up to epoch.2
dataset.1.2 <- rbind(dataset.1, dataset.2[1:1000, ])
dataset.total <- dataset.1.2

#from 2 to 3
dataset.1 <- dataset.1.2
dataset.2 <- read.csv(dataset.urls[3])
dataset.1$subset[dataset.1$subset == 1] <- dataset.2$subset[1001]
dataset.1$subset[dataset.1$subset == 2] <- dataset.2$subset[1002]
dataset.1$subset[dataset.1$subset == 3] <- dataset.2$subset[1003]
dataset.1$subset[dataset.1$subset == 4] <- dataset.2$subset[1004]
dataset.1$subset[dataset.1$subset == 5] <- dataset.2$subset[1005]
dataset.1$subset[dataset.1$subset == 6] <- dataset.2$subset[1006]

dataset.1.2.3 <- rbind(dataset.total, dataset.2[1:1000, ])
dataset.total <- dataset.1.2.3

#export data
write.csv(dataset.1.2, "C:/users/nikos/Desktop/ap.spark.data/final.clusters/dataset.1.2.csv")
write.csv(dataset.1.2.3, "C:/users/nikos/Desktop/ap.spark.data/final.clusters/dataset.1.2.3.csv")


#dataset.total <- dataset.1.2.3

#loop for epoch 4:6
for (j in 4:6){
  dataset.1 <- dataset.total
  dataset.2 <- read.csv(dataset.urls[j])
  for (k in 1:NROW(unique(dataset.1$subset))) {
    l <- as.integer(k + 1000)
    k <- as.integer(k)
    dataset.1$subset[dataset.1$subset == k] <- dataset.2$subset[l]
  }
  dataset.total <- rbind(dataset.1, dataset.2[1:1000, ])
}

#export  dataset 1 to 6
write.csv(dataset.total, "C:/users/nikos/Desktop/ap.spark.data/final.clusters/dataset.1.6.csv")

#dataset.total <- read.csv("~/Desktop/ap.spark.data/final.clusters/dataset.1.6.csv")
#dataset.total <- dataset.total[ , -1]

#export dataset 7 to 9
for (j in 7:9){
  dataset.1 <- dataset.total
  dataset.2 <- read.csv(dataset.urls[j])
  for (k in 1:NROW(unique(dataset.1$subset))) {
    l <- as.integer(k + 1000)
    k <- as.integer(k)
    dataset.1$subset[dataset.1$subset == k] <- dataset.2$subset[l]
  }
  dataset.total <- rbind(dataset.1, dataset.2[1:1000, ])
}

#export dataset
write.csv(dataset.total, "C:/users/nikos/Desktop/ap.spark.data/final.clusters/dataset.1.to.9.csv")

#dataset.total <- read.csv("~/Desktop/ap.spark.data/final.clusters/dataset.1.to.9.csv")
#dataset.total <- dataset.total[ ,-1]


#loop dataset epochs 10 to 32
for (j in 10:32){
  dataset.1 <- dataset.total
  dataset.2 <- read.csv(dataset.urls[j])
  for (k in 1:NROW(unique(dataset.1$subset))) {
    l <- as.integer(k + 1000)
    k <- as.integer(k)
    dataset.1$subset[dataset.1$subset == k] <- dataset.2$subset[l]
  }
  dataset.total <- rbind(dataset.1, dataset.2[1:1000, ])
}

#export dataset 1 to 32
write.csv(dataset.total, "C:/users/nikos/Desktop/ap.spark.data/final.clusters/dataset.1.to.32.csv")
#dataset.total <- read.csv("~/Desktop/ap.spark.data/final.clusters/dataset.1.to.32.csv")       
#dataset.total <- dataset.total[ , -1]

#final epoch 33 to 34
dataset.1 <- dataset.total
dataset.2 <- read.csv(dataset.urls[33])


dataset.subset.1 <- subset(dataset.total,
                           dataset.total$subset == 7 | dataset.total$subset == 8 | dataset.total$subset == 9)
dataset.subset.2<- subset(dataset.total,
                          dataset.total$subset == 3 | dataset.total$subset == 4)
dataset.subset.3<-subset(dataset.total,
                       dataset.total$subset == 1)
dataset.subset.4<-subset(dataset.total,
                         dataset.total$subset == 2)

#assign of final labels
dataset.subset.1$subset <- 1
dataset.subset.2$subset <- 4
dataset.subset.3$subset <- 2
dataset.subset.4$subset <- 3

#binding of all data
dataset.total <- rbind(dataset.subset.1, dataset.subset.2, dataset.subset.3, dataset.subset.4)
dataset.total <- rbind(dataset.total, dataset.2[1:(NROW(dataset.2) - k), ])
unique(dataset.total$subset)

#export dataset from 1 to 33
write.csv(dataset.total, "C:/users/nikos/Desktop/ap.spark.data/final.clusters/dataset.1.to.33.csv")

