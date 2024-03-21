library(tidytext)
library(textdata)
library(ggplot2)
library(dplyr)
library(stringr)
library(tidyr)
library(wordcloud2)
library(tidyr)
library(tidyverse)

#import and label the data file
setwd('C:/Users/smc91/OneDrive/Desktop/RStudioProj')
df <- read.csv('Consumer_Complaints.csv')

#get the sentiment data bases
get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")

#get rid of blank cells
word <- df %>%
  filter (Consumer.complaint.narrative != '')

#Now take this and get it to each word is its own cell
row_words <- word %>%
  mutate(Consumer.complaint.narrative = str_split(Consumer.complaint.narrative, "\\s+"))
row_words<- unnest(row_words, Consumer.complaint.narrative)

#now take all puncutations out and lowercase all 
clean_text <- function(text){
  clean_text <- gsub('[[punct:]]', '', text)
  clean_text <- tolower(clean_text)
  return(clean_text)
}
#applying the function to the data
row_words$Consumer.complaint.narrative <- clean_text(row_words$Consumer.complaint.narrative)
row_words <- row_words%>%
  filter(Consumer.complaint.narrative != '')

colnames(row_words)[colnames(row_words) == "Consumer.complaint.narrative"] <- "word"

#nrc analysis
nrc_negative <- get_sentiments("nrc") %>% 
  filter(sentiment == "negative")
neg_words <- row_words %>%
  inner_join(nrc_negative)%>%
  count(word, sort = TRUE)
#list the top 20 negative words according to the nrc database
top_twenty_words <- head(neg_words, 20)
top_five_words <- head(neg_words, 5)
#plot the top 20 words
ggplot(top_twenty_words, aes(x = word, y = n, fill = word))+
  geom_bar(stat = 'identity')+
  labs(title =  "Top 20 Used Word In Complaints NRC", x = "Word", y= "Times Used")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, color = 'black')) +
  theme(legend.position = "none")

#bing analysis
bing_negative <- get_sentiments("bing") %>% 
  filter(sentiment == "negative")
neg_words_bing <- row_words %>%
  inner_join(bing_negative)%>%
  count(word, sort = TRUE)
#top twenty negative word according to bing database
top_twenty_words_bing <- head(neg_words_bing, 20)
top_five_words_bing <- head(neg_words_bing, 5)
#plot the top 20 words
ggplot(top_twenty_words_bing, aes(x = word, y = n, fill = word))+
  geom_bar(stat = 'identity')+
  labs(title =  "Top 20 Used Word In Complaints Bing", x = "Word", y= "Times Used")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, color = 'black')) +
  theme(legend.position = "none")

#word cloud
wordcloud2(top_twenty_words)
wordcloud2(top_twenty_words_bing)

