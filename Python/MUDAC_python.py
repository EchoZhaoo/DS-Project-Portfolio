# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

#%% Import
import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn import metrics, cross_validation
from sklearn.cross_validation import train_test_split
from sklearn.metrics import accuracy_score


#%% Merge tables into dataframe
df = pd.read_csv('MUDAC/df.csv')
df_test = pd.read_csv('MUDAC/df_test.csv')

df1 = df.filter(['HCU', 'gender', 'POS11', 'POS21', 'POS24', 'POS81', 'AGECAT', 'CONF_CAT'], axis=1).copy()
df2 = pd.get_dummies(df1, columns = ['gender']).fillna(0)
df_test1 = df.filter(['HCU', 'gender', 'POS11', 'POS21', 'POS24', 'POS81', 'AGECAT', 'CONF_CAT'], axis=1).copy()
df_test2 = pd.get_dummies(df_test1, columns = ['gender']).fillna(0)

X_train = df2.iloc[:,1:]
y_train = df2.iloc[:,0]
X_test = df_test2.iloc[:,1:]

#%% Logistic Regression
logreg = LogisticRegression()
logreg.fit(X_train, y_train)
pred = logreg.predict(X_test)
df_test['pred'] = pred
output = df_test.loc[df_test['pred'] == 1]
output.to_csv('MUDAC/out.csv',sep=',')

predicted = cross_validation.cross_val_predict(logreg, X_train, y_train, cv=10)
print (accuracy_score(y_train, predicted))
#print (metrics.classification_report(y, predicted))

#%% Random Forest
random_forest = RandomForestClassifier(n_estimators=100)
random_forest.fit(X_train, y_train)
pred = random_forest.predict(X_test)
df_test['pred'] = pred
output = df_test.loc[df_test['pred'] == 1]

predicted = cross_validation.cross_val_predict(random_forest, X_train, y_train, cv=10)
print (accuracy_score(y_train, predicted))
