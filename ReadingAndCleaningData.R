#data extraction 
features <- read.table("features.txt", col.names = c("n", "functions"))
activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))
subjectTest <- read.table("test/subject_test.txt", col.names = "subject")
xTest <- read.table("test/X_test.txt", col.names = features$functions)
yTest <- read.table("test/y_test.txt", col.names = "code")
subjectTrain <- read.table("train/subject_train.txt", col.names = "subject")
xTrain <- read.table("train/X_train.txt", col.names = features$functions)
yTrain <- read.table("train/y_train.txt", col.names = "code")

#merging data into one data set
x <- rbind(xTrain, xTest)
y <- rbind(yTrain, yTest)
subject <- rbind(subjectTrain, subjectTest)
mergedData <- cbind(subject, y, x)

#extracting the measurements on the mean and standard deviation
tidyData <- select(mergedData, subject, code, contains("mean"), contains("std"))

#giving descriptive names to activities in the data set
tidyData$code <- activities[tidyData$code, 2]

#giving descriptive variable names
names(tidyData)[2] = "activity"
names(tidyData)<-gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData)<-gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData)<-gsub("BodyBody", "Body", names(tidyData))
names(tidyData)<-gsub("Mag", "Magnitude", names(tidyData))
names(tidyData)<-gsub("^t", "Time", names(tidyData))
names(tidyData)<-gsub("^f", "Frequency", names(tidyData))
names(tidyData)<-gsub("tBody", "TimeBody", names(tidyData))
names(tidyData)<-gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-std()", "STD", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("angle", "Angle", names(tidyData))
names(tidyData)<-gsub("gravity", "Gravity", names(tidyData))

#creating new data set with the average of each variable for each activity and each dataset
exportData <- tidyData %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(exportData, "exportFile.txt", row.names = FALSE)
