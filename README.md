# Getting-and-Cleaning-Data-Course-Project
This repo contains required materials for Coursera's Getting and Cleaning Data Course Project (Week 4)

Dataset for this project can be downloaded here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
******************************************************************************************************
Files for project submission:
1. run_analysis.R
2. README.md
3. Code book titled "Coursera's Getting and Cleaning Data Course Project Code Book.pdf"
4. optional: unzip.R
******************************************************************************************************
How to:
1. Optional step: Download unzip.R to your working directory. Type > source("./unzip.R") on R console. 
   #Dataset will be downloaded and extracted to a folder called "Data" in user's working directory.
2. Download run_analysis.R to your working directory. Type > source("./run_analysis.R") on R console.
   #Script to analyse the downloaded dataset will be executed producing 2 outputs:
   #1. a merged dataset (for train and test data)
   #2. a tidy data set with the average of each variable for each activity and each subject
******************************************************************************************************
The analysis:
1. Firstly, the following files are read (or load) into R: subject_test.txt, y_test.txt, X_test.txt, 
   subject_train.txt, y_train.txt, X_train.txt, features.txt, activity_labels.txt
2. Then, change column names for both testdata and traindata to actual measurement names from 
   features.txt file (V2 column).
3. Merge subject, activity, and measurement data files for test data into 1 dataset by joining the 
   columns.
4. Repeat step 3 for train data.
5. After that, change column name for the first two columns from V1 to "subject id" and "activity 
   name", respectively.
6. Then, merge test and train dataset by joining the rows.
7. Force unique column names with valid characters on the merged dataset produced in step #6. 
   Then, assigned new column names to the dataset.
8. After that, other than subject.id and activity.names columns, extract only variables that measure 
   mean and standard deviation.
9. Then, sort the data by subject.id followed by activity.name in ascending order.
10. Change numerical representation on activity.name column to corresponding activity name from 
    activity_label.txt file.
11. Then, change the variable names to be more descriptive by substituting "t" to "time" and "f" to 
    frequency. Also, remove additional dots "." which was introduced when we forced unique column 
    names with valid characters in step #7.
12. Then, view merged dataset on data viewer. This is the first output of this analysis.
13. For the second dataset, group rows by subject id and activity name and then calculate the average 
    of each variables per group. 
14. Save the dataset as TXT file to working directory. Then open the file on data viewer with argument
    header = TRUE.
15. Finally, remove all objects created for this analysis, except the outputs, to clear the environment.
******************************************************************************************************
