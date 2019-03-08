# TalkingData AdTracking Fraud Detection


## Data Description
- Our **goal** here is to build an algorithm that predicts whether a user will download an application after clicking a mobile advertisement. This is a classification problem.
- The dataset covered approximately **200 million** clicks, which means there were nearly 200 million observations.
- The whole dataset was ordered by timestamps.
- The train set covered all the clicks during a 3-day period. **8 features** were include in train data set, with 184,903,890 rows.
- The test set covered all the clicks on the next day. It contained only **7 features** and 18,790,469 rows.
- The dataset was highly **imbalanced**, with **99.75%** of the observations belonging to the negative class and only **0.25%** of the observations in the positive class.<br />
---------------------------------
| Feature name | Feature Meaning | Feature description |
| :----------: | :-------------: | :----------: |
| `ip` | IP address of click | int; encoded; high cardinality |
| `app` | App ID for marketing | int; encoded |
| `device` | Device type of user mobile phone | int; encoded |
| `os` | OS version of user mobile phone | int; encoded |
| `channel` | Channel ID of mobile ad publisher | int; encoded |
| `click_time` | Timestamp of click (UTC) | chr |
| `attributed_time` | Timestamp when an app is downloaded | chr; absent in tst set;<br />lots of empty values in trn set;  |
| `is_attributed` | 1 if the app is downloaded, 0 otherwise | int; binary |

------------------------------------


## Imbalanced Dataset
- **Problem**: 
  - Fitted model will be biased and overfitted
  - Models like Logistics Regression and Decision Tree might not work well.
- **Solution**
  - Undersampling
  
## Feature Engineering
- Aggregated the training data on different groups of features to obtain the latent information of the conversion rate. 
- For example, feature `ip_os_count` means that we grouped the data by `ip` and `os` and count the number of clicks.
- Tried several combinations of two-way and three-way interactions.
- After trying all possible combinations, our final predictive model included 20 features. 


## Modeling
- Performed Logistic Regression (with 5-fold cross-validation) on our balanced train data. Since our data is sparse, we'll apply a LASSO regularization.
- Tried Random Forest and LightGBM as well.
- Used more samples and adjusted for the weight of the minority class in the GBDT methods.


## Conclusion
- Since our newly created features were correlated with one another, and some of the original features were correlated as well (device and os). Logistic regression was not a good model choice, even with LASSO regularization.
- LightGBM proved to be a more preferable method, both in time, memory efficiency and accuracy. 
- Undersampled train dataset left us with very little information, as most of the majority samples were discarded. Therefore the performance was not good. 
- Using more samples with weight in GBDT methods resulted in better accuracys, which was another advantage of GBDT that was not possible in methods like logistic regression.




