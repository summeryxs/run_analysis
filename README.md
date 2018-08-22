# run_analysis
## The project has 5 steps as indicated in the course, I follow the requirments to complete. Here are the instructions for the project.
## Step 1: 
### 1)I downloaned the file from web and found it a .zip, so I needed to unzip it, and then chose the right files for data analysis. 
### 2)The files were stored in three different places, the sport data files were called "X_test" and "X_train", the people attended the experiments were stored in "subject_test" and "subject_train",and the activities they attended were stored in "Y_test" and "Y_train", so I use read.table to read the files first;
### 3)then bind sport data into one dataframe called "totaldata", people attended the experiment into one dataframe called "totaldata1"and the activities called "totaldata_1";
### 4)third,cbind people and activities into one dataframe and cover the original "totaldata1",so there were two dataframes, "totaldata" for sportsdata and "totaldata1" for people attended the activities, the "totaldata" contained all the data needed for further analysis,and "totaldata1" for the linkage among different dataframes.
## Step 2:
### 1)the "features.txt"contained the names of the sportdata, and should be connected with "totaldata" for further filter, so I first read the "features" and deleted the first col, leaving only names;
### 2)then rename the "totaldata" use colnames to make it look better to read;
### 3) the step 2 requested to extract mean and std,so grep was used twice to get the point and a new dataframe was created called"totaldatas";
## Step 3:
### 1)rbing the "totaldatas" and "totaldata1" as a new dataframe called"totaldata2", this one had integreted data information for activity ID, people attended and the sportdata;
### 2)merge "totaldatas" and activity label informaiton called "actlabel" to get the 6 activities with other sports and people information;
### 3)change the names of col to more descriptive ones, so I changed the V1 and V2 into "Act_ID" and "Act_label", and a new dataframe called "actlabels"
## Step 4:
### the "actlabels" had descriptive col already, but could be better, so I use gsub to deleted all the "()" of the col names.
## Step 5:
### 1)group by subject and action label;
### 2)summarise all the col mean.
