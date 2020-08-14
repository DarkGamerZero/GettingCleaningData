The run_analysis.R script performs the data preparation, followed by the 5 steps required as described in the course project instructions.

* Download the dataset  
  Dataset downloaded and extracted under the folder called **UCI Datasets**

* Assign each data to variables
  1. features <- features.txt : (561 rows, 2 columns)
    * The features selected for this database come from the 3-dimensional spatial accelerometer and gyroscope readings. These values are available in the columns tAcc-XYZ and tGyro-XYZ respectively.
  2. activities <- activity_labels.txt : (6 rows, 2 columns)
    * List of activities performed when the corresponding measurements were taken and its codes (labels)
  3. subject_test <- test/subject_test.txt : (2947 rows, 1 column)
    * contains test data of 30% (9/30) of the volunteer test subjects being observed
  4. x_test <- test/X_test.txt : (2947 rows, 561 columns)
    * contains recorded features of the test data
  5. y_test <- test/y_test.txt : (2947 rows, 1 columns)
    * contains labels of the test data
  6. subject_train <- test/subject_train.txt : (7352 rows, 1 column)
    * contains training data of 70% (21/30) of the volunteer subjects being observed
  7. x_train <- test/X_train.txt : (7352 rows, 561 columns)
    * contains recorded features of the training data
  8. y_train <- test/y_train.txt : (7352 rows, 1 columns)
    * contains labels of the training data

* Merge the training and the test sets to create one data set
  1. x (10299 rows, 561 columns) is created by merging x_test and x_train using rbind() function in that order
  2. y (10299 rows, 1 column) is created by merging y_test and y_train using rbind() function in that order
  3. subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function in that order
  4. data (10299 rows, 563 column) is created by merging subject, x and y using cbind() function in that order

* Extract only the mean and standard deviation values for each measurement
  * data2 (10299 rows, 88 columns) is created by subsetting data, selecting only columns: Subject, Code and the measurements on the mean and standard deviation (std) for each measurement

* Use descriptive activity names to name the activities in the data set
  * Entire numbers in code column of data2 replaced with corresponding activity taken from second column of the activities variable

* Appropriately labels the data set with descriptive variable names
  * Code column in data2 renamed into Activities
  * All Acc in column’s name replaced by Accelerometer
  * All Gyro in column’s name replaced by Gyroscope
  * All BodyBody in column’s name replaced by Body
  * All Mag in column’s name replaced by Value
  * All start with character f in column’s name replaced by Frequency
  * All start with character t in column’s name replaced by Time
  * All function names in culumn's names replaced with just the names
  * Put angle and gravity in uppercase

* From the data set in step 4, creates a second, independent data set with the average of each variable for each activity and each subject
    * final (180 rows, 88 columns) is created by sumarizing data2; taking the means of each variable for each activity and each subject, after grouping them by subject and activity.
    * Export final into Final.txt file.
