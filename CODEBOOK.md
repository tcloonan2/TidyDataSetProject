#CODEBOOK
#Tidying Of Human Activity Recognition Data Using Smartphones Dataset
#Version 1.0

#==================================================================
#Author: Tom Cloonan
#==================================================================



#Overview

This file contains details on how all the variables and summaries were calculated in the 
run_analysis.R script file.

In general, this project will create a single script whose goal is to create a tidy dataset from many data sources.
In particular, the data sourced are linked to from the course website, and they represent data collected from
the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site 
where the data was obtained:
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

 The data for the project are given here:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

We have assumed that this data has been downloaded to the sub-folders (from the current working directory)
called test and train...

These sub-folders will be subtended from the current working directory pointed to by R.
 
This particular R script is called run_analysis.R, and it does the following:
 1.	Merges the training and the test sets to create one data set.
 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
 3.	Uses descriptive activity names to name the activities in the data set
 4.	Appropriately labels the data set with descriptive variable names. 
 5.	From the data set in step 4, creates a second, independent tidy data set with the average of 
               each variable for each activity and each subject.


Thus, the script will produce two output files:
 A. 'FirstTidyDataSet.csv': Combined training and test data with only mean & standard deviation attributes (columns) 
   shown. This file is an output from the script file run_analysis.R.

 B. 'SecondTidyDataSet.csv': Combined training and test data with only mean & standard deviation attributes, 
   but combining rows that share common Subject and Activity values, and also calculating mean values from 
   the combined rows. This results in data for each Subject and Activity yielding a "mean of means" or
   "mean of standard deviations". This file is an output from the script file run_analysis.R.



#Format of Data in Files:

For each record in the original files, the following is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.



For each record in the two newly-created, "tidied-up" files, the following is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 86-feature vector with time and frequency domain variables (with only mean and standard deviation measurement 
    data). 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


# Program Flow

## Data Input of Training Data Files

Make three calls of the function read.table() to read the following three files into different data frames:
- ./train/X_train.txt     This file holds the actual measurements
This yields a 7352x561 dataframe called data_trainDF that holds the results (7352 sets of measurements = entries)

- ./train/y_train.txt     This file holds the activity code for each entry (row)
This yields a 7352x1 dataframe called activity_trainDF that holds the activity code (1-6) for each entry 

- ./train/subject_train.txt   This file holds the subject for each entry (row)
This yields a 7352x1 dataframe called subject_trainDF that holds the subject # (1-30) for each entry 


## Data Input of Test Data Files

Make three calls of the function read.table() to read the following three files into different data frames:
- ./test/X_test.txt     This file holds the actual measurements
This yields a 2947x561 dataframe called data_testDF that holds the results (2947 sets of measurements = entries)

- ./test/y_test.txt     This file holds the activity code for each entry (row)
This yields a 2947x1 dataframe called activity_testDF that holds the activity code (1-6) for each entry 

- ./test/subject_test.txt   This file holds the subject for each entry (row)
This yields a 2947x1 dataframe called subject_testDF that holds the subject # (1-30) for each entry 

## Data Input of Activity Code Mapping Files
Make one call of the function read.table() to read the following file into a data frame:
- ./activity_labels.txt     This file holds the code-to-activity mappings
This yields a 1x6 vector called code_activityDF that holds the mappings


## Data Input of Feature Code Mapping Files
Make one call of the function read.table() to read the following file into a data frame:
- ./features.txt     This file holds the code-to-feature (column) mappings
This yields a 1x6 vector called code_columnDF that holds the mappings

## Combinations of Data Frames
Add correct labels to the columns of data_trainDF and data_testDF.

Use the cbind() function to insert subject_trainDF and active_trainDF to the first 2 columns of data_trainDF,
with the resultant stored in the new data frame called total_trainDF.

Use the cbind() function to insert subject_testDF and active_testDF to the first 2 columns of data_testDF,
with the resultant stored in the new data frame called total_testDF.

Use the rbind() function to append the rows of total_testDF below the rows of total_trainDF,
with the resultant stored in the new data frame called totalDF.


## Over-writing of Activity Codes with Activity Names in totalDF
Replace the Activity Codes in column 2 of totalDF with Activity Names using the code_activityDF dataframe mappings

## Exclusion of Measurement Columns that do NOT Include Mean or std labels
Filter out all columns in totalDF that do NOT include Mean or std labels, with the
resultant stored in the new data frame called finalDF

## Outputting of First Tidy Data Set
Print out the finalDF data frame to a tab-delimited text file in the current working directory.
The file is called "FirstTidyDataSet.txt".

## Combination of Multiple Rows with the Same Subject & Activity Values into Single Rows & Calculation of Means
Combine multiple rows in finalDF that have the same Subject & Activity values (in columns 1 & 2) together.
For the combined measurements, use the colMeans() function to re-calculate the average value of all combined
rows as the new value to be used in the resultant combination row. This will create "means of means" and "means
of standard deviations" for the final values stored, with the resultant in the new data frame called secondDF.

## Outputting of Second Tidy Data Set
Print out the secondDF data frame to a tab-delimited text file in the current working directory.
The file is called "SecondTidyDataSet.txt".



#Important Data Variables In the run_analysis.R Script
There are many important data variables, including:
- data_trainDF... data frame that holds measurements from training sessions
- subject_trainDF... data frame that holds subject numbers (1-30) associated with each entry in the data_trainDF
- activity_trainDF... data frame that holds activity codes (1-6) associated with each entry in the data_trainDF
- total_trainDF... data frame that holds the resulting combined training data from the 3 above data frames

- data_testDF... data frame that holds measurements from test sessions
- subject_testDF... data frame that holds subject numbers (1-30) associated with each entry in the data_testDF
- activity_testDF... data frame that holds activity codes (1-6) associated with each entry in the data_testDF
- total_testDF... data frame that holds the resulting combined test data from the 3 above data frames

- code_activityDF... data frame that holds the mappings between codes and activities
- code_columnDF... data frame that holds the mappings between codes and column labels (the measurement)

- totalDF... data frame that holds the row-wise combined values from total_trainDF and total_testDF
- finalDF... data frame that holds the data frame that has only totalDF measurement columns with Mean or std in them
- secondDF... data frame that holds the data frame with combined rows that have common Subject/Activity values, 
                plus with means of the measurement values that were combined together
				
				
#Outputs from the run_analysis.R Script
There are two file outputs, including:
- "FirstTidyDataSet.txt"... a tab-delimited text file in the current working directory with finalDF data frame values
- "SecondTidyDataSet.txt"... a tab-delimited text file in the current working directory with secondDF data frame 
                               values

