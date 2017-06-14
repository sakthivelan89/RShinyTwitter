library(devtools)
library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(stringr)
#Now the twitteR package is up-to-date
#setup_twitter_oauth() function uses the httr package
shinyServer(function(input, output,session) {
  
  observeEvent(input$doBtn, {

api_key <-  "xxx"
api_secret <- "xxx"




#setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)
setup_twitter_oauth(api_key,api_secret)


#Collect tweets containinguchil 'new year'
tweets = searchTwitter(input$comment, n=input$minimumTime,lang="en")


#Extract text content of all the twe

tweetTxt = sapply(tweets, function(x) x$getText())

#In tm package, the documents are managed by a structure called Corpus
myCorpus = Corpus(VectorSource(str_replace_all(tweetTxt, "[^[:alnum:]]", " ")))


toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
myCorpus <- tm_map(myCorpus, toSpace, "/"); 
myCorpus <- tm_map(myCorpus, toSpace, "https"); 
myCorpus <- tm_map(myCorpus, toSpace, "@")
myCorpus <- tm_map(myCorpus, toSpace, "\\|"); 
myCorpus <- tm_map(myCorpus, content_transformer(tolower))
myCorpus <- tm_map(myCorpus, removeNumbers); 
myCorpus <- tm_map(myCorpus, removeWords, stopwords("english"))
myCorpus <- tm_map(myCorpus, removePunctuation); 
myCorpus <- tm_map(myCorpus, stripWhitespace)


#Create a term-document matrix from a corpus
tdm = TermDocumentMatrix(myCorpus);

#Convert as 1matrix
m = as.matrix(tdm)

#Get word counts in decreasing order
word_freqs = sort(rowSums(m), decreasing=TRUE) 

#Create data frame with words and their frequencies
dm = data.frame(word=names(word_freqs), freq=word_freqs)

#Plot wordcloud
output$plot <- renderPlot({
  wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
  #png("wordcloud.png", width=1280,height=800)
  
  #wordcloud(dm$word,dm$freq, scale=c(4,.2),min.freq=3,max.words=Inf, random.order=FALSE, rot.per=.15, colors=brewer.pal(8, "Dark2"))
})
  })
})
