

#Introduction

This file is helpful in order to understand the Run_analysis code. The 5 requeriments are done as follow:
1, 2, 4, 3, 5.

* An overview in the txt files was done. dim() and unique() were used in order to understand the files. X_test.txt and X_train.txt were open by read.table() instead of fread(). To merge the X_test.txt and X_train.txt files, I used the rbind().

* The features.txt file contains the names of the columns for  X_test and X_train tables. 

* Activity files (Y_train.txt and Y_test.txt) show number from 1 to 6, corresponding to WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.  Using a for loop I pass from number to names.

* The subject_train.txt file is assingn a number (1 to 30) corresponding to each participant in the training. The subject_test.txt file is assingn a number (1 to 30) corresponding to each participant in the test. Both subjects files were bind using rbind().

* A complete table is generated binding subject, activity, and test+train tables using cbind().

* The function grep() was used to generate a subtable, from the complete table, with columns names having "mean()" and "std()" characters.

* In order to obtain the average for each column variable, for each activity and each subject I used the command subset()
inside of a for loop havind a counter from 1 to 30 (each subject). Inside of this loop thre are condition (if) to select the activity. A local variable called filtered was needed filter by subject and activity. Other variables were created to save the results in the correct format.

* Finally, the requeriment 5 was present in a table called mytidy.

# Variable names

*  mySubjectTrain : data from subject_train.txt    
*  mySubjectTest  : data from  subject_test.txt
*  myTrainY    :  data from Y_train.txt            
*  myTestY     : data from Y_test.txt
*  myFeatures  : data from features.txt       
*  myTest      : data from X_test.txt
*  myTrain     : data from X_train.txt                 
*  tableActiv  : data from myTrain bind to myTest 
*  mySubject   : data from mySubjectTrain bind to mySubjectTest
*  myActivity  : data from myTrainY bind to myTestY
*  tableComplete : data from mySubject bind to myActivity bind to tableActiv
*  subtable    : table resulting from select "mean()" and "std()"
*  filtered    : local variable by activity and subject
*  mysubsetW, mysubsetWup, mysubsetWdn, mysubsetStt, mysubsetStd, mysubsetLy : local variables 
*  result      : variable to merge the result of local variables
*  result2     : to save  result in one unique list, then, transform in data.frame
*  mytidy      : tidy data set with the average of each variable for each activity and each subject. From result2.

