pollutantmean <- function(directory, pollutant, id=1:332){
        #makes a list of each csv file in directory
        csvList <- list.files(path = directory, pattern = ".csv", full.names = TRUE)
        #creates an empty numeric vector to store values of each element in 'sulfate' or 'nitrate' column
        monitorValues <- numeric() 
        for (i in id){
                #reads each csv from i to length(id)
                csvData <- read.csv(csvList[i])
                #appends either 'sulfate' or 'nitrate' column of each csv to values list
                monitorValues <- c(monitorValues, csvData[[pollutant]]) 
        }
        mean(monitorValues, na.rm = TRUE)
}