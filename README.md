                          = WEARABLE COMPUTING =

The purpose of this project is to prepare a tidy data set that
can be used for analysis.

It transforms a set of preprocessed data collected from accelerometers and
gyroscopes from Samsung Galaxy S smarphones while their owners were performing
different activities (walking, walking upstairs, walking downstairs, sitting,
standing, laying)

Prior to the processing, the input data sets have to be downloaded from the internet
(link:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
and decompressed (performing just an "extract here") in the working directory.

As output, a file named tidyData.txt will be produced in the working directory.
This file can be uploaded, for instance with the R Command 
		tidy.data<-read.table("tidyData.txt")
for further processing or analysis.
   
0. Deliverables
===============
You will find the following three deliverables as part of this WEARABLE COMPUTING project.
    README.md      : the present file
    CodeBook.md    : which describes the variables of tidyData
    run_analysis.R : the R script to produce the tidyData.txt file from the source data sets

I.  Source Files
================
As already said, the source files must be downloaded from the internet with the link provided.
Once decompressed into the working directory, the unzipper creates a subdirectory called "UCI HAR Dataset"
which contains :
	* a test  directory, containing 30% of the observations
	* a train directory, with the remaining 70% of the observations
	* several txt files explaining the nature of the input data sets and the preprocessing done to
	  get them from the raw signals of the smart phones.

II. Processing
==============
The processing is performed by running the script run_analysis.R preferably within an R IDE such
as RStudio.

 1. Preconditions
		* the execution should be done in the directory where the source zip has been decompressed.
		  You may derogate to this by adapting the setwd(".") command on line 5
		* The source data should be located in the "./UCI HAR Dataset" subdirectory.
		  You may adapt the variable dd (which stands for data directory) on line 6 :
		  dd="./UCI HAR Dataset", should you prefer to have the data files somewhere else
		* The R package "reshape2" should be available.
		  
 2. Execution
	The execution runs in several steps :
	    0. identify the name of the features to be captured and load them from the training set.
		1. load similarly the test set and merge with the training set loaded in step 1
		2. step 2 ensures that only mean and std measurements are kept. No processing needed here
		   as the filtering is done earlier, within steps 0 and 1, to preserve the CPU and memory.
		3. Uses descriptive activity names to name the activities in the data set
		4. Appropriately labels the data set with descriptive variable names.
		5. Creates a second, independent tidy data set with the average of each variable.
	For further explanation, the reader is referred to the script itself which is amply annotated.
	As indication, the processing takes about 2 minutes on a 5 year old Pentium laptop running windows 64 bits,
	with 4GB memory
 
 3. Postcondition
	In the IDE, you will have:
		* a data.frame named "observations.all" counting 10,299 observations on 69 variables.
		* a data.frame names "tidy.dataset" which aggregates (mean of observations) the observations on basis
		  of the subject.id (30 items) and the activity (6 items). The tidy.dataset counts 180 observations
		  (30 x 6) and 68 variables. The data.source variable is dropped as there is no distinction
		  to be made between the training and the test data.
	The working directory will contain:
		* a file named "tidyData.txt" with the contents of the tidy.dataset
		
III. Resulting Dataset
======================
We refer you to the file "CodeBook.md" for a description of the variables which compose the
"tidyData.txt" dataset.

IV. License
===========
Use of this dataset in publications must be acknowledged by referencing the following publication
	Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
	Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.
	International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors
or their institutions for its use or misuse. Any commercial use is prohibited.
	Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.