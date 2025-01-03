#Installing libraries
install.packages('rpart')
install.packages('caret')
install.packages('rpart.plot')
install.packages('rattle')
install.packages("datasets")

#Loading libraries
library(rpart,quietly = TRUE)
library(caret,quietly = TRUE)
library(rpart.plot,quietly = TRUE)
library(rattle)

#Reading the data set as a dataframe
mushrooms <- read.csv ("/Users/sheesh/Downloads/mushrooms.csv")
mushrooms

# number of rows with missing values
nrow(mushrooms) - sum(complete.cases(mushrooms))

# deleting redundant variable `veil.type`
mushrooms$veil.type <- NULL

# analyzing the odor variable
table(mushrooms$class,mushrooms$odor)

number.perfect.splits <- apply(X=mushrooms[-1], MARGIN = 2, FUN = function(col){
  t <- table(mushrooms$class,col)
  sum(t == 0)
})

# Descending order of perfect splits
order <- order(number.perfect.splits,decreasing = TRUE)
number.perfect.splits <- number.perfect.splits[order]

# Plot graph
par(mar=c(10,2,2,2))
barplot(number.perfect.splits,
        main="Number of perfect splits vs feature",
        xlab="",ylab="Feature",las=2,col="wheat")

#data splicing
set.seed(12345)
train <- sample(1:nrow(mushrooms),size = ceiling(0.80*nrow(mushrooms)),replace = FALSE)

# training set
mushrooms_train <- mushrooms[train,]
# test set
mushrooms_test <- mushrooms[-train,]

# penalty matrix
penalty.matrix <- matrix(c(0,1,10,0), byrow=TRUE, nrow=2)

# building the classification tree with rpart
tree <- rpart(class~.,
              data=mushrooms_train,
              parms = list(loss = penalty.matrix),
              method = "class")

# Visualize the decision tree with rpart.plot
rpart.plot(tree, nn=TRUE)
#Testing the model
pred <- predict(object=tree,mushrooms_test[-1],type="class")
#Calculating accuracy
t <- table(mushrooms_test$class,pred)
confusionMatrix(t)





# NOtes
#Rpart is a powerful machine learning library in R that is used for building classification and regression trees.
#Caret is a pretty powerful machine learning library in R. With flexibility as its main feature, caret enables you to train different types of algorithms using a simple train function.
#Rattle is a popular free and open source Graphical User Interface (GUI) for the R software, one that focuses on beginners looking to point-and-click their way through data mining tasks. 
#