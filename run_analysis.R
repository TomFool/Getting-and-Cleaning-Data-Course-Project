##------------------------------------------
##Call libraries
##------------------------------------------
library(dplyr)

##------------------------------------------
##Read in and set up files
##------------------------------------------

##Set Your WD Here If You Want To Change Automatically
##setwd("C:/Users/XXXXX/Documents/R/Coursera/Data W4/UCI HAR Dataset")


##Test Data
xtest <- read.table("./test/X_test.txt") ## data
ytest <- read.table("./test/y_test.txt") ## activity ID
stest <- read.table("./test/subject_test.txt") ##s ubject ID

##Train Data
xtrain <- read.table("./train/X_train.txt") ##data
ytrain <- read.table("./train/y_train.txt") ## activity ID
strain <- read.table("./train/subject_train.txt") ## subject ID

##Get names for measurements
features <- read.table("features.txt")

##Get activity names
activities <- read.table("activity_labels.txt")

##Clean features names by removing "-" and "()"
features[,2] <- gsub("-",".",features[,2])
features[,2] <- gsub("\\()","",features[,2])
features[,2] <- gsub("\\(",".",features[,2])
features[,2] <- gsub("\\)","",features[,2])
features[,2] <- gsub("\\,",".",features[,2])

##Clean activity names
activities <- gsub("_",".",activities[,2])

## Merge each Test and Train set Together
x.all <- rbind(xtest,xtrain)
y.all <- rbind(ytest,ytrain)
s.all <- rbind(stest,strain)

## Name each column
names(x.all) <- features[,2]
names(y.all) <- "activity.id"
names(s.all) <- "subject.id"

all.data <- cbind(s.all,y.all,x.all)

##--------------------------------------------
## Subset data with "mean" and "std"
##--------------------------------------------

# Create index of desired columns -- first (s), second (y), and all columns from x that have "mean" or "std" in them (ignoring case)
sub.columns <- c(1,2,grep(("mean|std"),names(all.data), ignore.case = TRUE))
sub.data <- all.data[,sub.columns]

##-------------------------------------------
## Make variables descriptive and organize data neatly
## This produces the required output for Step 4 as sub.data
##-------------------------------------------

## Use names of activies in place of numbers
sub.data$activity.id <- activities[sub.data$activity.id]

## Sort data by subject, then by activity
sub.data <- sub.data[order(sub.data$subject.id, sub.data$activity.id),]


##-------------------------------------------
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## This produces the required output for Step 5 as mean.sub.data
##-------------------------------------------
mean.sub.data <- sub.data %>%
  group_by(subject.id, activity.id) %>%
  summarise_each(funs(mean))

##-------------------------------------------
## Write extracted tables to file
##-------------------------------------------
write.csv(sub.data, "mean_and_std_data.csv")
write.csv(mean.sub.data, "averaged_activity_by_subject_mean_and_std_data.csv")
