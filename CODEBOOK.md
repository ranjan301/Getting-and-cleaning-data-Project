## Steps were used to reproduce tidy Data Set

### 1. a. Download the file
1. First a directory where the downloaded data to be stored
2. Download zip file using download.file function and store into created directory
3. Unzip the file and explore all the extracted files(datadet).
### b. Read traing dataset, test dataset using read.table function  and then merge both dataset into one using merge function.
### c. Columns in feature data set be renamed from given metadata featureNames.
### d. Merge all three datasets (features, activity and subject) using cbind function into a complete dataset.
### 2. a. Extracted the columns from complete dataset the columns that contain either mean or std.
### b. Activity column in extracted data to be changed to factor type . activity names are taken from activitylabels metadata
### 3.a. Tagging appropriate labels of descriptive variables by replacing some of the acronyms.
### 4. Finally create a independent tidy dataset with averaging of each variable for each activity and each subject.

# Tidy data Set Description

### The variables in the tidy data
Tidy data contains 180 rows and 88 columns. Each row has averaged variables for each subject and each activity.

### The data were averaged based on subject and activity group.
Activity column has 6 types as listed below and Subject is numbered from 1 to 30 sequentially.

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING


### All variables are of numeric type except subjec and activity which are factor type  variables.
