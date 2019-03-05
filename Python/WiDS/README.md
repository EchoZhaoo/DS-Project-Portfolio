# WiDS 2018 Datathon 

# Motivation
- The dataset for the challenge will contain demographic and behavioral information from a representative sample of survey respondents from India and their usage of traditional financial and mobile financial services.<br />
- The dataset is a product of InterMedia’s research to help the world’s poorest people take advantage of widely available mobile phones and other digital technology to access financial tools and participate more fully in their local economies.<br />
- Women in these communities, in particular, are often largely excluded from the formal financial system.<br />
- By predicting gender, the datathon teams will explore the key differences in behavior patterns of men and women, and how that may impact their use of new financial services.<br />


# Data Description
- The dataset contains 1235 variables (including target and train row id) from 18.255 respondent which are classified as female (is_female = 1) and male (is_female = 0).<br />
- The class is well-balanced as 53% of the total respondents are female.

# Data Preprocessing
- Dropped variables that 80% of the answers are missing. 
- The rest of the missing data was imputed with the most frequently appeared value for each column.
- Only selected the columns from the training dataset that match the data dictionary.
- For the test dataset, we only selected the columns that were previously selected in the final training dataset

# Algorithms
- Split the training dataset into the training and test subsets for validation. 
- For each method, we first got the predicted probabilities on the splitted test set, then get the AUC score, then test again using 5-fold cross-validation.
- Tried 4 classifiers: Logistic Regression, Random Forest (500 trees), SVM (RBF), and XGBoost.

# Prediction
Using XGBoost, write out .csv file for submission. <br />
Result: 0.90 on leaderboard Note: also tried submitting predictions using Random Forest, results not as good.


# AUC Results
- Logistic Regression: 0.8 ~ 0.9 (not so good)
- Random Forest: 0.956
- SVM (default parameters): 0.896
- XGBoost (tuned): ~ 0.95
