# @author: AbhiGarg
#######################################################
#==========Setting up the Working Directory==========#
#######################################################
workingdirectory <- "/Users/AbhiGarg/Documents/Fall 2016/RandPython/THA 1"
setwd(workingdirectory)

###########################################
#==============Read in data===============#
#Read in the data for both data sets.	#
###########################################

hospitalData <- read.csv("CaliforniaHospitalData.csv", header = T)
names(hospitalData)
personnelData <- read.table("CaliforniaHospitalData_Personnel.txt", header = T, sep = "\t", quote = "\"")
names(personnelData)

##########################################
# ======Merging the two Data sets======  #
##########################################
mydata <- merge(hospitalData,personnelData, by = "HospitalID")
names(mydata)

##########################################
#After the data has been merged within R, please remove the following columns of data:
#  1. duplicate columns- There are no duplicate columns
#  2. Work_ID
#  3. Position_ID
#  4. Website
##########################################
mydata <- subset(mydata, select =-c(Work_ID,PositionID,Website))
nrow(mydata)
# Total 61 records found
names(mydata)

##############################################
# Select only those hospitals that are “Small/Rural” and have 15 or more available beds. 
##############################################
mydata <- mydata[(mydata$Teaching == "Small/Rural" & mydata$AvlBeds >14),]
nrow(mydata)
# Total 43 records found.

##################################################
#Exclude hospitals with a negative operating income. 
##################################################
mydata <- mydata[(mydata$OperInc>0),]
nrow(mydata)
# Total 28 records found.

##########################################################
# Export your data as tab- delimited and name the file hospital_data_new.txt.
##########################################################
write.table(mydata, file = "hospital_data_new.txt", sep="\t")
testingwrittendata <- read.table("hospital_data_new.txt", header=TRUE, sep = "\t")
View(testingwrittendata)
nrow(testingwrittendata)

