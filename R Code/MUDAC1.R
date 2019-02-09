##### Read Data #####
##### Change Path #####
getwd()
setwd("/Users/echozhao/Desktop")
getwd()

##### NEW-target #####
confinement_target <- read.csv("confinement_target.csv", 
                                 header = TRUE, sep = ",")
labresults_target <- read.csv("labresults_target.csv", 
                                header = TRUE, sep = ",")
medical_target <- read.csv("medical_target.csv", header = TRUE)
rx_target <- read.csv("rx_target.csv", header = TRUE)

##### NEW-traning ######
confinement_training <- read.csv("confinement_training.csv", 
                                   header = TRUE, sep = ",")
labresults_traning <- read.csv("labresults_training.csv", 
                                 header = TRUE, sep = ",")
medical_traning <- read.csv("medical_training.csv", header = TRUE)
rx_training <- read.csv("rx_training.csv", header = TRUE)

####### lu #######
lu_diagnosis <- read.table("lu_diagnosis.txt", sep = "|", 
                           header = TRUE, na.strings = "NA", 
                           fill=TRUE, quote = "")
lu_ndc <- read.table("lu_ndc.txt", sep = "|", 
                     header = TRUE, na.strings = "NA", 
                     fill=TRUE, quote = "")
lu_procedure <- read.table("lu_procedure.txt", sep = "|", 
                           header = TRUE, na.strings = "NA", 
                           fill=TRUE, quote = "")
membership_info <- read.csv("member_information.csv", 
                            header = TRUE, sep = ",")
####### pivot #######
install.packages("reshape")
library(reshape)

membership_info$age <- 2017-membership_info$year_of_birth
table1 <- data.frame(membership_info$PATID,
                     membership_info$gender,
                     membership_info$age)
colnames(table1) <- c("PATID", "gender", "age")
table2 <- data.frame(medical_traning$PATID,
                     medical_traning$CLMID,
                     medical_traning$STD_COST,
                     medical_traning$POS,
                     medical_traning$RVNU_CD,
                     medical_traning$DAYS_FROM_DIAG)
colnames(table2) <- c("PATID", "CLMID","STD_COST","POS",
                      "RVNU_CD","DAYS_FROM_DIAG")
table3 <- merge(x = table1, y = table2, by = "PATID")
table3[is.na(table3)] <- 0

install.packages("dplyr")
library(dplyr)
######## gender_cost #########
table3 <- group_by(table3, gender)
gender_cost <- summarise(table3,
                         sum_cost = sum(STD_COST),
                         num_sex = length(gender),
                         avg_cost = mean(STD_COST))
install.packages("ggplot2")
library(ggplot2)
ggplot(table3[, c(2,5)], aes(x = gender, y = STD_COST)) + geom_boxplot()

######### gender_age_cost ###########
table3 <- group_by(table3, age)
ggplot(table3[, c(3,5)], aes(x = age, y = STD_COST, group = age)) + geom_boxplot()

table3$ageGroup <- cut(table3$age, c(0,30,35,40,45,50))
table3 <- group_by(table3, gender, ageGroup)
gender_age_cost <- summarise(table3,
                             sum_cost = sum(STD_COST),
                             num_ageGroup = length(ageGroup),
                             avg_cost = mean(STD_COST))

######### gender_claimID ##########
table3 <- group_by(table3, gender, PATID)
gender_claimID <- summarise(table3,
                         num_ClaimID = length(CLMID))

ggplot(gender_claimID, aes(x = PATID, y = num_ClaimID)) + geom_boxplot()


######## POS_cost #########
table3 <- group_by(table3, POS)
POS_cost <- summarise(table3,
                      sum_cost = sum(STD_COST),
                      num_POS = length(POS),
                      avg_cost = mean(STD_COST))

######## POS_ageGroup_cost #######
table3 <- group_by(table3, POS, ageGroup)
POS_ageGroup_cost <- summarise(table3,
                      sum_cost = sum(STD_COST),
                      num_POS = length(POS),
                      avg_cost = mean(STD_COST))

######## POS_gender_cost #######
table3 <- group_by(table3, POS, gender)
POS_gender_cost <- summarise(table3,
                             sum_cost = sum(STD_COST),
                             num_POS = length(POS),
                             avg_cost = mean(STD_COST))

######## POS_ageGroup_gender_cost #######
table3 <- group_by(table3, POS, ageGroup, gender)
POS_ageGroup_gender_cost <- summarise(table3,
                               sum_cost = sum(STD_COST),
                               num_POS = length(POS),
                               avg_cost = mean(STD_COST))

