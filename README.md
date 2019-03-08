# Data Science Project Portfolio
This repository contains all the projects that I worked on for data analysis and statistical modeling from Sep 2017 till now.<br />They are written in R, Matlab or Python.

# Research Projects
## *Estimation of Group Structure Based on Mutual Information*

* Used **RC Circuit Model** to construct synthetic test data having a precision matrix determined by the given **random**
**graph** structure generated using **Erdos-Renyi Model**.
* Solved RC Circuit Model using 5 methods: **Heun's Method** (Second-order Runge_Kutta Method), **Forth-order**
**Runge_Kutta Method**, **Second-Order Taylor Series Method**, **Implicit Euler's Method**, and **Explicit Euler's Method**.
* Used three algorithms to get the sparse estimation of the graph structure, which are **Graphical-Lasso algorithm**,
**Thresholding the correlation matrix**, and **Partial correlation**.
* Estimated the **Mutual Information** among nodes based on 5 approaches: **Histogram Method**, **Fuzzy Histogram**
**Method**, **Kernel Density Estimator**, and **KNN algorithm**.
* Tried to identify the group structure using **graph partitioning** algorithm based on the mutual information estimated

**Keywords**: *Matlab, Graph Theory, Erdos-Renyi Model, RC Circuit Model, Ordinary Differential Equations (ODE), Graphical Lasso, Thresholding Correlation Matrix, Mutual Information, Graph Partitioning*


