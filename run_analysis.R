# library(plyr)
library(reshape2)

rm(list=ls());                      # clear workspace from all variables
setwd(".");                         # work directory
dd="./UCI HAR Dataset"              # data directory

###################################################################################################
# The data linked to from the course website represent data collected                             #
# from the accelerometers from the Samsung Galaxy S smartphone                                    #
# You should create one R script called run_analysis.R that does the following.                   #
# 1. Merges the training and the test sets to create one data set.                                #
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.      #
# 3. Uses descriptive activity names to name the activities in the data set                       #
# 4. Appropriately labels the data set with descriptive activity names.                           #
# 5. Creates a second, independent tidy data set with the average of each variable                #
#   for each activity and each subject.                                                           #
###################################################################################################


###################################################################################################
# 0.  Load the training data set
# 0.1 features : features data, i.e. Features Id's and names
fp<-file.path(dd,"features.txt")
features <- read.table(fp, header=F, as.is=T, col.names=c("feature.id", "feature.name"))

#     from features we derive variables.valid, an index vector which relates to
#     the variables having "mean()" or "std()" as part of their names.
#     Only those variables will be kept.
variables.valid<- grep(".*mean\\(\\)|.*std\\(\\)", features$feature.name)

# 0.2 x.table : x Data,  the actual observations, passing the featureNames as column ID
fp <- file.path(dd,"train", "X_train.txt")
x.table <- read.table(fp, header=F, col.names=features$feature.name)

#     we subset x.table to the mean() and std() variables, going from 561 to 66 variables
#     This is clearly an anticipation on step 2, which is done now to preserve cpu and memory.
x.table <- x.table[,variables.valid]

#     loading y.table with the activity data
fp <- file.path(dd, "train",  "y_train.txt")
y.table <- read.table(fp, header=F, col.names=c("activity.id"))

#     loading subject.table with the subject Id
fp <- file.path(dd, "train", "subject_train.txt")
subject.table <- read.table(fp, header=F, col.names=c("subject.id"))

#     assembling all data into observations.train, adding a column to keep track
#     of the data source
observations.train <- cbind(data.source="train",subject.table,y.table,x.table)

###################################################################################################
# 1.  Merges the training and the test sets to create one data set.
# 1.0 Load the test set, which basically repeats most of the previous steps
#      but from the test directory

#     this is basically similar to step O.

fp <- file.path(dd,"test", "X_test.txt")
x.table <- read.table(fp, header=F, col.names=features$feature.name)
x.table <- x.table[,variables.valid]
fp <- file.path(dd, "test",  "y_test.txt")
y.table <- read.table(fp, header=F, col.names=c("activity.id"))
fp <- file.path(dd, "test", "subject_test.txt")
subject.table <- read.table(fp, header=F, col.names=c("subject.id"))
observations.test <- cbind(data.source="test",subject.table,y.table,x.table)

# 1.1 Merging the train and test data sets
observations.all<-rbind(observations.train,observations.test)

# a bit of cleaning
rm(subject.table,x.table, y.table, fp, variables.valid)   #no further need of those ones
rm(observations.test, observations.train)                 #keeping observations.all only

###################################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

#    The subsetting has been done at an earlier stage for better efficiency
#    no additional step required here


###################################################################################################
# 3. Uses descriptive activity names to name the activities in the data set
#    I choose to convert activity.id into a factor with meaningfull levels

# turn "activity.id" into a factor
observations.all$activity.id<-as.factor(observations.all$activity.id)

# make sure to have 6 levels before converting them to meaningfull names
if(length(levels(observations.all$activity.id))==6){
  levels(observations.all$activity.id)<-c("walking","walking.upstairs","walking.downstairs",
                             "sitting","standing","laying")
} else {
  stop(simpleError("the dataset does not have all activities represented!!"))
}


###################################################################################################
# 4. Appropriately labels the data set with descriptive activity names.
#    as David Hood, Teaching Assistant, puts it "Horrible wording that should
#    get changed in the next run, but fix the column labels to describe what
#    the column represents


variables.names<-
  grep(".*mean\\(\\)|.*std\\(\\)", features$feature.name, value=T) # get the valid feature names 
variables.names<-
  gsub("([ABGJM])", "\\L\\.\\1", variables.names, perl=T)          # word separators iso uppercase letters
variables.names<-
  gsub("\\(\\)", "", variables.names, perl=T)                      # remove the parenthesis ()
variables.names<-
  gsub("-", ".", variables.names, perl=T)                          # dots iso - to separate words
variables.names<-
  gsub("(mean)\\.([XYZ])", "\\L\\2\\.\\1", variables.names, perl=T)# "mean" should be placed at the end
variables.names<-
  gsub("(std)\\.([XYZ])", "\\L\\2\\.\\1", variables.names, perl=T) # "std" also goes at the end
variables.names<-
  gsub("^t\\.", "time\\.", variables.names, perl=T)                # 't' designates a time variable
variables.names<-
  gsub("^f\\.", "frequency\\.", variables.names, perl=T)           # 'f' designates a frequency variable
variables.names<-
  gsub("\\.mag\\.", "\\.magnitude\\.", variables.names, perl=T)    # 'mag' expanded into 'magnitude'

names(observations.all)<-
  c("data.source","subject.id","activity",variables.names)         # replace all the names

#View(observations.all)                                            # show the results
rm(features)                                                       # delete work variables

###################################################################################################
# 5. Creates a second, independent tidy data set with the average of each variable
#   for each activity and each subject. 
# Words from David Hood:
# Both would technically be tidy (unless you combine activity and subject into
# a single entry or something like that).
# My sense is that most people are going for wide, feeling it is more natural,
# so having a results table with 180 (30 subjects * 6 activities) rows.
# Whichever you do, just make it clear in the readMe/ Codebook.

# I go for 180 rows (30 subjects times 6 activities) and
# 68 variables (removing the data.source which does not seem to be required)

# melt observations.all with no consideration for the data provenance (i.e. discard the data.source column)
observations.melted <- melt(observations.all[,2:69], id=c("subject.id", "activity"), measure.vars=variables.names)
# reassemble with the average of each variable
tidy.dataset<-dcast(observations.melted, subject.id + activity ~ variable, mean)
# save the resulting tidy dataset
write.table(tidy.dataset, "tidyData.txt")
# remove work variables
rm(dd,variables.names,observations.melted)
