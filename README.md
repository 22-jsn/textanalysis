#textanalysis

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

1. Top 10 Most Common Issues
[Top Issues](top_issues1.pdf)  
> Loan servicing and account management were the most frequent sources of consumer complaints, highlighting recurring operational breakdowns in financial services.


2. Complaints by State
[Complaints by State](state_complaints1.pdf)
> California, Texas, and Florida generated the most complaints, possibly due to population density and volume of financial service users.


3. Timely Response Rate by Company
[Timely Response Rate](timely_response1.pdf)  
> Most top companies maintained high timely response rates — likely due to strict regulatory pressure and established case-handling infrastructure.


4. Sentiment Score (Bing Lexicon)
[Sentiment Bing](sentiment_bing1.pdf)  
> The overwhelming tone is negative, indicating that complaint narratives are emotionally charged and often convey frustration or dissatisfaction.


5. Word Cloud from Narratives
[Word Cloud](wordcloud1.pdf)  
> Frequent words include “credit,” “report,” “payment,” and “account,” showing that most complaints relate to consumer credit tracking and billing.


6. Complaints Over Time
[Complaints Over Time](complaints_over_time1.pdf)  
> Volume of complaints fluctuated monthly with noticeable spikes — possibly tied to seasonal finance cycles or major economic events.


7. How Complaints Are Submitted
[Submission Methods](complaints_channel.pdf)  
> The majority of complaints are submitted via the web. Surprisingly few use mail, fax, or phone, showing digital-first engagement patterns.

8. Frequency of Issues by Product
[Frequency of Issues](frequency_of_issues1.pdf)  
> A heatmap showing which issues are most frequently reported for each product category, highlighting key pain points by service type.

#Sentiment Analysis

Two lexicons were used to evaluate the emotional tone of complaint narratives:

- Bing:Classifies each word as either *positive* or *negative*
- NRC:Tags words with emotions such as *anger*, *trust*, *joy*, *fear*, etc.

The analysis showed that consumer narratives skew highly negative, confirming the dissatisfaction most consumers feel when filing complaints.
