getwd()

#get data set - with true control

Data1 = read.table("VibChallenge1Data_TrueControl.txt",header = TRUE)
head(Data1)
#note: one death arbitrarily assigned to true control group to avoid infinite survival error

#install required packages
  
install.packages("survival")

install.packages("survminer")

install.packages("dplyr")

install.packages("ggplot2")

install.packages("ggpubr")

#get required packages
  
library(survival)

library(survminer)

library(dplyr)

library(ggplot2)

library(ggpubr)

#survival prob over time with true control

surv_object = Surv(time = Data1$TE, event = Data1$Binary)

surv_object

fit1 = survfit(surv_object~treatment, data=Data1)
summary(fit1)
ggsurvplot(fit1, data = Data1, pval = TRUE,
           legend = "bottom",legend.title="Treatment", 
           font.legend = c(9,"plain","black"),
           legend.labs = c("Resistant","Susceptable", "Control", "True Control"))
         
#watch treatment labels (follow order given in survfit stats - 
#order is alphabetical for survival prob plot)
           
#hazard ratio over time including true control
           
fit.coxph = coxph(Surv(TE,Binary)~treatment,data = Data1)
           
summary(fit.coxph)
           
ggforest(fit.coxph, data = Data1)

##!
#hazard ratio box plot
#first, removed true control in new data file to compare only treatments
#assign this data set to Data2

Data2 = read.table("VibChallenge1Data_TrueRemoved.txt",header=TRUE)

#conversion of letter placeholders to proper treatment labels
Data2 <- within.data.frame(Data2, {
  treatment <- factor(treatment, levels = c("A", "B", "C"),
                      labels = c("Control", "Susceptible", "Resistant"))})

head(Data2)

surv_object2 = Surv(time = Data2$TE, event = Data2$Binary)

fit2 = survfit(surv_object2~treatment, data=Data2)

fit.coxph2 = coxph(Surv(TE,Binary)~treatment,data = Data2)

ggforest(fit.coxph2, data = Data2, main = "Hazard Ratio", fontsize=0.7, refLabel = "")

summary(fit.coxph2)

##!
#plot over time without True Control

ggsurvplot(fit2, data=Data2, pval = TRUE,
           legend = "bottom",legend.title="Treatment: ", 
           font.legend = c(9,"plain","black"),
           legend.labs = c("Control", "Susceptable", "Resistant"))

##!
#now comparing genetic effects independent from treatment

Data2 <- within.data.frame(Data2, {genetics <- factor(genetics, 
                    levels = c("2", "1"),
                    labels = c("Susceptible", "Resistant"))})

head(Data2)

surv_object2 = Surv(time = Data2$TE, event = Data2$Binary)

fit3 = survfit(surv_object2~genetics, data=Data2)

fit.coxph3 = coxph(Surv(TE,Binary)~genetics,data = Data2)

ggforest(fit.coxph3, data = Data2, main = "Hazard Ratio", fontsize=0.7, refLabel = "")

summary(fit.coxph3)

#with true control

Data1 <- within.data.frame(Data1, {
  genetics <- factor(genetics, levels = c("3", "2", "1"),
                     labels = c("True Control", "Susceptible", "Resistant"))})

head(Data1)

surv_object4 = Surv(time = Data1$TE, event = Data1$Binary)

fit4 = survfit(surv_object4~genetics, data=Data1)

fit.coxph4 = coxph(Surv(TE,Binary)~genetics,data = Data1)

ggforest(fit.coxph4, data = Data1, main = "Hazard Ratio", fontsize=0.7, refLabel = "")

summary(fit.coxph4)

#now over time

summary(fit4)
ggsurvplot(fit4, data = Data1, pval = TRUE,
           legend = "bottom",legend.title="Family: ", 
           font.legend = c(9,"plain","black"),
           legend.labs = c("True Control","Resistant","Susceptable"))


