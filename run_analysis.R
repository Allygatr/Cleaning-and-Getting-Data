## Getting and cleaning Course Project
## Tidy a up data

## Question 1 
library(plyr)
library(dplyr)
library(data.table)

## Load in feautures and activity names

features = read.table("features.txt",header = FALSE)
activity_name = read.table("activity_labels.txt", header = FALSE)

## Load in training data

x_train = read.table("X_train.txt",header = FALSE)
y_train = read.table("Y_train.txt",header=FALSE)
subject_train = read.table("subject_train.txt",header=FALSE)


## Load in test data

x_test = read.table("X_test.txt",header = FALSE)
y_test = read.table("Y_test.txt",header=FALSE)
subject_test = read.table("subject_test.txt",header=FALSE)


## renaming x and y axis with features and activity names and subjects column

names(x_train) = features$V2
names(x_test) = features$V2

names(y_train) = "activity"
names(y_test) = "activity"

names(subject_train) = "subject"
names(subject_test) = "subject"

## Combine the data sets for training and test 

test = cbind(subject_test, y_test, x_test)

train = cbind(subject_train, y_train, x_train)

## Merging datasets

mtt = rbind(train,test)

## duplicates are present in the data, and must be removed

mtt2 = mtt[ , !duplicated(colnames(mtt))]

## arrange order of dataset in terms of subject and activity

mtt2 = arrange(mtt2, subject, activity)


## Question 2
## Extract mean and std for each measurement

mean_std = select(mtt2, subject,activity,matches("mean|std"))

## Question 3
## Descriptive names for each activity i.e 1 = walking

## mtt2$activity = gsub("1","Walking", mtt2$activity), this is method too long

act = factor(mtt2$activity, levels = 1:6, labels = activity_name$V2)

mtt3 = mutate(mtt2, activity = as.character(act))

## Question 4
## Appropriately label dataset with descriptive variable names

## Acceleration in time domain
names(mtt3) = gsub("tBodyAcc-","Body acceleration signal from accelerometer (time domain)", names(mtt3))
names(mtt3) = gsub("tGravityAcc-","Gravity acceleration signal from accelerometer (time domain)", names(mtt3))
names(mtt3) = gsub("tBodyGyro-","Body acceleration signal from gyroscope (time domain)", names(mtt3))

## Jerk signals in time domain
names(mtt3) = gsub("tBodyAccJerk-"," Jerk signal from accelerometer (time domain)", names(mtt3))
names(mtt3) = gsub("tBodyGyroJerk-","Jerk signal from gryoscope (time domain)", names(mtt3))

## Euclideon norm transformation

names(mtt3) = gsub("tBodyAccMag"," Magnitude of Body acceleration signal from accelerometer (Euclidean norm)", names(mtt3))
names(mtt3) = gsub("tGravityAccMag"," Magnitude of Gravity acceleration signal from accelerometer (Euclidean norm)", names(mtt3))
names(mtt3) = gsub("tBodyGyroMag"," Magnitude of Body acceleration signal from gyroscope (Euclidean norm)", names(mtt3))

names(mtt3) = gsub("tBodyAccJerkMag"," Magnitude of Jerk signal from accelerometer (Euclidean norm)", names(mtt3))
names(mtt3) = gsub("tBodyGyroJerkMag"," Magnitude of Jerk signal from gyroscope (Euclidean norm)", names(mtt3))


## Acceleration in Frequency domain
names(mtt3) = gsub("fBodyAcc-","FFT Body acceleration signal from accelerometer (frequency domain)", names(mtt3))
names(mtt3) = gsub("fBodyGyro-","FFT Body acceleration signal from gyroscope (frequency domain)", names(mtt3))

## Jerk signals in Frequency domain
names(mtt3) = gsub("fBodyAccJerk-","FFT Jerk signal from accelerometer (frequency domain)", names(mtt3))
names(mtt3) = gsub("tBodyGyroJerk-","Jerk signal from gryoscope (time domain)", names(mtt3))

## FFT applied to Magnitude of Euclidean norm
names(mtt3) = gsub("fBodyAccMag","FFT Magnitude of Body acceleration signal from accelerometer (Euclidean norm in frequency domain)", names(mtt3))
names(mtt3) = gsub("fBodyGyroMag","FFT Magnitude of Body acceleration signal from gyroscope (Euclidean norm in frequency domain)", names(mtt3))

names(mtt3) = gsub("fBodyAccJerkMag","FFT Magnitude of Jerk signal from accelerometer (Euclidean norm in frequency domain)", names(mtt3))
names(mtt3) = gsub("fBodyGyroJerkMag","FFT Magnitude of Jerk signal from gyroscope (Euclidean norm in frequency domain)", names(mtt3))

## Question 5
## Create a independent tidy data set with the average of each variable for each activity and each subject.

group = group_by(mtt3, subject, activity)

average_of_all_data = summarise_all(group, mean)

tidydata = average_of_all_data

## To produce table of tidy data

write.table(tidydata, "Tidy Dataset.txt")



