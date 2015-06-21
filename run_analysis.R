#Reading in all the required data
#This assumes data has been unzipped to current working directory 
#and the file structure remains unedited

#Load the dply library - this is a required package for this script to run
library(dplyr)

#Read in data from X_Test.txt and X_Train.txt 
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')

#Combine data from x_test and x_train into a single DF
xData <- rbind(x_train,x_test)

#Since we no longer need x_test and x_train, here we remove them from the evnironment
remove(x_test, x_train)

#Read in data from y_Test.txt and y_Train.txt 
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')

#Combine data from y_test and y_train into a single DF
yData <- rbind(y_train,y_test)
#As earlier - here we're cleaning up the environment
remove(y_test,y_train)

#Read in data from subject_Test.txt and subject_Train.txt
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')

#Combine data from subject_test and subject_train into a single DF
subjectData <- rbind(subject_train,subject_test)
#Cleaning up the environment
remove(subject_test,subject_train)

#
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

theNames <- names(allData)
extractedMeanColumnNames <- theNames[grep("mean()", theNames,fixed = TRUE)]
extractedSTDColumnNames <- theNames[grep("std()", theNames,fixed = TRUE)]
columnNamesToSubset <- c("Subject", "Activity",extractedMeanColumnNames,extractedSTDColumnNames)
#So P is the dataset without only the mean and standard deviation measurements
STD_MeanData <- allData[columnNamesToSubset]


#Creates the TidyDataset
tidyData <- STD_MeanData %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

#Write the tidyData set to an output text file called 'TidyData.txt'
write.table(tidyData,file = "TidyData.txt", row.name=FALSE)

#Clear the environment
rm(list = ls())
