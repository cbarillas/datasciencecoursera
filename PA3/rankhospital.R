rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Check that state and outcome are valid
        if (!(is.element(state, outcome_data$State))) {
                stop("invalid state")
        }
        if (!(is.element(outcome, c("heart attack", "heart failure", "pneumonia")))) {
                stop("invalid outcome")
        }
        
        
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        sub_outcome <- subset(outcome_data, State == state)
        
        ## If the number given by num is larger than the number of hospitals
        ## in that state, then the function should return NA.
        if(num > length(sub_outcome$State)){
                NA
        }
                
        if(num == "best"){
                if (outcome == "heart attack") {
                        column_index = 11
                }
                else if (outcome == "heart failure"){
                        column_index = 17
                }
                else if (outcome == "pneumonia"){
                        column_index = 23
                }
                sub_outcome[,column_index] <- as.numeric(sub_outcome[,column_index])
                min_value <- min(sub_outcome[,column_index], na.rm=T)
                min_row <- subset(sub_outcome, sub_outcome[,column_index] == min_value)
                sorted_hospital_names <- sort(min_row$Hospital.Name)
                print(sorted_hospital_names[1])
        }
        else if (num == "worst"){
                if (outcome == "heart attack") {
                        column_index = 11
                }
                else if (outcome == "heart failure"){
                        column_index = 17
                }
                else if (outcome == "pneumonia"){
                        column_index = 23
                }
                sub_outcome[,column_index] <- as.numeric(sub_outcome[,column_index])
                max_value <- max(sub_outcome[,column_index], na.rm=T)
                max_row <- subset(sub_outcome, sub_outcome[,column_index] == max_value)
                sorted_hospital_names <- sort(max_row$Hospital.Name)
                print(sorted_hospital_names[1])
                
        }
        else{
                if (outcome == "heart attack"){
                        rates = as.numeric(sub_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)

                }
                else if (outcome == "heart failure"){
                        rates = as.numeric(sub_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
                        
                }
                else if (outcome == "pneumonia"){
                        rates = as.numeric(sub_outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Pnemonia)
                        
                }
                sdata <- data.frame(hospital_name =  sub_outcome$Hospital.Name, rate = rates)
                new_data <- suppressWarnings(na.omit(sdata))
                new_data <- new_data[order(new_data$rate, new_data$hospital_name),]
                return(as.character(new_data$hospital_name[num]))
        }
}