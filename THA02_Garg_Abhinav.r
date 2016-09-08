#Setting up the working directory
getwd()
workingDirectory = "/Users/AbhiGarg/Documents/Fall 2016/RandPython/THA2"
setwd(workingDirectory)

#reading the datasets
hospitalData = read.csv("CaliforniaHospitalData.csv", header = TRUE, sep = ",")
personnelData = read.table("californiaHospitalData_Personnel.txt", header = TRUE, sep = '\t', quote = "\"")

#Joining the two data sets using Hospital ID
myData = merge(hospitalData, personnelData, by= "HospitalID")

#New Employee Entry: against Hospital ID : 38802
newemployee = data.frame('HospitalID'=38802,'Work_ID'='000001',
                         'LastName'='Garg','FirstName'='Abhinav','Gender'='M',
                         'PositionID'=3,'PositionTitle'='Acting Director','Compensation'=248904,
                         'MaxTerm'=8,'StartDate'='8/31/2016')
#Getting Hospital Information for the hospital ID: 38802
hospitalinfo = hospitalData[hospitalData$HospitalID==38802,]
#Merging the two dataframe to get the new entry for myData.
newentry = merge(hospitalinfo, newemployee, by="HospitalID")
#adding the new employee entry to the final data.
myData = rbind(myData, newentry)
#To check the entry of the new row
nrow(myData)
#Result : 62. Thus new employee is successfully added.

#Convert any date-time columns into a datetime datatype
str(myData)
StartDate_DTFormat = as.Date(myData$StartDate, "%m/%d/%Y")
myData = data.frame(myData, StartDate_DTFormat)
str(myData)

#Remove the three primary keys from the dataframe.
names(myData)

#Provide a summary of the mean, median, minimum value, and maximum value
#for each numeric variable.
summary(myData[,sapply(myData, is.numeric)])

#Exporting the table
write.table(myData, "garg_abhinav_export.txt", sep='\t')
test = read.table("garg_abhinav_export.txt", header = TRUE, sep = '\t')
