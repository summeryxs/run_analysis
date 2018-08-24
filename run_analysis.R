url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "./run_data.zip",method = "curl")
library(dplyr)
unzip("run_data.zip")
##read test data
testdata <-read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE,sep = "")
testdata_1 <-read.table("./UCI HAR Dataset/test/Y_test.txt",header = FALSE,sep = "")
testdata_2 <-read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE,sep = "")
##read train data
traindata <- read.table("./UCI HAR Dataset/Train/X_train.txt",header = FALSE,sep = "")
traindata_1 <- read.table("./UCI HAR Dataset/Train/Y_train.txt",header = FALSE,sep = "")
traindata_2 <-read.table("./UCI HAR Dataset/Train/subject_train.txt",header = FALSE,sep = "")
##read activity and feature data
actlabel <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE,sep = "")
featuredata <- read.table("UCI HAR Dataset/features.txt",header = FALSE,sep = "")
## merge test and train data
test_data <- cbind(testdata_1,testdata_2,testdata)
train_data <-cbind(traindata_1,traindata_2,traindata)
totaldata <- rbind(test_data,train_data)
## rename the merged dataframe
featuredata <-featuredata[,2]
featuredata <- as.character(featuredata)
colnames(totaldata) <- c("Activity_ID","Subject",featuredata)
## extract mean and std from the dataframe
totaldatas <- totaldata[,grep("Activity_ID|Subject|mean|std",names(totaldata))]
totaldatas <-totaldatas[,-grep("Freq",names(totaldatas))]
## use descriptive activity names to name the activities
names(actlabel) <-c("Activity_ID","Activity_label")
actlabels <-merge(actlabel,totaldatas,by = "Activity_ID",all = TRUE)
## use appropriate labels 
col_names <-colnames(actlabels)
col_names <-gsub("^t","Timedomain",col_names)
col_names <-gsub("^f","Frequencydomain",col_names)
col_names <-gsub("std","standard_deviation",col_names)
col_names <-gsub("Acc","accelerometer",col_names)
col_names <-gsub("freq","frequency",col_names)
col_names <-gsub("Gyro","gyroscope",col_names)
col_names <-gsub("Mag","magnitude",col_names)
colnames(actlabels) <-col_names
names(actlabels) <-gsub("()","",names(actlabels),fixed = TRUE)
## creates a tidy data set with the average of each variable for each activity and each subject
actlabels1 <- actlabels %>% group_by(Activity_ID,Activity_label,Subject) %>% summarise_all(mean)
## save the data to a .txt
write.table(actlabels1,file = "sport Data Analysis.txt",row.names = FALSE)
