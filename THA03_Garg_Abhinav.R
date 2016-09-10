# Topic: Data Reduction
# Author: Abhinav Garg

#setting up working directory
getwd()
workingDirectory = "/Users/AbhiGarg/Documents/Fall 2016/RandPython/THA3"
setwd(workingDirectory)

#Reading Data
hospitalData <- read.table("garg_abhinav_export.txt", header = TRUE, sep = '\t')
names(hospitalData)
hospitaldirectory = read.csv("CaliforniaHospitalData.csv", header = TRUE, sep = ",")

#Checking Format
str(hospitalData)
#Setting startdate in dateformat
hospitalData$StartDate_DTFormat <- as.Date(hospitalData$StartDate_DTFormat)

# Since we added only one new employee last assignment and considering 
# we need two employees here on, so I'm adding one more employee now.
newemployee = data.frame('HospitalID'=44817,'Work_ID'='000002',
                         'LastName'='Garg','FirstName'='Abhinav','Gender'='M',
                         'PositionID'=1,'PositionTitle'='Regional Representative','Compensation'=46978,
                         'MaxTerm'=4,'StartDate'='9/10/2016')
hospitalInfo <- hospitaldirectory[hospitaldirectory$HospitalID==44817,]
newEntry <- merge(hospitalInfo, newemployee, by="HospitalID")
#remmoving the three primary keys as before
names(newEntry)
newEntry <- newEntry[,-c(1,15,19)]
names(hospitalData)
#Last step is to convert the StartDate in correct Format
newEntry$StartDate_DTFormat <- as.Date(newEntry$StartDate, "%m/%d/%Y")
#adding the new employee entry to the final data.
hospitalData = rbind(hospitalData, newEntry)

########################################################################
#----------------Principal Component Analysis--------------------------#
########################################################################
# Using the numerical columns, conduct a PCA and obtain the eigenvalues
pcaData <- hospitalData[,sapply(hospitalData, is.numeric)]
pcamodel <- princomp(pcaData, cor = TRUE, scale = TRUE)
print(pcamodel)
pcamodel$sdev^2
#PCA and % variance explained
pcamodel$sdev^2/sum(pcamodel$sdev^2)
#Scree Plot
plot(pcamodel, main="Perceived Usefuleness Scree Plot")

########################################################################
#-------------------------Factor Analysis------------------------------#
########################################################################
names(pcaData)

famodel_2factor <- factanal(~NoFTE+NetPatRev+InOperExp+OutOperExp+OperRev+
                              OperInc+AvlBeds+Compensation+MaxTerm,
                             factors = 2,rotation = "varimax",
                             scores = "none", data = hospitalData)
# Errorneous. High coorelation between the variables selected. Need to drop one of the variable and 
# re-run the analysis.
famodel_2factor1 <- factanal(~NoFTE+NetPatRev+InOperExp+OutOperExp+OperRev+
                               AvlBeds+Compensation+MaxTerm,
                               factors = 2,rotation = "varimax",
                              scores = "none", data = hospitalData)

famodel_2factor2 <- factanal(~NoFTE+NetPatRev+InOperExp+OperRev+
                               OperInc+AvlBeds+Compensation+MaxTerm,
                            factors = 2,rotation = "varimax",
                            scores = "none", data = hospitalData)
# Not a good solution, trying 3-factor solution
famodel_3factor1 <- factanal(~NoFTE+NetPatRev+InOperExp+OperRev+
                               OperInc+AvlBeds+Compensation+MaxTerm,
                             factors = 3,rotation = "varimax",
                             scores = "none", data = hospitalData)
famodel_3factor1

famodel_2factor3 <- factanal(~NoFTE+NetPatRev+OutOperExp+OperRev+
                               OperInc+AvlBeds+Compensation+MaxTerm,
                             factors = 2,rotation = "varimax",
                             scores = "none", data = hospitalData)
famodel_2factor3
# Again not a good solution, trying 3-factor solution
famodel_3factor2 <- factanal(~NoFTE+NetPatRev+OutOperExp+OperRev+
                               OperInc+AvlBeds+Compensation+MaxTerm,
                             factors = 3,rotation = "varimax",
                             scores = "none", data = hospitalData)
famodel_3factor2

#importing data
write.table(hospitalData, "THA3_export_Garg_Abhinav.txt", sep='\t')
