#after datasets are extracted to data folder in working directory, 
#load following files on R:

testsubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
testlabel <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
testdata <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
trainsubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
trainlabel <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
traindata <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")
actlabel <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#change column names for both test and train data files 
#to actual measurement names from features.txt file
colnames(testdata) <- features$V2
colnames(traindata) <- features$V2

#merge subject, label, and data files into one by joining the columns
testmerge <- cbind(testsubject, testlabel, testdata)
trainmerge <- cbind(trainsubject, trainlabel, traindata)

#change column name from V1 (both subject & label files) to more descriptive name
colnames(testmerge)[1:2] <- c("subject id", "activity name")
colnames(trainmerge)[1:2] <- c("subject id", "activity name")

#merge both test and train dataset into one by joining the rows
mastermerge <- rbind(testmerge, trainmerge)

#convert column names to unique names with valid characters 
valid_column_names <- make.names(names=names(mastermerge), unique=TRUE, allow_ = TRUE)
names(mastermerge) <- valid_column_names 

#extract variables that measure the mean and standard deviation
mastermerge <- select(mastermerge, subject.id, activity.name, matches("\\.mean\\.|\\.std\\."))

#sort the rows by subject.is then activity.name
mastermerge <- arrange(mastermerge, subject.id, activity.name)

#change numerical representation on activity.name column to actual activity name 
#from activity_label.txt file
mastermerge$activity.name <- actlabel$V2[match(mastermerge$activity.name, actlabel$V1)]

#replace "t" in the variable name to "time"
names(mastermerge) <- sub("^t", "time.", names(mastermerge))

#replace "f" in the variable name to "freq" for frquency
names(mastermerge) <- sub("^f", "freq.", names(mastermerge))

#remove extra dots "."
names(mastermerge) <- sub("\\.\\.\\.", ".", names(mastermerge))
names(mastermerge) <- sub("\\.\\.$", "", names(mastermerge))

#open data viewer for merged dataset
View(mastermerge)

#create another dataset by grouping rows by subject id and activity name then 
#calculate the average of each variables per group
averagedata <- mastermerge %>% group_by(subject.id, activity.name) %>% summarise_all(mean)

#save tidy dataset to working directory as csv file
write.table(averagedata, file="tidydatamean.txt")

#read saved tidy dataset back into R and open it on data viewer
tidydatamean <- read.table("tidydatamean.txt")
View(tidydatamean)

#remove files used in the analysis from environment
rm(testsubject, testlabel, testdata, trainsubject, trainlabel, traindata, features, actlabel, testmerge, trainmerge, averagedata)
