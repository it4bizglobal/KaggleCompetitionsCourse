# https://www.kaggle.com/c/GiveMeSomeCredit/

rm(list = ls())

library(randomForest)

# 
# Cargamaos los datos
#

input.folder <- "~/git/github.com/KaggleCompetitionsCourse/kaggle/GiveMeSomeCredit/"

train.data <- read.csv(paste0(input.folder, "data/cs-training.csv"))
test.data <- read.csv(paste0(input.folder, "data/cs-test.csv"))
submissision <- read.csv(paste0(input.folder, "data/sampleEntry.csv"))


train.data$SeriousDlqin2yrs <- as.factor(train.data$SeriousDlqin2yrs)
table(train.data$SeriousDlqin2yrs)
prop.table(table(train.data$SeriousDlqin2yrs))

#
# Prepraracion de datos
#
train.class <- train.data[["SeriousDlqin2yrs"]]
train.data[is.na(train.data[,12]), 12] <- 0
train.data[is.na(train.data[,"MonthlyIncome"]), "MonthlyIncome"] <-  5209

test.data[is.na(test.data[,12]), 12] <- 0
test.data[is.na(test.data[,"MonthlyIncome"]), "MonthlyIncome"] <-  5209 

#
# Entrenamos un modelo
#
rf.model.1 <- randomForest(train.data[, 3:12], y = train.class, 
                           method = "class",
                           ntree = 500)
rf.model.1

# 
# Predecimos
#
pred.rf <- predict(rf.model.1, test.data[, 3:12], type = "prob")

# 
# Escribimos la submission a disco
#
#write.table(pred.rf[,1], file = "sample.submission.1.csv", quote = F, sep = "," )

write.table(pred.rf[,1], file = paste0(input.folder, "result/sample.submission.1.csv"), quote = F, sep = "," )

#install.packages("pROC")
library(pROC)

#
# Entrenamos un modelo
#
rf.model.1 <- randomForest(train.data[1:16000, 3:12], y = train.class, 
                           method = "class",
                           ntree = 500, do.trace = T)
rf.model.1

