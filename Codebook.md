---
title: "CodeBook"
author: "Allan C Hendrickse"
date: "07/03/2021"
output:
  html_document:
    df_print: paged
  word_document: default
---

## List of variables 

The list of variables were taken from the feature_info.txt file. Provided by: UCI Machine Learning Repository for the study, Human Activity Recognition Using Smartphones Data Set.

The data was collected from 30 subjects who performed specific activities, described later below. Measurements were taken and consolidated. The variables used are described below:

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Body, Gravity and Jerk (Sudden movement) acceleration signals in the time domain (*prefix of t) these were taken from accelerometers. 

tBodyAcc-XYZ 
tGravityAcc-XYZ
tBodyAccJerk-XYZ

Body, Gravity and Jerk (Sudden movement) acceleration signals in the time domain (*prefix of t) these were taken from gyroscopes.

tBodyGyro-XYZ
tBodyGyroJerk-XYZ

Magnitudes were then calculated for selected acceleration signals using Euclidean norms.

tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag

A Fast Fourier Transform (FFT) was applied to some of these signals and magnitudes. These signals are now in the frequency domain (*prefix of f).

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

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean


## List of Activities 

This is a short list exercises the subjects performed well a smartphone was attached to them. The data was originally labeled with numbers instead of the activity. Each number corresponded to a activity.

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

## Transformation and Work done

The goal of this project was to create a tidy dataset from data supplied to us from the source mentioned above. This is a list of transformation and work done on the data to clean it up.

1) Question 1

First step was to create a dataset for both training and test data using the txt files supplied.

read.table() function was used to load the text files. Read in only the relevant txt files

The test and training data frames were created using the cbind() function, to combine the subject, x test/train and y test/train data.

Second was to merge the 2 data frames.
Since both data frames have the same column names, it simplified matters and was able to merge the 2 data frames using rbind() function.

Once they were merged, an attempt to order the data with the arrange() function, from dplyr library, was made and an error occurred stating a duplicate error.

There were duplicate column names present. To remove these, the duplicated() function was used to identify the duplicate columns and used the code in the rscript to remove it.

Once the duplicates were removed, the data was ordered using arrange() in terms of subjecta and activity.

3) Question2 

The next question asked to extract all mean and standard deviation values for each variable. To do this the select() function was used and to identify the columns the matches() function was used to identify the variables that contained the phrases mean|std.

4) Question 3 

Question 3 asked to rename the activities (1-6) to their relevant names i.e. walking, laying, etc.

A separate 'act' variable was created in the factor class, to help rename the levels to their appropraite names.

Mutate() function was then used to transform the rows of the activity column to their appropriate names

5) Question 4

Question 4 asked to appropriately rename variables. This was a little more tedious as the same step had to applied multiple times.
the gsub function was used to identify the pattern of the name that was selected to substitue with the relevant name. The names were taken from the features_info.txt file.

6) Question 5

The final question asked to extract a tidy data from the now cleaned data frame created. Only the average of each activity and variables for each subject was requested.

The first step was to group the data, using group_by() function. The data frame was grouped in terms of subject and activity. Once the groups were created, the summarise_all() function was used, as it applied the summarise() function to all variables selected. The mean() was applied to every variable to get the average for each one. 

Once the averages were extracted, write.table() function was used to produce a TidyData.txt file 

