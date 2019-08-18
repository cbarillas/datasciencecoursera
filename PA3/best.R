best <- function(state, outcome) {
        ## Read outcome data
        outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

        ## Check that state and outcome are valid
        if (!(is.element(state, outcome_data[,7]))) {
                stop("invalid state")
        }
        if (!(is.element(outcome, c("heart attack", "heart failure", "pneumonia")))) {
                stop("invalid outcome")
        }
        
        
        
        ## Return hospital name in that state with lowest 30-day death
        ## rate
        
        sub_outcome <- subset(outcome_data, State == state)
        
        if (outcome == "heart attack") {
                sub_outcome[,11] <- as.numeric(sub_outcome[,11])
                min_value <- min(sub_outcome[,11], na.rm=T)
                min_row <- subset(sub_outcome, sub_outcome[,11] == min_value)
        }
        else if (outcome == "heart failure"){
                sub_outcome[,17] <- as.numeric(sub_outcome[,17])
                min_value <- min(sub_outcome[,17], na.rm=T)
                min_row <- subset(sub_outcome, sub_outcome[,17] == min_value)
        }
        else if (outcome == "pneumonia"){
                sub_outcome[,23] <- as.numeric(sub_outcome[,23])
                min_value <- min(sub_outcome[,23], na.rm=T)
                min_row <- subset(sub_outcome, sub_outcome[,23] == min_value)
        }
        sorted_hospital_names <- sort(min_row$Hospital.Name)
        print(sorted_hospital_names[1])

}