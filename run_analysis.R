# Load all necessary data using read.table(). Default sep argument may
# be used since all breaks are white spaces or line breaks
#=======================================================================
features       = read.table("UCI HAR Dataset/features.txt")

x_test         = read.table("UCI HAR Dataset/test/x_test.txt")
subj_test      = read.table("UCI HAR Dataset/test/subject_test.txt")
actlab_test    = read.table("UCI HAR Dataset/test/y_test.txt")

x_train        = read.table("UCI HAR Dataset/train/x_train.txt")
subj_train     = read.table("UCI HAR Dataset/train/subject_train.txt")
actlab_train   = read.table("UCI HAR Dataset/train/y_train.txt")


# Combine the data with the activity labels and subjects for both test
# and training sets, then merge them and rename the columns to terms
# in the features document
#=======================================================================
x_test  = cbind(actlab_test, subj_test, x_test)
x_train = cbind(actlab_train, subj_train, x_train)
x_train = rbind(x_test, x_train)
colnames(x_train) = c("Activity", "Subject", as.character(features$V2))


# Create a vector of indices from the preloaded features vector that 
# contain the terms "mean" and "std". Add 2 to account for Activity
# and Subject columns. Subset the columns of the main data set with
# those indices.
#=======================================================================
features_mean_std = sort(c(grep("mean", as.character(features$V2), 
                                ignore.case = TRUE), 
                           grep("std", as.character(features$V2), 
                                ignore.case = TRUE))) + 2

x_train = x_train[, c(1, 2, features_mean_std)]


# Replace the activity labels with the actual names of activities
#=======================================================================
x_train[x_train$Activity==1, "Activity"] = "Walking"
x_train[x_train$Activity==2, "Activity"] = "Walking Upstairs"
x_train[x_train$Activity==3, "Activity"] = "Walking Downstairs"
x_train[x_train$Activity==4, "Activity"] = "Sitting"
x_train[x_train$Activity==5, "Activity"] = "Standing"
x_train[x_train$Activity==6, "Activity"] = "Laying"


# Clear up memory by removing all but the clean dataset
#=======================================================================
data_clean = x_train
remove(actlab_test, actlab_train, subj_test, subj_train,
       x_test, x_train, features)


# Split the clean data by activity and subject
#=======================================================================
data_split = split(data_clean, 
                   list(as.factor(data_clean$Activity), 
                        as.factor(data_clean$Subject)))

# Calculate mean for each column for each member of the split data
#=======================================================================
data_clean_means = data.frame()
data_clean_subjact = data.frame()

i = 1
while(i<=length(data_split)){
  data_clean_subjact = rbind(data_clean_subjact, data_split[[i]][1,1:2])
  data_clean_means = rbind(data_clean_means, 
                           sapply(data_split[[i]][,3:88], 
                                  function(x) mean(as.numeric(x))))
  i = i+1
}

data_clean_means = cbind(data_clean_subjact, data_clean_means)


# Fix up the column and row names, remove unnecessary data
#=======================================================================
colnames(data_clean_means) = names(data_clean)
rownames(data_clean_means) = 1:nrow(data_clean_means)

remove(features_mean_std, i, data_split, data_clean_subjact)
