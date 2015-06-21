#Reading in all the required data
#This assumes data has been unzipped to current working directory 
#and the file structure remains unedited

#Read in X_Test and X_Train data
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
xData <- rbind(x_train,x_test)
#Cleaning up the evnironment
remove(x_test, x_train)


y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
yData <- rbind(y_train,y_test)
#Cleaning up the environment
remove(y_test,y_train)

subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
subjectData <- rbind(subject_train,subject_test)
#Cleaning up the environment
remove(subject_test,subject_train)

features <- read.table('./UCI HAR Dataset/features.txt', stringsAsFactors = FALSE)
columnNames <- features$V2
#Cleaning up the environment
remove(features)

#Adding Readable names to variables
names(subjectData)[1] <- "Subject"
names(yData)[1] <- "Activity"
yData$Activity[yData$Activity == 1] <- "WALKING"
yData$Activity[yData$Activity == 2] <- "WALKING_UPSTAIRS"
yData$Activity[yData$Activity == 3] <- "WALKING_DOWNSTAIRS"
yData$Activity[yData$Activity == 4] <- "SITTING"
yData$Activity[yData$Activity == 5] <- "STANDING"
yData$Activity[yData$Activity == 6] <- "LAYING"
names(xData) <- columnNames

#Cobine all data
allData<- cbind(subjectData,yData,xData)
#Cleaning up the environment
remove(subjectData,yData,xData)

#Measurements with Mean
# 1 tBodyAcc-mean()-X
# 2 tBodyAcc-mean()-Y
# 3 tBodyAcc-mean()-Z
# 41 tGravityAcc-mean()-X
# 42 tGravityAcc-mean()-Y
# 43 tGravityAcc-mean()-Z
# 81 tBodyAccJerk-mean()-X
# 82 tBodyAccJerk-mean()-Y
# 83 tBodyAccJerk-mean()-Z
# 121 tBodyGyro-mean()-X
# 122 tBodyGyro-mean()-Y
# 123 tBodyGyro-mean()-Z
# 161 tBodyGyroJerk-mean()-X
# 162 tBodyGyroJerk-mean()-Y
# 163 tBodyGyroJerk-mean()-Z
# 201 tBodyAccMag-mean()
# 214 tGravityAccMag-mean()
# 227 tBodyAccJerkMag-mean()
# 240 tBodyGyroMag-mean()
# 253 tBodyGyroJerkMag-mean()
# 266 fBodyAcc-mean()-X
# 267 fBodyAcc-mean()-Y
# 268 fBodyAcc-mean()-Z
# 345 fBodyAccJerk-mean()-X
# 346 fBodyAccJerk-mean()-Y
# 347 fBodyAccJerk-mean()-Z
# 424 fBodyGyro-mean()-X
# 425 fBodyGyro-mean()-Y
# 426 fBodyGyro-mean()-Z
# 503 fBodyAccMag-mean()
# 516 fBodyBodyAccJerkMag-mean()
# 529 fBodyBodyGyroMag-mean()
# 542 fBodyBodyGyroJerkMag-mean()

theNames <- names(allData)
extractedMeanColumnNames <- theNames[grep("mean()", theNames,fixed = TRUE)]
extractedSTDColumnNames <- theNames[grep("std()", theNames,fixed = TRUE)]
columnNamesToSubset <- c("Subject", "Activity",extractedMeanColumnNames,extractedSTDColumnNames)
#So P is the dataset without only the mean and standard deviation measurements
p <- allData[columnNamesToSubset]
#Removes the "()" and "-" from the names
names(p) = gsub("()","",names(p) , fixed = TRUE)
names(p) = gsub("-",".",names(p) , fixed = TRUE)

#Starting to create a tidy dataset.
library(dplyr)
test<-summarise(group_by(p, Subject, Activity), tBodyAcc.mean.X = mean(tBodyAcc.mean.X))

tidyData <- p %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))




# Selects only data that realates to subject 1
subject1 <- p[(p$Subject == 1),]
#This lets you see the number of observations for subject 1 separated out into the different activities. 
table(unlist(subject1$Activity))

#Selects only the data from subject one where the activitiy is Laying
laying <- subject1[(subject1$Activity == "LAYING"),]

#This lets you see the number of observations for each subject
table(unlist(tidyData$Subject))
table(unlist(tidyData$Activity))





##########################TESTING SOMETHING DIFFERENT######################################
