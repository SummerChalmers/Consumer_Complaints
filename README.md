# Consumer_Complaints

## Contributers
Summer Chalmers

## Introduction
Given a csv file, able to clean, manipulate, and analyze data for the top twenty in both NRC and Bing databases for negative words.  

## Dictionary
NRC - "Categorizes words in a binary fashion (“yes”/“no”) into categories of positive, negative, anger, anticipation, disgust, fear, joy, sadness, surprise, and trust."
BING - "Categorizes words in a binary fashion into positive and negative categories."
Source: https://www.tidytextmining.com/sentiment.html

## Data Cleaning
First step of cleaning was getting rid of any blank cells in the column I wanted data from: 
word <- df %>%
  filter (Consumer.complaint.narrative != '')
The next step in cleaning was to make each word its own cell:
row_words <- word %>%
  mutate(Consumer.complaint.narrative = str_split(Consumer.complaint.narrative, "\\s+"))
row_words<- unnest(row_words, Consumer.complaint.narrative)
The next step was to make everything lower case and get rid of any punctuations through a function:
clean_text <- function(text){
  clean_text <- gsub('[[punct:]]', '', text)
  clean_text <- tolower(clean_text)
  return(clean_text)
}
Then put the data through the function:
row_words$Consumer.complaint.narrative <- clean_text(row_words$Consumer.complaint.narrative)
row_words <- row_words%>%
  filter(Consumer.complaint.narrative != '')
  
## Analysis
Top Twenty NRC Negative Words
<div align = "center">
<img src = "https://github.com/SummerChalmers/Consumer_Complaints/blob/main/top20NRC.png" width = "700">
</div>
This bar chart shows the top 20 negavtive words and how oftne they were used.

Top Twenty Bing Negavive Words
<div align = "center">
<img src = "https://github.com/SummerChalmers/Consumer_Complaints/blob/main/top20Bing.png" width = "700")>
</div>
This bar chart shows the top 20 negative words and how often they were used.

Word Cloud Top Twenty NRC Negative Words
<div align = "center">
<img src = "https://github.com/SummerChalmers/Consumer_Complaints/blob/main/wordcloudNRC.png" width = "700")>
</div>
This word cloud shows what word is used the most in the NRC database.

Word Cloud Top Twenty Bing Negative Words
<div align = "center">
<img src = "https://github.com/SummerChalmers/Consumer_Complaints/blob/main/wordcloudBing.png" width = "700")>
</div>
This word cloud shows what word is used the most in the Bing database.
