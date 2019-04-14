#install.packages("twitteR")
#install.packages("ROAuth")
#install.packages("syuzhet")

library(twitteR)
library(ROAuth)
library(syuzhet)

api_key <-"fZgfQUoNkmV2qfylSep57qxAK"
api_secret <-"24tv5L5h2mAEEF8cjONVm5Mi6qp71ohd1WTgEVMkXAGOxL3ycm"
access_token <-"1015057564935962624-HBmgoFkE6sd2wJivp2QNF7BKDAvz4A"
access_token_secret <-"xDjUSEaz9d3a5RYtWkyNdkOPPd0pXK4KNn1dFpEueHvsY"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)


userTimeline("@RMY33466214")
favs<-favorites("@RMY33466214",n=154)
tweetsDF <- twListToDF(favs) 
tweetsDF
#tweetsDF <- tweetsDF[, -c(2:16)]
View(tweetsDF)


cleand_data<-lapply(tweetsDF$text, function(tweets.df2) {
  
  tweets.df2 = gsub('http\\S+\\s*', '', tweets.df2) ## Remove URLs
  
  tweets.df2 = gsub('\\b+RT', '', tweets.df2) ## Remove RT
  
  tweets.df2 = gsub('#\\S+', '', tweets.df2) ## Remove Hashtags
  
  tweets.df2 = gsub('@\\S+', '', tweets.df2) ## Remove Mentions
  
  tweets.df2 = gsub('[[:cntrl:]]', '', tweets.df2) ## Remove Controls and special characters
  
  tweets.df2 = gsub("\\d", '', tweets.df2) ## Remove Controls and special characters
  
  tweets.df2 = gsub('[[:punct:]]', '', tweets.df2) ## Remove Punctuations
  
  tweets.df2 = gsub("^[[:space:]]*","",tweets.df2) ## Remove leading whitespaces
  
  tweets.df2 = gsub("[[:space:]]*$","",tweets.df2) ## Remove trailing whitespaces
  
  tweets.df2 = gsub(' +',' ',tweets.df2) ## Remove extra whitespaces
  
})
cleand_data
as.numeric(unlist(tweetsDF$text))

cleand_data<-as.character(cleand_data)



View(tweetsDF$text)

word.df <-as.vector((cleand_data))

emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(cleand_data, emotion.df) 
emotion.df2
#head(emotion.df2)
sent.value <- get_sentiment(word.df)

most.positive <- word.df[sent.value == max(sent.value)]

most.positive

most.negative <-word.df[sent.value == min(sent.value)]
most.negative


sent.value

positive.tweets<-word.df[sent.value>0]
positive.tweets

negative.tweets<-word.df[sent.value<0]
negative.tweets

neutral.tweets<- word.df[sent.value==0]
neutral.tweets

category_senti<-ifelse(sent.value<0,"Negative",ifelse(sent.value>0,"Positive","Neutral"))
category_senti

table(category_senti)
s<-data.frame(category_senti,sent.value)
s

barplot(sent.value)



