library(plyr)

setwd("F:\\Backup_8.8.2019\\MOOC\\Data cleaning")
# Download the dataset

if(!file.exists("./data")){dir.create("./data")}
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url1, destfile = "./data/dataset.zip")

# Unzip the dataset
unzip(zipfile = "./data/dataset.zip", exdir = "./data")

# 1. Merge the training and test datasets

# 1.1 Reading files

# 1.1.1 Reading training datasets
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# 1.1.2 Reading test datasets
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# 1.1.3 Reading feature vector
features <- read.table("./data/UCI HAR Dataset/features.txt")

# 1.1.4 Reading activity labels
activityLabels = read.table("./data/UCI HAR Dataset/activity_labels.txt")

# 1.2 Assigning variable names
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(activityLabels) <- c("activityID", "activityType")

# 1.3 Merging all datasets into one set
fulltrain <- cbind(y_train, subject_train, x_train)
fulltest <- cbind(y_test, subject_test, x_test)
datasetf <- rbind(fulltrain, fulltest)

# 2. Extracting only the measurements on the mean and sd for each measurement

# 2.1 Reading column names
colNames <- colnames(datasetf)

# 2.2 Create vector for defining ID, mean, and sd
mean_std <- (grepl("activityID", colNames) |
                   grepl("subjectID", colNames) |
                   grepl("mean..", colNames) |
                   grepl("std...", colNames)
)

# 2.3 Making nessesary subset
MeanandStd <- datasetf[ , mean_std == TRUE]

# 3. Use descriptive activity names
setWithActivityNames <- merge(MeanandStd, activityLabels,
                              by = "activityID",
                              all.x = TRUE)

# 4. Label the data set with descriptive variable names
# see 1.3, 2.2, 2.3

# 5. Creating a second,  independent tidy data set with the avg of each variable for each activity and subject

# 5.1 Making a second tidy data set
tidySet <- aggregate(. ~subjectID + activityID, setWithActivityNames, mean)
tidySet <- tidySet[order(tidySet$subjectID, tidySet$activityID), ]

# 5.2 Writing second tidy data set into a txt file
write.table(tidySet, "tidySet.txt", row.names = FALSE)

