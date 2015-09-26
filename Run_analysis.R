library(data.table)
library(ttutils)
mypath <- "C:/Users/Rivaldo/Documents/cleandata"
setwd(mypath)
#getwd()
myurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
myfile <- "myDataset.zip"
if (!file.exists(mypath)) {dir.create(mypath)}
download.file(myurl, file.path(mypath, myfile))

#uncompress=================
unzip <- file.path("C:", "Program Files (x86)", "7-Zip", "7z.exe")
parameters <- "x"
cmd <- paste(paste0("\"", unzip, "\""), parameters, paste0("\"", file.path(mypath, myfile), "\""))
system(cmd)
#================
# investigating and giving table format of the files
newpath <- file.path(mypath, "UCI HAR Dataset") # use the old path to built new path
# list.files(newpath, recursive=TRUE)           #to see all the file inside
mySubjectTrain <- fread(file.path(newpath, "train", "subject_train.txt")) 
mySubjectTest  <- fread(file.path(newpath, "test" , "subject_test.txt" ))
myTrainY <- fread(file.path(newpath, "train", "Y_train.txt"))# compatible with activity labels
myTestY  <- fread(file.path(newpath, "test" , "Y_test.txt" ))# compatible with activity labels
unique(mySubjectTrain)  # 70% of the Total
dim(mySubjectTrain)
unique(mySubjectTest)  # 30% of the Total
dim(mySubjectTest)
unique(myTrainY)  # compatible with activity_label
unique(myTestY)  # compatible with activity_label
pathFeatures <- file.path(newpath, "features.txt")
myFeatures<- fread(pathFeatures)
myFeatures<- data.table(myFeatures)
dim(myFeatures) # Now I realize that this are the columns names
class(myFeatures)

#=================================================
# fast and friendly does not working well to open X_test and X_training. let's use read.table
pathTest <-  file.path(newpath, "test" , "X_test.txt" )
pathTrain <- file.path(newpath, "train", "X_train.txt")
myTest <- read.table(pathTest)
myTrain <- read.table(pathTrain)
# giving format as table
myTest<- data.table(myTest)        # ok
myTrain <- data.table(myTrain)     # ok
# head(myTest) # to check if it works
#dim(myTrain)
#dim(myTest)
tableActiv <- rbind(myTrain, myTest)
#head(tableActiv)
#================================================
#changing names of tableActiv
old <- names(tableActiv) 
new <- as.character(myFeatures$V2)
setnames(tableActiv, old, new)
#head(tableCActivity)
#==================================================
#Mering Subject. Changing the column name of subject
mySubject<- rbind(mySubjectTrain,mySubjectTest)
setnames(mySubject,"V1", "Subject")
#==================================================
#Mering Activity. Changing the column name of Activity
myActivity <- rbind(myTrainY,myTestY)
setnames(myActivity,"V1", "Activity")
for(i in 1:10299){  
  if(myActivity$Activity[i]== 1){
    myActivity$Activity[i]= "WALKING"}
  if (myActivity$Activity[i]== 2){
    myActivity$Activity[i]= "WALKING_UPSTAIRS"}
  if(myActivity$Activity[i]== 3){
    myActivity$Activity[i]= "WALKING_DOWNSTAIRS"}
  if(myActivity$Activity[i]== 4){
    myActivity$Activity[i]= "SITTING"}
  if(myActivity$Activity[i]== 5){
    myActivity$Activity[i]= "STANDING"}
  if(myActivity$Activity[i]== 6){
    myActivity$Activity[i]= "LAYING"}
i = i + 1
  }
#==================================================
#join the Subject and tableActiv
tableComplete <- cbind(mySubject,myActivity,tableActiv)


#====================================================
#to use the grep function later, I has to activate stringsAsFactors = default.stringsAsFactors()
tableComplete <- as.data.frame(tableComplete, stringsAsFactors = default.stringsAsFactors()) 

subtable <- tableComplete[grep("Subject|Activity|mean[()]|std[()]", names(tableComplete))]

#====================================================
# doing the average of each variable by subject by activity 
result =list()  
result2 = list()
for(i in 1:30){
  
  filtered <- subset(subtable, Subject == i & Activity == "WALKING")
  mysubsetW  <- as.vector(colMeans(filtered[,3:68]))
  filtered <- subset(subtable, Subject== i & Activity =="WALKING_UPSTAIRS")
  mysubsetWup <- as.vector(colMeans(filtered[,3:68]))
  filtered <- subset(subtable, Subject== i & Activity =="WALKING_DOWNSTAIRS")
  mysubsetWdn <- as.vector(colMeans(filtered[,3:68]))
  filtered <- subset(subtable, Subject== i & Activity =="SITTING")
  mysubsetStt <- as.vector(colMeans(filtered[,3:68]))
  filtered <- subset(subtable, Subject== i & Activity =="STANDING")
  mysubsetStd <- as.vector(colMeans(filtered[,3:68]))
  filtered <- subset(subtable, Subject== i & Activity =="LAYING")
  mysubsetLy <- as.vector(colMeans(filtered[,3:68]))
  AVG <- cbind(mysubsetW, mysubsetWup, mysubsetWdn, mysubsetStt, mysubsetStd, mysubsetLy)
  result[i] <- list(cbind(rep(i,6), c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                                                                      "SITTING","STANDING","LAYING" ), t(AVG)))
  
  result2 <- (merge(result2, result[i]))
  
}


result2 <- as.data.frame(result2)

mytidy = data.frame()
colnames(result2) <- rep(colnames(subtable),30)

for(i in 1:30){

mytidy <- rbind(mytidy[], result2[,(68*i-67):(68*i)])
}
rownames(mytidy) <- c(1:180)
dim(mytidy)


write.table(mytidy,"tidy_DG.txt", sep="\t", row.names = FALSE)



