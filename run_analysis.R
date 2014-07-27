## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set.
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
## A full description is available at the site where the data was obtained can be found at:
## http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip

## Setup
setwd(".")
if (!require("data.table")) {
  install.packages("data.table")
}
if (!require("reshape2")) {
  install.packages("reshape2")
}
require("data.table")
require("reshape2")

## Here are the data for the project:
fileurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "getdata-projectfiles-UCI HAR Dataset.zip")
filename <- "getdata-projectfiles-UCI HAR Dataset.zip"
if (!file.exists(filename)) {
  print(paste("expected data file '", filename, "' data file does not exist.", collapse = ""))
  quit(save = "no")
}
unzip(filename)
datapath <- function(file) {
  paste0("./UCI HAR Dataset", "/", file, collapse = "")
}
variable <- c(
  "f",
  "t",
  "Acc",
  "Body",
  "Jerk",
  "Mag",
  "Gyro",
  "Gravity",
  "mean()",
  "std()",
  "meanFreq()",
  "X",
  "Y",
  "Z",
  "gravity",
  "Mean"
)
variablename <- c(
  "Fast_Fourier_Transformed",
  "Time_Domain",
  "Linear_Acceleration",
  "Body",
  "Jerk",
  "Euclidean_Norm_Magnitude",
  "Gyroscope",
  "Gravity",
  "Mean",
  "Standard_Deviation",
  "Mean_Frequency",
  "X_Axis",
  "Y_Axis",
  "Z_Axis",
  "Gravity",
  "Mean"
)
feature <- data.frame(variable, variablename, stringsAsFactors = F)

## Create a more descriptive dataset
mydata <- function(name) {
  camelcase <- function(label) {
    if (nchar(label) == 1) {
      label
    } else {
      gsub("([A-Z])", " \\1", label)
    }
  }
  makereadable <- function(abbrs) {
    Decode <- function(abbr) {
      feature[feature$variable == abbr, 2]
    }
    
    vars <- strsplit(camelcase(abbrs), " ")[[1]]
    vars <- sapply(vars, Decode)
    paste(vars, collapse = "_")
  }
  readable <- gsub("BodyBody", "Body", name) 
  if (length(grep("^angle\\(", name)) == 1) {
    variables <- strsplit(gsub("^angle\\(|\\)", "", name), ",")[[1]] 
    variables <- sapply(variables, makereadable)
    readable <- paste0("Angle_", variables[1], "_and_", variables[2], collapse = "")
  } else {
    variables <- strsplit(readable, "\\-")[[1]]
    readable <- sapply(variables, makereadable)
    readable <- paste(readable, collapse = "_")
  }
  readable
}

## Merges the training and the test sets to create one data set.
ucihardata <- function(name, feature, activity) {
  readdata <- function(type, cols) {
    file.path = datapath(paste0(name, "/", type, "_", name, ".txt"))
    read.table(file.path, stringsAsFactors = F, col.names = cols)
  }
  xdata = readdata("X", feature)
  subject = readdata("subject", c("Subject"))
  activity = readdata("y", c("Activity"))
  featuresmsd <- grep("mean\\(\\)|std\\(\\)|Mean", feature)
  xdata <- xdata[,featuresmsd]
  featuresall <- sapply(feature[featuresmsd], mydata)
  names(xdata) <- featuresall
  cbind(subject, activity, xdata)
}

## Create the final data set
dataanalysis <- function() {
  features <- read.table(datapath("features.txt"), stringsAsFactors = F, row.names = 1, col.names = c("id", "name"))
    actnames <- read.table(datapath("activity_labels.txt"), stringsAsFactors = F, col.names = c("code", "Activity"))
  train <- ucihardata("train", features$name, activity)
  test <- ucihardata("test", features$name, activity)
  merged <- rbind(train, test)
  averages <- aggregate(merged, by = list(merged$Activity, merged$Subject), FUN = "mean")
  averages <- merge(actnames, averages, by.y = "Activity", by.x = "code", all.y = T)
  averages$code = NULL
  averages["Group.1"] = NULL
  averages["Group.2"] = NULL
    write.csv(averages, file = "./UCIHARaverages.txt", row.names = F)
}
dataanalysis()
seedata<- read.table("./UCIHARaverages.txt", sep=",", header = T)
View(seedata)
