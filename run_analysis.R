#Reading in all the required data
X_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
Y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
X_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')