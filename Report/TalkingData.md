# TalkingData AdTracking Fraud Detection


# Data Description
- Our **goal** here is to build an algorithm that predicts whether a user will download an application after clicking a mobile advertisement. This is a classification problem.
- The dataset covers approximately 200 million clicks, which means there are nearly 200 million observations.
- The whole dataset was ordered by timestamps.
- The train set covers all the clicks during a 3-day period. 8 features are include in train data set, with 184,903,890 rows.
- The test set covers all the clicks on the next day. It contains only 7 features and 18,790,469 rows.
- The dataset is highly imbalanced, with 99.75% of the observations belonging to the negative class and only 0.25% of the observations in the positive class.<br />

| Feature name | Feature Meaning | Feature description |
| :----------: | :-------------: | :----------: |
| ip | IP address of click | int; encoded; high cardinality |
| app | App ID for marketing | int; encoded |
| device | Device type of user mobile phone | int; encoded |
| os | OS version of user mobile phone | int; encoded |
| channel | Channel ID of mobile ad publisher | int; encoded |
| click_time | Timestamp of click (UTC) | chr |
| attributed_time | Timestamp when an app is downloaded | chr; absent in tst set;<br />lots of empty values in trn set;  |
| is_attributed | 1 if the app is downloaded, 0 otherwise | int; binary |





