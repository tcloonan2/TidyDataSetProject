
#README
#Tidying Of Human Activity Recognition Data Using Smartphones Dataset
#Version 1.0

#==================================================================
#Author: Tom Cloonan
#==================================================================



#Overview

This work was focused on creating a tidied-up version of data from a previous set of experiments that were

performed by:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments had been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 

wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 

we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments 

have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into 

two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then 

sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration 

signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter 

into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, 

therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained 

by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

Most of the new work added to this effort was to create two new output files that had "tidy data".

One of the files (FirstTidyDataSet.csv) included only mean and standard deviation attributes for data columns.

The other file (SecondTidyDataSet.csv) merged together row data to create rows that correspond to a particular

subject and activity (one subject/activity entry per line), and it carries the mean of the data for that 

particular subject and activity.



#Format of Data in Files

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



#Included Files in Dataset
The dataset includes the following files (the first 3 & last 2 are newly-created files for this class):
=======================================================================================================
- 'README.md' : Contains information about all included files in the data set.

- 'CODEBOOK.md' : Contains information about the inner workings of the analysis script file called run_analysis.R

- 'run_analysis.R' : Contains the script that reads in data from previously-existing files, modifies the data
                         (mostly compressing the data to include only mean & standard devition data and then
						 combining rows such that each row has a unique (Subject,Activity) pair in it and
						 then calculating the mean of all values that mapped into each row, and then 
						 printing out two newly-created files (FirstTidyDataSet.csv & SecondTidyDataSet.csv)
						 with the results)

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set of data.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- '

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. 
   Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis 
   in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 
   'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the 
   gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for 
   each window sample. The units are radians/second. 
   
- '

The following two new files are available as compressed versions of the data. 

- 'FirstTidyDataSet.csv': Combined training and test data with only mean & standard deviation attributes (columns) 
   shown. This file is an output from the script file run_analysis.R.

- 'SecondTidyDataSet.csv': Combined training and test data with only mean & standard deviation attributes, 
   but combining rows that share common Subject and Activity values, and also calculating mean values from 
   the combined rows. This results in data for each Subject and Activity yielding a "mean of means" or
   "mean of standard deviations". This file is an output from the script file run_analysis.R.

   
   
   
# Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ 
and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency 
of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration 
signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 
0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk 
signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals 
were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, 
tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, 
fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate 
frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. 
These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean



# Units of Collected Data
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.


   
   

#Notes 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

#License

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