# Personal Projects
## *Air Passengers Prediction*
For further detail, please check [here](https://github.com/EchoZhaoo/Air-Passengers-Prediction/blob/master/README.md)<br />
[Python Jupyter Notebook](https://github.com/EchoZhaoo/Air-Passengers-Prediction/blob/master/SARIMAX.ipynb)<br />
- **Goal**: Do time series analysis about how the number of air passengers changed as the time passing by.
- Build a SARIMAX(Seasonal Auto-Regressive Integrated Moving Average with eXogenous regressors) model by Python to do both one-step prediction and dynamic prediction.
- Do data visualization on Tableau and its integration with Python which is called TabPy. 

**Keywords**: *Python, Tableau, Time Series Analysis, SARIMAX*

## *Quality Evaluation of Answers in Online Medical Q&A Community*

* Collect text data of diabetics from Xunyiwenyao through web crawler technology
* Use synonym replacement, typo screening to preprocess data in R. Segment words based on ten Chinese dictionaries and integrated stop words dictionaries with package “Rwordreg”.
* Use **TF-IDF** to finish the vectorization of texts, calculate the frequency of words, then abstract key words.
* Use **Apriori** algorithm to conduct **association analysis**. Analyze association rules and apply them to real world.
* Use package **“wordcloud2”** to plot data in an interactive way.

**Keywords**: *Text Mining, R, TF-IDF, Association Analysis, Apriori, wordcloud2*

# Data Science Competition Projects
## *WiDS* <br /> *Women in Data Science*
[Python Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Python/WiDS)<br />
[Here](https://github.com/EchoZhaoo/DS-Project-Portfolio/blob/master/Python/WiDS/README.md) is the brief log of what we did actually<br />
For more details check this [Kaggle competition](https://www.kaggle.com/c/wids2018datathon)
* Used clustering and variable selection for the categorical multivariate data.
* Tried Logistic Regression, Random Forest, SVM, Neural Network, XGBoost to predict the gender of the interviewee.
* Tuned Random Forest and XGBoost to get the final prediction.

**Keywords**: *Python, SVM, Neural Network, Logistic Regression, Random Forest, XGBoost*

## *Minneanalytics MUDAC 2017* <br /> *Cost Prediction for Potential Diabetes Patients*
[R Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/blob/master/R%20Code/MUDAC1.R)<br />
[Python Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/blob/master/Python/MUDAC_python.py)<br />
* Built a model to predict the medical cost for diabetes patients using Logistic Regression and Random Forest.
* The medical dataset was provided by Optum and had around five million observations.

**Keywords**: *R, Python, Logistic Regression, Random Forest*

# Class Projects
## *Santa Gift Matching Challenge*
[Python Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Python/EE5239%20Project)<br />
[Final Report](https://github.com/EchoZhaoo/DS-Project-Portfolio/blob/master/Report/EE5239_Project_Report.pdf)<br />
[Blog](https://github.com/EchoZhaoo/DS-Project-Portfolio/blob/master/Python/EE5239%20Project/README.md)<br />
* **Goal**: to build an algorithm that maximizes the total happiness of both Santa and children by paring children with gifts they want.
* There are one million children and 1000 types of gifts in total.
* We conclude it as a Min-Cost Flow Problem in the end and solved it using solver "Ortools"

**Keywords**: *Nonlinear Optimization, Min-Cost Flow Problem, Ortools*

## *TalkingData AdTracking Fraud Detection*
[Python Jupyter Notebook](https://github.com/EchoZhaoo/DS-Project-Portfolio/blob/master/Python/TalkingData.ipynb)<br /> 
[Final Report](https://github.com/EchoZhaoo/DS-Project-Portfolio/blob/master/Report/PUBH%207475_Final_Report.pdf)<br /> 
[Blog](https://github.com/EchoZhaoo/DS-Project-Portfolio/blob/master/Report/TalkingData.md)<br /> 
- **Goal**: to build an algorithm that predicts whether a user will download an application after clicking a mobile advertisement.<br />
- The dataset covers approximately **200 million** clicks, and 8 features are included in train data set. Based on these features, our final predictive model included **21 features**. <br />
- The dataset is **highly imbalanced**. Gradient boosting decision tree algorithm (**LightGBM**) was chosen as the final model.

**Keywords**: *Python, Data Visualization, Penalized Logistic Regression, Random Forest, Gradient Boosting, LightGBM*

## *Prediction of Waste Produced Amount for Company*
 [R Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/blob/master/R%20Code/STAT5302_Project.R)<br />
 [Final Report](https://github.com/EchoZhaoo/DS-Project-Portfolio/blob/master/Report/STAT5302_Project_Report.pdf)<br /> 
 - I developed a **regression model** to predict the amount of waste produced by a business.<br />
 - The data are got from **147 businesses**, and there are **5 variables** in total, 4 of them are numerical variables and the other one is **categorial variable**.

**Keywords**: *R, Statistical Modeling, Regression, Prediction, Outlier Detection, Categorial Variable*
 
## *Machine Learning Assignment*
Implemented several machine learning and deep learning models from scratch.<br />
* [LDA vs PCA](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/CSCI%205521/LDA%20&%20PCA)<br />
* [Gaussian Classification](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/CSCI%205521/Gaussian%20Classification)<br />
* Run **k-nearest neighbors (KNN)** classification using a subset of the UCI Optdigits dataset, which is composed of **1500 training samples**, and 297 test samples, each with **64 features**. [Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/CSCI%205521/HW2/Question2)
* Apply **PCA** to visualize the **modified Faces dataset** from the UCI repository, which contains a total of **156 images** in this dataset. There are 4 facial expressions (neutral, happy, sad, angry) and 2 eye states (open, sunglasses) of each of the 20 people in this dataset. [Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/CSCI%205521/HW2/Question2)
* Implement **K-Means algorithm**, using squared Euclidean distance, to do **image compression** by clustering the pixels in the image file. [Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/CSCI%205521/HW2/Question3)
* Implement a **Multilayer Perceptron (MLP)** for optical-digit classification. [Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/CSCI%205521/HW3/Question4)
* Implement a **Kernel Perceptron** using **Radial Basis Function (RBF) kernel**. [Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/CSCI%205521/HW3/Question5)
* Apply a **Univariate Decision Tree** for optical-digit classification. [Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/CSCI%205521/HW4)

**Keywords**: *Matlab, Machine Learning, LDA, PCA, KNN, K-Means, MLP, RBF, Kernel Perceptron, Decision Tree*

## *Nonlinear Optimization Assignment*
* Implement **Steepest descent method** with **Armijo step size rule**;<br /> **Diagonally scaled gradient method** (using the Hessian diagonals) with **constant step size rule**;<br /> **Conjugate gradient method** with **exact minimization step size rule**;<br /> **Preconditioned conjugate gradient method** (using the Hessian diagonals) with exact minimization step size rule. [Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/EE%205239/HW2) 
* Run Steepest Descent using **diminishing stepsize rule** on a randomly generated problem [Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/EE%205239/HW3)
* Use **linear least squares** and the **logistic regression model** to do classification. [Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/EE%205239/HW4)
* Use **support vector machine (SVM)** to perform the classification. [Code](https://github.com/EchoZhaoo/DS-Project-Portfolio/tree/master/Matlab%20Code/EE%205239/HW5)

**Keywords**: *Matlab, Optimization, Gradient Descent, Support Vector Machine*



Please feel free to contact me at [zhao1020@umn.edu](zhao1020@umn.edu) to connect!