######### RVNU_cost #######
table3 <- group_by(table3, RVNU_CD)
RVNU_cost <- summarise(table3,
                      sum_cost = sum(STD_COST),
                      num_RVNU = length(RVNU_CD),
                      avg_cost = mean(STD_COST))

######### RVNU_ageGroup_cost #######
table3 <- group_by(table3, RVNU_CD, ageGroup)
RVNU_ageGroup_cost <- summarise(table3,
                       sum_cost = sum(STD_COST),
                       num_RVNU = length(RVNU_CD),
                       avg_cost = mean(STD_COST))

######### POS_RVNU_ageGroup_cost #######
table3 <- group_by(table3, POS, RVNU_CD, ageGroup)
POS_RVNU_ageGroup_cost <- summarise(table3,
                                sum_cost = sum(STD_COST),
                                num_RVNU = length(RVNU_CD),
                                avg_cost = mean(STD_COST))

######### POS_RVNU_ageGroup_gender_cost #######
table3 <- group_by(table3, POS, RVNU_CD, ageGroup, gender)
POS_RVNU_ageGroup_gender_cost <- summarise(table3,
                                    sum_cost = sum(STD_COST),
                                    num_RVNU = length(RVNU_CD),
                                    avg_cost = mean(STD_COST))

######### subsetting data #########
newdata <- medical_traning[!(medical_traning$DIAG1 %in% c(630:67999)), ]
newdata <- newdata[!(newdata$DIAG2 %in% c(630:67999)), ]
newdata <- newdata[!(newdata$DIAG1 %in% c(800:95999)), ]
newdata <- newdata[!(newdata$DIAG2 %in% c(800:95999)), ]

newdata <- medical_traning[!(medical_traning$DIAG1 %in% as.character(c(630:67999))), ]
newdata <- newdata[!(newdata$DIAG2 %in% as.character(c(630:67999))), ]
newdata <- newdata[!(newdata$DIAG1 %in% as.character(c(800:95999))), ]
newdata <- newdata[!(newdata$DIAG2 %in% as.character(c(800:95999))), ]
write.csv(newdata, file = "newdata.csv")
write.csv(table3, file = "table3.csv")

new_lu <- lu_diagnosis[(lu_diagnosis$ICD_VER_CD == 9), ]
new_lu <- new_lu[order(new_lu$DIAG_FST3_CD), ]
new_lu <- new_lu %>%
  filter(!(DIAG_FST3_CD %in% 630:676) & !(DIAG_FST3_CD %in% 800:958))


DIAG1 <- new_lu
names(DIAG1)[names(DIAG1) == "DIAG_CD"] = "DIAG1"
newdata <- merge(x = medical_traning, y = DIAG1, by = "DIAG1")
DIAG2 <- data.frame(new_lu$DIAG_CD)
colnames(DIAG2) <- c("DIAG2")
newdata <- merge(x = newdata, y = DIAG2, by = "DIAG2")

newdata <- newdata %>%
  mutate()

write


a <- data.frame(id = c(1,2,3), key = c(4,5,6), id2 = c(1,2,3))
b <- data.frame(id = c(0,2,3), p = c(1,1,1))
d <- data.frame(id2 = c(1,0,3), p = c(1,1,1))
c <- merge(x = a, y = b, by = "id", all = FALSE)  
e <- merge(x = c, y = d, by = "id2")  
  
  

a <- new_lu[(new_lu$DIAG_CD %in% c('630','631')), ]

c <- new_lu[(new_lu$DIAG_CD == '632'), ]

d <- medical_traning[!(medical_traning$DIAG1 == '631'|
                         medical_traning$DIAG1 == '632'|
                         medical_traning$DIAG1 == '630' ), ]



newdata[newdata$DIAG1=="V0481",]
me1 <- medical_traning[-row_to_delete1,] 



######### patient_confinement #######
table3 <- group_by(table3, CLMID)
m <- ifelse(table3$CLMID == "none", 0, 1)
table3$conf_label <- as.matrix(m)

######### DRG clustering ##########
table4 <- data.frame(medical_traning$DRG,
                       medical_traning$STD_COST)
colnames(table4) <- c("DRG", "STD_COST")
table4 <- group_by(table4, DRG)
DRG_cost <- summarise(table4, 
                      sum_cost = sum(STD_COST))
DRG_cost <- DRG_cost[(as.numeric(DRG_cost$DRG) %in% c(000:998)), ]
DRG_cost <- DRG_cost[-569, ] # DRG = none
DRG_cost <- DRG_cost[-478,] # point with negative cost
library(ggplot2) 
ggplot(DRG_cost, aes(DRG, sum_cost)) + geom_point()

kmeans(DRG_cost, 7)
library(cluster)
install.packages("fpc")
library(fpc)
