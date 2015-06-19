#Reading in all the required data
#This assumes data has been unzipped to current working directory 
#and the file structure remains unedited


x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')

y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
features <- read.table('./UCI HAR Dataset/features.txt', stringsAsFactors = FALSE)


columnNames <- features$V2

yData <- rbind(y_train,y_test)
xData <- rbind(x_train,x_test)
subjectData <- rbind(subject_train,subject_test)

#Adding Readable names to variables
names(subjectData)[1] <- "Subject ID"
names(yData)[1] <- "Activity Type"
names(xData) <- columnNames

allData<- cbind(subjectData,yData,xData)
