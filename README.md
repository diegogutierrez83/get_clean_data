

#Introduction

This file is helpful in order to understand the Run_analysis code. The 5 requeriments are done as follow:
1, 2, 4, 3, 5.

*An overview in the txt files was done. dim() and unique() were used in order to understand the files. X_test.txt and X_train.txt were open by read.table() instead of fread(). To merge the X_test.txt and X_train.txt files, I used the rbind().

*The features.txt file contains the names of the columns for  X_test and X_train tables. 

*Activity files (Y_train.txt and Y_test.txt) show number from 1 to 6, corresponding to WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.  Using a for loop I pass from number to names.

*The subject_train.txt file is assingn a number (1 to 30) corresponding to each participant in the training. The subject_test.txt file is assingn a number (1 to 30) corresponding to each participant in the test. Both subjects files were bind using rbind().

*A complete table is generated binding subject, activity, and test+train tables using cbind().

*The function grep() was used to generate a subtable, from the complete table, with columns names having "mean()" and "std()" characters.
