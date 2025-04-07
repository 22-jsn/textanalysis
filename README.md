# textanalysis

#Dataset Overview

- Source: Consumer_Complaints.csv
- Observations: ~670,000+ complaints
- Columns:18 (Product, Issue, Narrative, Company, State, Date, etc.)
- Tools Used: (R, tidyverse, ggplot2, tidytext, textdata, lubridate, scales)


#Data Cleaning Process

- Removed complaints with missing `Consumer complaint narrative` entries
- Converted `Date received` to proper date format using `lubridate`
- Extracted `year` and `month` for trend visualization
- Tokenized narratives using `unnest_tokens()` and removed stop words
- Merged complaint data with two sentiment lexicons: **Bing** and **NRC**
- Filtered and grouped text for analysis and visual clarity


#Charts & Insights

1. Top 10 Most Common Issues**
![Top Issues](https://github.com/22-jsn/textanalysis/blob/6a07250c89e79eb56a26b306c3af2d7031b21d94/top_issues.pdf)  
> Loan servicing and account management were the most frequent sources of consumer complaints, highlighting recurring operational breakdowns in financial services.


2. **Complaints by State**
![Complaints by State](images/state_complaints.png)  
> California, Texas, and Florida generated the most complaints, possibly due to population density and volume of financial service users.


3. **Timely Response Rate by Company**
![Timely Response Rate](images/timely_response.png)  
> Most top companies maintained high timely response rates — likely due to strict regulatory pressure and established case-handling infrastructure.


### 4. **Sentiment Score (Bing Lexicon)**
![Sentiment Bing](images/sentiment_bing.png)  
> The overwhelming tone is negative, indicating that complaint narratives are emotionally charged and often convey frustration or dissatisfaction.


5. **Word Cloud from Narratives**
![Word Cloud](images/wordcloud.png)  
> Frequent words include “credit,” “report,” “payment,” and “account,” showing that most complaints relate to consumer credit tracking and billing.


6. **Complaints Over Time**
![Complaints Over Time](images/complaints_over_time.png)  
> Volume of complaints fluctuated monthly with noticeable spikes — possibly tied to seasonal finance cycles or major economic events.


7. **How Complaints Are Submitted**
![Submission Methods](images/complaints_channel.png)  
> The majority of complaints are submitted via the web. Surprisingly few use mail, fax, or phone, showing digital-first engagement patterns.


#Sentiment Analysis

Two lexicons were used to evaluate the emotional tone of complaint narratives:

- Bing:Classifies each word as either *positive* or *negative*
- NRC:Tags words with emotions such as *anger*, *trust*, *joy*, *fear*, etc.

The analysis showed that consumer narratives skew highly **negative**, confirming the dissatisfaction most consumers feel when filing complaints.
