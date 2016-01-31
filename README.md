==================================================================
Assignment: Getting and Cleaning Data Course Project

Version 1.0

==================================================================
Tom Foolery (anonymized)

https://github.com/TomFool/

==================================================================

This analysis file takes in data produced by the Human Activity Recognition Using Smartphones Dataset.  Information about obtaining this data set is below:

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

Last Accessed: 1/29/2016 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


This script attempts to turn the raw data from the above's ./train and ./test into 2 unifed and tidy data sets.  It then outputs two .csv files containing the sets.





The script first reads in the files assuming that the working directory is the base folder for the UCI HAR Data set above.

The script then reads in X_train, subject_train, y_train, X_test, subject_test, y_test.

The script then reads in supporting documentation "features" and "activity_labels"

Features is the proper variable names for the X_train and X_test data sets, so the script then cleans up features to prepare for this use.  It does this by replacing "-", ",", and "(" with "." as well as removing entirely "()" and ")"

Activity_labels is similarly cleaned by replaceing "-" with "."

The script then combines all each pair of files (X_train with X_test; y_train with y_test; etc.).

The script then applies tidy labels to the 3 sets of data.  Features, as modified above, is used as the variable names for "X".  Subject is renamed "subject.id".  Y is renamed "activity.id".

The script then creates a unified data set ("all.data") arranged:

             1   2    3    4    5    ...
       "subject" "y" "X1" "X2" "X3" "X..."


The script then creates a new set containing only the identifiers (subject.id and activity.id) and variables contaning average or standard deviation data ("mean" or "std").  This is stored as sub.data.

Activity_labels is a human friendly list of the activities in English.  The script replaces the numeric "activity.id" values with the corresponding description in Activity_labels to make this variable more readable.

sub.data is now finalized.

The script then creates a second new data (mean.sub.data) set containg only the mean measurement for each subject-activity pairing in the above.  Ex. for Subject 1, 50 "Laying" measurements are taken for each of the remaining variables.  This data set takes the mean of each of those 50 measurements for each variable and collapses subject 1, laying into a single line with one measurement per variable.

mean.sub.data is now finalized.

The script then outputs a CSV file for both of the data sets created.
