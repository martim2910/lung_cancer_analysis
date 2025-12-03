library(survival)
data_lung <- lung
data_lung$status <- data_lung$status - 1 
write.csv(data_lung, "lung_cancer.csv", row.names = FALSE)
getwd()
View(data_lung)
