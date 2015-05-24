#### Class project: Getting and Cleaning Data
#### User: ddewq
#### May 2015 class

## Requirements:
#You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.



#### If the data needs to be downloaded - uncomment and run##
# Download and Unzip files
# fileurl <- https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip;
# download.file(fileurl, destfile = "./CourseProject/data.zip")
# unzip("./CourseProject/data.zip", exdir = "ProjectData")


library(dplyr) 

###### 1. Merges the training and the test sets to create one data set.

#### Read the data into a data.frame ####

##Load the location of the locally downloaded "Train" data into a variable 
trainx <- "./ProjectData/train/X_train.txt"
trainy <- "./ProjectData/train/y_train.txt"
subject_train <- "./ProjectData/train/subject_train.txt"

#Train Y is a one column list of the activity that was performed
ty <- read.table(trainy)

#Tain X is a 7352 row list that has 561 columns with data. Each row represents an activity\
tx <- read.table(trainx)

#Read in train subjects
train_sub <- read.table(subject_train)


#### Load the location of the locally downloaded "Train" data intto a variable ####
testy <- "./ProjectData/test/y_test.txt"
testx <- "./ProjectData/test/X_test.txt"
subject_test <- "./ProjectData/test/subject_test.txt"

#Test Y is a one column list of the activity that was performed
tey <- read.table(testy)

#Test X is a 2947 row list that has 561 columns with data. Each row represents an activity
tex <- read.table(testx)

#Read in test subjects
test_sub <- read.table(subject_test)



###### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
###### 3. Uses descriptive activity names to name the activities in the data set
###### 4. Appropriately labels the data set with descriptive variable names. 

#### Combine the Data together ####

act_data <- rbind(tex, tx) #Combind the test and training data (X) sets together
act_label <- rbind(tey,ty) #Combind the activity column (Y) sets together 
Subject <- rbind(train_sub, test_sub) #Combine train and test subject data
colnames(Subject) <- c("Subject") #Rename column namefor Subjects
comb_data <- cbind(act_label, act_data) #Combind the activity column to the data together. Activity is first column 


# Get the column names and apply them to the data
feat <- read.table("./ProjectData/features.txt") #Get the column names
cnames <- feat[,2] #Extract the column names from the 2nd column of the features.txt file 
colnames(comb_data) <- c('Activity', as.character(cnames)) 


# Extract only the measurements needed -find mean and std() and combine the subsets into a new data frame
mean <- c(1, as.integer((grep("-mean()", feat[,2], fixed = TRUE, value = FALSE) + 1))) # Returns back the column num of the mean col
std <<- c(as.integer((grep("-std()", feat[,2], fixed = TRUE, value = FALSE) + 1))) # Returns back the column num of the std col
                                                                                   # Note: +1 is required because the first column 
                                                                                   # is the Actiivty 
ext_data <- cbind(comb_data[,mean],comb_data[,std]) #combine and generate the new data set

# Add the activity names to the data set
activity <- read.table("./ProjectData/Activity_Labels.txt")
factivity = factor(activity[,2]) # Create factors based on the activity name
Activity_Name= factor(ext_data[,1], labels =a factivity)  # Get the list of the Activity Names
merged_data <- cbind(Activity_Name, ext_data) #Add the names of the activity to the data
full_data <- cbind(Subject, merged_data) #Add the Subjects to the data
full_data$Activity <- NULL #Remove the column with Activity number



# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.
#Read from https://class.coursera.org/getdata-014/forum/thread?thread_id=274

tidy_data <- full_data %>% group_by(Activity_Name,Subject) %>% summarise_each(funs(mean))
tidy_data_output <- data.frame(tidy_data)
write.table(tidy_data, file = "Project_tidy_output_ddewq.txt", row.names = FALSE) #Write out data to table
 