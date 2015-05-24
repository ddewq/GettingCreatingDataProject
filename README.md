# README for Getting and Cleaning Data Course 
Script name: run_analysis.R
User: ddewq
Course: May 2015

This README describes how the run_analysis.R script completes the 
assignment. The script assumes the data has been locally downloaded,
but if needed the section of code that downloads the files can be un-commented
and used to download and unzip the files.

The data used is obtained from: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


Library used:
- dplyr (used to create tidy data)

Files:
Script name: run_analysis.R
Code Book: Project_Data_Dictionary_ddewq.pdf


The following actions are performed in the R script.

1) Read in the Training and Test data along with the activity names and subjects. It merges
the data using rbind and cbind functions. These functions avoid the reordering that can be performed
when merging data using the merge() function.

2) After the data has been merged together, the mean() and std() data columns are selectively chosen
using the grep() function and using the factor() function the activity names are matched to the data set.
The column names are also added to the filtered table.

3) The filtered data is then tidied using the dplyr library to summarize the data
by Activity and Subject for each column by taking the average (mean) of the data. It is then 
written to a .TXT file with the write.table() function.

The code is commented throughout with commentary about each step.

The code book describes each of the column values in the table generated from the script.