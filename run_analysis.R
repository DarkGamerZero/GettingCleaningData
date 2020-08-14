#Load requisite packages
library(dplyr)

#Download file

filename <- "GCdata_Project.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

#Unzip the file to continue

if (file.exists("UCI HAR Dataset")) { 
  unzip(filename)
}

#Read the datasets and assign column names

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("Count","Features"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("Code", "Activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$Features)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$Features)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Code")

#Merge the training and test datasets
x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)
data <- cbind(subject, x, y)

#Extract mean and std measurements 
data2 <- data %>% select(Subject, Code, contains("mean"), contains("std"))

#Use descriptive activity names
data2$code <- activities[data2$Code, 2]

#Appropriately label the data2set with descriptive variable names

names(data2)[2] = "Activity"
names(data2)<-gsub("Acc", "Accelerometer", names(data2))
names(data2)<-gsub("Gyro", "Gyroscope", names(data2))
names(data2)<-gsub("BodyBody", "Body", names(data2))
names(data2)<-gsub("Mag", "Value", names(data2))
names(data2)<-gsub("^t", "Time", names(data2))
names(data2)<-gsub("^f", "Frequency", names(data2))
names(data2)<-gsub("tBody", "TimeBody", names(data2))
names(data2)<-gsub("-mean()", "Mean", names(data2), ignore.case = TRUE)
names(data2)<-gsub("-std()", "Deviation", names(data2), ignore.case = TRUE)
names(data2)<-gsub("-freq()", "Frequency", names(data2), ignore.case = TRUE)
names(data2)<-gsub("angle", "Angle", names(data2))
names(data2)<-gsub("gravity", "Gravity", names(data2))

#Create a second, independent dataset with the average of each variable for each activity and each subject
final <- data2 %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))

#Write the dataset to a CSV file
write.table(final, "Final.txt", row.name = FALSE)