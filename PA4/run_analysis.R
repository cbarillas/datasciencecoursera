library(reshape2)

## Step 1: Merges the training and the test sets to create one data set

# read data into data frames
subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")
y_train <- read.table("y_train.txt")
y_test <- read.table("y_test.txt")
features <- read.table("features.txt")

# add column names
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"
names(X_train) <- features$V2
names(X_test) <- features$V2
names(y_train) <- "activity"
names(y_test) <- "activity"

# combine files into one dataset
train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
combinedData <- rbind(train, test)

#summary(combinedData)


## Step 2: Extracts only the measurements on the mean and standard
## deviation for each measurement.

# Regex for columns that contain "mean()" or "std()"
meanstd <- grepl("mean\\(\\)", names(combinedData)) |
        grepl("std\\(\\)", names(combinedData))

# Keep subjectID and activity columns and remove unesscary columns
meanstd[1:2] <- TRUE
combinedData <- combinedData[, meanstd]


## Step 3: Uses descriptive activity names to name the activities
## in the data set.
## Step 4: Appropriately labels the data set with descriptive
## activity names. 

# convert the activity column from integer to factor
combinedData$activity <- factor(combinedData$activity, labels=c("Walking",
                                                        "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))


## Step 5: Creates a second, independent tidy data set with the
## average of each variable for each activity and each subject.

# create the tidy data set
melted <- melt(combinedData, id=c("subjectID","activity"))
tidy <- dcast(melted, subjectID+activity ~ variable, mean)

# write the tidy data set to a file
write.csv(tidy, "tidy.csv", row.names=FALSE)
