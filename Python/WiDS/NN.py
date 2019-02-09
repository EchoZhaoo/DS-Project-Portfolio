#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 26 20:02:49 2018

@author: echozhao
"""

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from pybrain.structure import FeedForwardNetwork
from pybrain.structure import LinearLayer, TanhLayer, FullConnection, SigmoidLayer
from pybrain.supervised.trainers import BackpropTrainer
from pybrain.datasets import SupervisedDataSet
from pybrain.tools.customxml.networkwriter import NetworkWriter
from sklearn.preprocessing import MinMaxScaler
from sklearn.externals import joblib

#%% Train/test split
# Load in data
train = pd.read_csv('/Users/echozhao/Documents/WiDS/pp_data/trainpp.csv')
test = pd.read_csv('/Users/echozhao/Documents/WiDS/pp_data/testpp.csv')

# Separate response variables from predictors
X = train.drop(['is_female'],axis=1)
y = list(train.is_female)


#%%
#######################################################
######### Build Neural Network Manually ############
#######################################################

# Data standardization 
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.3)
sx = MinMaxScaler()
X_train = sx.fit_transform(X_train)
X_test = sx.transform(X_test)
stest = MinMaxScaler()
test_id = test['test_id']
test = test.drop(['test_id'], axis = 1)
test = stest.fit_transform(test)

# Initialize supervised dataset
ds = SupervisedDataSet(test.shape[1], 1)
ds_train = SupervisedDataSet(X.shape[1], 1)
ds_test = SupervisedDataSet(X.shape[1], 1)

# put data and label into ds  
for i in range(len(X_train)):
    ds_train.addSample(X_train[i], y_train[i])

for i in range(len(X_test)):
    ds_test.addSample(X_test[i], y_test[i])
  
Y = np.random.random(size = test.shape[0])
for i in range(len(test)):
    ds.addSample(test[i], Y[i])

#%%
# Initialize Forward Network
fnn = FeedForwardNetwork()

# Build input layer, hiddern layer and output layer
inLayer = LinearLayer(X.shape[1], 'inLayer')
hiddenLayer = TanhLayer(5, 'hiddenLayer')
#hiddenLayer = SigmoidLayer(5, 'hiddenLayer')
outLayer = LinearLayer(1, 'outLayer')

# Add input layer, hiddern layer and output layer into fnn
fnn.addInputModule(inLayer)
fnn.addModule(hiddenLayer)
fnn.addOutputModule(outLayer)

# Create full connection between each layer
in_to_hidden = FullConnection(inLayer, hiddenLayer)
hidden_to_out = FullConnection(hiddenLayer, outLayer)

# Create connection with fnn
fnn.addConnection(in_to_hidden)
fnn.addConnection(hidden_to_out)
fnn.sortModules()

# Train fnn using BP until convergence
trainer = BackpropTrainer(fnn, ds_train, learningrate = 0.01, verbose = True,
                          weightdecay = 0.1)
# batchlearning = True, weightdecay = 0.1, momentum
err_train, err_valid = trainer.trainUntilConvergence(maxEpochs = 1000)

# convergence curve
import matplotlib.pyplot as plt
plt.plot(err_train, 'b', err_valid, 'r')
plt.show()

# model testing
from pybrain.utilities import percentError
testResult = percentError(trainer.testOnClassData(), ds_test['target'])
print("epoch: %d" % trainer.totalepochs, "test error: %f%%" % testResult)

#%%
# Save model and result
NetworkWriter.writeToFile(fnn, '/Users/echozhao/Documents/WiDS/fnn.xml')
joblib.dump(sx, 'sx.pkl', compress = 3)

# Load Model
# fnn = NetworkReader.readFrom('/Users/echozhao/Documents/WiDS/fnn.xml')
# sx = joblib.load('sx.pkl')


#%%
# Doing Prediction
pred = np.array([fnn.activate(x) for x, _ in ds])
for i in range(pred.shape[0]):
    pred[i] = round(pred[i])
pred = pd.DataFrame(pred)
pred.columns = ['is_female']
pred.insert(0, 'test_id', test_id)
pred.to_csv("/Users/echozhao/Documents/WiDS/fnn_pred.csv", index = None)
print("prediction finished")





