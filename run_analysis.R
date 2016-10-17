# Project Week 4 Assignment
# Student: Tom Cloonan
# School: Coursera 
# Program: Introduction to Data Sciences
# Course: Course 3- Getting and Cleaning Data
# Week: 4
############################################
# R Script: run_analysis.R
#
# This project will create a single script whose goal is to create a tidy dataset from many data sources.
# In particular, the data sourced are linked to from the course website, and they represent data collected from
# the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site 
# where the data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# The data for the project are given here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# I have assumed that this data has been downloaded to the sub-folders called test and train...
# These sub-folders will be subtended from the current working directory pointed to by R.
# 
# This particular R script is called run_analysis.R, and it does the following:
# 1.	Merges the training and the test sets to create one data set.
# 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.	Uses descriptive activity names to name the activities in the data set
# 4.	Appropriately labels the data set with descriptive variable names. 
# 5.	From the data set in step 4, creates a second, independent tidy data set with the average of 
#               each variable for each activity and each subject.
#
# Thus, the script will produce two output files:
# A. 'FirstTidyDataSet.csv': Combined training and test data with only mean & standard deviation attributes (columns) 
#   shown. This file is an output from the script file run_analysis.R.
#
# B. 'SecondTidyDataSet.csv': Combined training and test data with only mean & standard deviation attributes, 
#   but combining rows that share common Subject and Activity values, and also calculating mean values from 
#   the combined rows. This results in data for each Subject and Activity yielding a "mean of means" or
#   "mean of standard deviations". This file is an output from the script file run_analysis.R.


#
# Start of Code
###############
# get working directory to see if it was set correctly
getwd() 

# remove all old objects and variables from previous sessions
rm(list=ls()) 

# Training File Input
# read in the 3 training files into separate data frames (appropriately named to match the original filename)

# this is a 7352x561 dataframe that holds the results (7352 sets of measurements = entries)
data_trainDF <- read.table("./train/X_train.txt",header=FALSE) 

# this is a 7352x1 dataframe that holds the activity code (1-6) for each entry & add a column label 
activity_trainDF <- read.table("./train/y_train.txt",header=FALSE) 
colnames(activity_trainDF) = "Activity"

# this is a 7352x1 dataframe that holds the subject # (1-30) for each entry & add a column label 
subject_trainDF <- read.table("./train/subject_train.txt",header=FALSE) 
colnames(subject_trainDF) = "Subject"




# Test File Input
# read in the 3 test files into separate data frames (appropriately named to match the original filename)

# this is a 2947x561 dataframe that holds the results (2947 sets of measurements = entries)
data_testDF <- read.table("./test/X_test.txt",header=FALSE) 

# this is a 2947x1 dataframe that holds the activity code (1-6) for each entry & add a column label
activity_testDF <- read.table("./test/y_test.txt",header=FALSE) 
colnames(activity_testDF) = "Activity"

# this is a 2947x1 dataframe that holds the subject # (1-30) for each entry & add a column label
subject_testDF <- read.table("./test/subject_test.txt",header=FALSE)
colnames(subject_testDF) = "Subject"




# Activity Name File Input
# read in the Activity Name file into a single data frames (appropriately named to match the original filename)
# this provides the code-to-activity name association
code_activityDF <- read.table("./activity_labels.txt",header=FALSE)





# Column Name File Input
# read in the Column Name file into a single data frames (appropriately named to match the original filename)
# this provides the code-to-column name association
code_columnDF <- read.table("./features.txt",header=FALSE)



# Move the labels from column 2 in code_columnDF to a vector
labelFactor <- code_columnDF[ ,2]
labelVector <- as.character(labelFactor)




# Attach the descriptive labelVector labels to the column labels on data_trainDF and data_testDF
colnames(data_trainDF) <- labelVector
colnames(data_testDF) <- labelVector






# Now start combining columns for the training data dataframe
# Let's begin by combining the subject_trainDF and activity_trainDF dataframes
subj_act_trainDF <- cbind(subject_trainDF, activity_trainDF)

# Then let's combine the subj_act_trainDF and data_trainDF dataframes
total_trainDF <- cbind(subj_act_trainDF, data_trainDF)




# Then move to combining columns for the test data dataframe
# Let's begin by combining the subject_testDF and activity_testDF dataframes
subj_act_testDF <- cbind(subject_testDF, activity_testDF)

# Then let's combine the subj_act_testDF and data_testDF dataframes
total_testDF <- cbind(subj_act_testDF, data_testDF)



# Now let's combine the rows of the total_trainDF with rows of total_testDF
totalDF <- rbind(total_trainDF,total_testDF)



# Now change the 6 activity values in column 2 of totalDF from numbers to their descriptions
# using code_activityDF

# replace value i in totalDF with code_activityDF[i,2] value... use a loop
for (i in code_activityDF[ ,1]) {
	#totalBool <- totalDF[ ,2] == i
	# totalDF[totalBool,2] <- as.character(code_activityDF[i,2])
	codePointer <- min(which(code_activityDF[ ,1] == i))
	totalBool <- totalDF[ ,2] == i
	totalDF[totalBool,2] <- as.character(code_activityDF[codePointer,2])
}



# Now include only the columns of totalDF that are associated with mean "(.*[Mm]ean.*}" or std dev "(.*std.*)"
# The dataframe with only columns associated with mean or std dev will be called finalDF
goodColumnVector <- grepl("(.*ean.*)|(.*std.*)",names(totalDF))

# Add in TRUEs for goodColumnVector[1:2] to keep the "Subject" and "Activity" columns
goodColumnVector[1:2] <- TRUE
finalDF <- totalDF[ ,goodColumnVector]

# Write tab-delimited text file called FirstTidyDataSet in current working directory
#write.csv(finalDF, file = "./FirstTidyDataSet.csv")
write.table(finalDF, file = "./FirstTidyDataSet.txt",sep="\t")





# Using the finalDF data frame from above, calculate the second tidy data set containing
# the average of each variable for each activity and each subject. This dataframe will be called 
# secondDF.

firstTime <- TRUE
for (subjectVal in 1:30) {
	for (activityVal in as.character(code_activityDF[ ,2])) {
		goodRows <- (finalDF[,1] == subjectVal) & (finalDF[,2] == activityVal)
		tempDF <- finalDF[goodRows, ]
		newCol <- c(subjectVal,activityVal,as.numeric(colMeans(tempDF[,3:ncol(tempDF)])))
		if (firstTime == TRUE) {
			secondDF <- data.frame(newCol)
			firstTime <- FALSE
		}
		else {
			secondDF <- cbind(secondDF,newCol)
		}
	}
}

# transpose secondDF to turn columns back into rows
secondDF <- as.data.frame(t(secondDF))
# over-write the correct column names & row names
colnames(secondDF) <- colnames(finalDF)
rownames(secondDF) <- 1:nrow(secondDF)


# Write tab-delimited text file called SecondTidyDataSet in current working directory
write.table(secondDF, file = "./SecondTidyDataSet.txt",sep="\t")