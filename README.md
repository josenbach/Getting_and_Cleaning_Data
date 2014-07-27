Getting_and_Cleaning_Data
=========================

This repository contains my solution for the course project in the Coursera Getting and Cleaning Data course by Jeff Leek, Ph.D., Brian Caffo, Ph.D., & Roger D. Peng, Ph.D. of the Johns Hopkins Bloomberg School of Public Health (https://www.coursera.org/course/getdata).

The data set comes from the UCI Machine Learning Repository: Human Activity Recognition Using Smartphones Data Set (located here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, with the data used for the project located here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Citation: 
Anguita, D., Ghio, A., Oneto, L., Parra, X., & Reyes-Ortiz, J. L. (2012, December). Human activity recognition on smartphones using a multiclass hardware-friendly support vector machine. Paper presented at the International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. 

run_analysis.R is a script that merges the training and test data sets from the file, extracts the mean and standard deviation for each measurement, and creates a second clean data set with the average of each variable (column) of activity for each subject. Each subject has an average of each measurement on the phone of laying, sitting, standing, walking, walking downstairs, and walking upstairs (mydata.txt).

The training and test sets are merged together, provided with meaningful labels, activity labels are converted to sensible names and only the mean and standard deviations of the observations are retained. The resulting data set is written to a text file in the working directory. The script then produces an average for each of the subject-activity groups, and writes a second text file in the working directory with the resulting data set (cleanUCIHARDatasetAvgs.txt.txt).

The run_analysis.R script is commented to indicate which parts of the code are responsible for which transformations. See CodeBook.md for information on the variables of the data set.

The following is copied from the UCI HAR website (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones):

Source:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
Smartlab - Non Linear Complex Systems Laboratory 
DITEN - UniversitÃ  degli Studi di Genova, Genoa I-16145, Italy. 
activityrecognition '@' smartlab.ws 
www.smartlab.ws 

Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Check the codebook.md file for further details about this dataset.

Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.