rm(list = ls())
require(apcluster)
#require(phyclust)
#load of data.1
data.1 <- read.csv("C:/users/nikos/Desktop/ap.spark.data/mixed.data/data1.txt", sep = "\t")
data.2 <- read.csv("C:/users/nikos/Desktop/ap.spark.data/mixed.data/data2.txt", sep = "\t")
data.3 <- read.csv("C:/users/nikos/Desktop/ap.spark.data/mixed.data/data3.txt", sep = "\t")
names(data.1) <- names(data.2)
names(data.3) <- names(data.2)

  
  total_time<-0
  start_time <- Sys.time()
  data <- rbind(data.1, data.2, data.3)
  #data <- read.csv("C:/users/nikos/Desktop/ap.spark.data/data1.txt", sep = "\t")
  
  #subset of the first 1000 rows
  loop = round(NROW(data) / 1000 )
    if (NROW(data)/1000 - round(NROW(data)/1000) < 0.51){
      loop <- loop + 1  
    }else {}
  #loop
    for (y in 1:loop) {
      k = y * 1000
      l = k -1000 + 1
      if (k > NROW(data)){
        k <- NROW(data)
      }
    data.subset <- data[l:k, ]
    if (exists("vector.for.next.epoch")){
      vector.for.next.epoch <- as.data.frame(vector.for.next.epoch)
      names(vector.for.next.epoch) <- c(names(data.subset)[1], names(data.subset)[2])
      data.subset <- rbind(data.subset, vector.for.next.epoch)
      f.path <- paste0("C:/users/nikos/Desktop/ap.spark.data/to.be.clustered/dataset", y)
      write.csv(data.subset, f.path)
    }else{
      f.path <- paste0("C:/users/nikos/Desktop/ap.spark.data/to.be.clustered/dataset", y)
      write.csv(data.subset, f.path)
    }
    
    #estimation of similarity
    sim <- negDistMat(data.subset, r = 2)
    
    #affinity propagation
    #p.value = round(sum(data.subset) / 2000)
    #p.value
    exemplar.cluster.0 <- apcluster(sim, details = TRUE, q = 0.0229)
    exemplar.cluster.0
    #storage of exemplars of the subset
    exemplars.epoch.0 <- exemplar.cluster.0@exemplars
    
    #creation of a dataframe that has the values, the exemplars and the subset indication
    total.info <- as.data.frame(matrix(nrow = 0, ncol = 3))
    names(total.info) <- c("values", "exemplar", "subset")
    
    #appending in the dataframe values, exemplars and index
    for(i in 1:NROW(exemplar.cluster.0@clusters)){
      processed.subset <- as.data.frame(matrix(nrow = 0, ncol = 1))
      names(processed.subset) <- c("values")
      processed.subset <- rbind(processed.subset, exemplar.cluster.0@clusters[i])
      processed.subset$exemplar <- exemplar.cluster.0@exemplars[i]
      processed.subset$subset <- i
      names(processed.subset) <- c("values", "exemplar", "subset")
      names(total.info) <- c("values", "exemplar", "subset")
      total.info <- rbind(total.info, processed.subset)
      rm(processed.subset)
    }
    #just some calculations for adjusting alphabetical order between the shape files
    wy = y
    if (wy < 10){
      wy <-paste0("0",wy)
    }
    file.to.stream.path <- paste("C:/users/nikos/Desktop/ap.spark.data/datasets/", wy, ".csv")
    file.to.stream.path <- gsub(" ", "", file.to.stream.path)
    write.csv(total.info, file.to.stream.path)
    #creation of graph of the first subset
    plot(exemplar.cluster.0, data.subset)
    plot.file.path <- paste("C:/users/nikos/Desktop/ap.spark.data/graphs/", wy, ".png")
    plot.file.path <- gsub(" ", "", plot.file.path)
    plot.file.path
    png(filename=plot.file.path)
    plot(exemplar.cluster.0, data.subset)
    dev.off()
    
    #weighted.exemplars
    t <- y - (y-1) - 1
    w <- 2^(-0.25*(t))
    weighted.exemplars <- w*exemplar.cluster.0@exemplars
    #number of values clustered in each exemplar
    c <- NA
    for (i in 1:NROW(exemplar.cluster.0@clusters)){
    d <- summary(exemplar.cluster.0@clusters[i])[1]
    c <- rbind(c, d)
    c <- c[-1]
    }
    c <- as.numeric(c)
    c <- c* w
    #c contains all the weights for the exemplars of the first 1000 rows
    #cd contains all weights for each exemplar and each exemplar
    
    cd <- cbind(c, exemplar.cluster.0@exemplars)
    #a contains the weights multiplied by the exemplars
    a <- as.numeric(cd[ ,1] * cd[ ,2])
    
   
  
  #  a <- cd[ ,1] * cd[ ,2]
    
    #calculate disimilarity for each exemplar's group of values
    
    #calculation of the vector that is binded in the next subset of data
    vector.for.next.epoch <- matrix(nrow = 0, ncol = 2)
    
    
    for (i in 1:NROW(exemplar.cluster.0@clusters)){
    f <- as.data.frame(exemplar.cluster.0@clusters[i])
    sumD <- sum(-negDistMat(f, r = 2))
    c <- as.array(a[i], sumD)
    z <- cbind(a[i], sumD)
    vector.for.next.epoch <- rbind(vector.for.next.epoch, z)
    #filepath = paste("~/Desktop/ap.spark.data/vectors/ap.vector.for.next.epoch", 
    #                 y, ".csv")
  #  filepath = gsub(" ", "", filepath)
   # write.csv(vector.for.next.epoch, filepath)
    }
    qw = y
    if (qw < 10){
      qw <- paste0("0",qw)
    }
    filepath = paste("C:/users/nikos/Desktop/ap.spark.data/vectors/vector.for.next.epoch", qw, ".csv")
    filepath = gsub(" ", "", filepath)
    write.csv(vector.for.next.epoch, filepath)
    
    end_time <- Sys.time()
    time.taken <- end_time - start_time
    total_time<- total_time + time.taken
    cat("Time spent\n", time.taken, "\n" )
    start_time=Sys.time()
    end_time=Sys.time()
    }
    cat("Time spent for system\n", total_time, "\n" )
    list <- as.data.frame(exemplar.cluster.0@exemplars)
    list <- rownames(list)
  
    cat("final exemplars are:", list)
    