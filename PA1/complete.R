complete <- function(directory, id = 1:332){
        csvList <- list.files(path = directory, pattern = ".csv", full.names = TRUE)
        completeCount <- numeric()
        for (i in id){
                csvData <- read.csv(csvList[i])
                completeCases <- complete.cases(csvData)
                sum <- sum(completeCases)
                completeCount <-c(completeCount, sum)
        }
        completeDataFrame <- data.frame(id, completeCount)
        colnames(completeDataFrame) <- c("id", "nobs")
        completeDataFrame
}



