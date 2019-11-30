rm(list = ls())
require("sparklyr")
require("future")
require(SparkR)
setwd("C:/users/nikos/Desktop/ap.spark.data/")
sc <- spark_connect(master = "local", spark_version = "2.4.3")

if(file.exists("source")) unlink("source", TRUE)
if(file.exists("source-out")) unlink("source-out", TRUE)

#AP_affinity_propagation(data, p, maxits = 1000, convits = 100,
#                        dampfact = 0.9, details = FALSE, nonoise = 0, time = FALSE)


stream_generate_test(iterations = 1)
read_folder <- stream_read_csv(sc, "./datasets/") 

write_output <- stream_write_csv(read_folder, "source-out")
#invisible(future(stream_generate_test(interval = 0.5)))