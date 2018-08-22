url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "./run_data.zip",method = "curl")
library(dplyr)
unzip("run_data.zip")
testdata <-read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE,sep = "")
testdata_1 <-read.table("./UCI HAR Dataset/test/Y_test.txt",header = FALSE,sep = "")
testdata_2 <-read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE,sep = "")
traindata <- read.table("./UCI HAR Dataset/Train/X_train.txt",header = FALSE,sep = "")
traindata_1 <- read.table("./UCI HAR Dataset/Train/Y_train.txt",header = FALSE,sep = "")
traindata_2 <-read.table("./UCI HAR Dataset/Train/subject_train.txt",header = FALSE,sep = "")
actlabel <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE,sep = "")
totaldata <- rbind(testdata,traindata)
totaldata1 <-rbind(testdata_1,traindata_1)
totaldata_1 <- rbind(testdata_2,traindata_2)
totaldata1 <-cbind(totaldata1,totaldata_1)
colnames(totaldata1) <-c("Act_ID","Sub")
## step 1 completed
featuredata <- read.table("UCI HAR Dataset/features.txt",header = FALSE,sep = "")
featuredata <- featuredata[,-1]
colnames(totaldata) <- featuredata
totaldatas <- totaldata[,grep("mean|std",names(totaldata))]
totaldatas <-totaldatas[,-grep("Freq",names(totaldatas))]
## step 2 completed
totaldata2 <-cbind(totaldata1,totaldatas)
actlabels <-merge(actlabel,totaldata2,by.x = "V1",by.y = "Act_ID",all = TRUE)
actlabels <-rename(actlabels,Act_ID = "V1")
actlabels <-rename(actlabels,Act_label = "V2")
## step 3 completed
names(actlabels) <-gsub("()","",names(actlabels),fixed = TRUE)
## step 4 completed
actlabels1 <- actlabels %>% group_by(Sub,Act_label) %>% summarise_all(mean)%>%
print
## step 5 completd
