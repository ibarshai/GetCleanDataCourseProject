Getting and Cleaning Data Course Project
=====================================================

This repo contains the solution to the course project for Getting and Cleaning Data.

The files used in the run_analysis.R script are contained in a folder called "UCI HAR Dataset" in the working directory. 

The run_analysis.R does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

To accomplish the above, the following steps were taken:

* Load all necessary data using read.table(). Default sep argument may be used since all breaks are white spaces or line breaks.
* Combine the data with the activity labels and subjects for both test and training sets, then merge them and rename the columns to terms in the features document.
* Create a vector of indices from the preloaded features vector that contain the terms "mean" and "std". Add 2 to account for Activity and Subject columns. Subset the columns of the main data set with those indices.
* Replace the activity labels with the actual names of activities.
* Clear up memory by removing all but the clean dataset.
* Split the clean data by activity and subject and calculate mean for each column for each member of the split data by looping through the elements of the split list.
* Fix up the column and row names, remove unnecessary data.
* Write comma delimited txt files of the tidy data sets to the working directory