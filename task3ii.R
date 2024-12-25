df <- read.csv('/Users/sheesh/Downloads/Churn_Modelling.csv',header = T)
head(df)
summary(df)
str(df)
df$Geography <- as.factor(df$Geography)
df$Gender <- as.factor(df$Gender)
df$HasCrCard <- as.factor(df$HasCrCard)
df$IsActiveMember <- as.factor(df$IsActiveMember)
df$Exited <- as.factor(df$Exited)
str(df)
levels(df$Geography)
df$newcol <- NA
df[1:5,8:15]
df$newcol <- NULL
head(df)
df$estsalaryclass<-cut(df$EstimatedSalary,breaks =
                         seq(0,max(df$EstimatedSalary)+1,len=4))
levels(df$estsalaryclass)
df[1:5,c('EstimatedSalary','estsalaryclass')]
df$estsalaryclass<-cut(df$EstimatedSalary,breaks = 
                         seq(0,max(df$EstimatedSalary)+1,len=4), labels = c('poor','middle','rich'))
levels(df$estsalaryclass)
df[1:5,c('EstimatedSalary','estsalaryclass')]
df$estsalaryclass<-cut(df$EstimatedSalary,breaks =
                         seq(0,max(df$EstimatedSalary)+1,len=4),right = FALSE)
levels(df$estsalaryclass)
df[1:5,c('EstimatedSalary','estsalaryclass')]
sum(is.na(df))
df[5,'Age'] = NA 
sum(is.na(df))
head(is.na(df))
for (i in 1:length(df)) 
{cat(c(colnames(df[i]),':',sum(is.na(df[,i])),"\n"))}
df_notna<-na.omit(df) 
sum(is.na(df_notna))
avg_age <- round(mean(df$Age,na.rm=TRUE))
df$Age<-ifelse(is.na(df$Age),avg_age,df$Age)
head(df)
