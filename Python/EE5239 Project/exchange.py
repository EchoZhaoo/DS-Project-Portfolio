#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec  5 16:28:59 2018

@author: chen6271
"""

import numpy as np
import pandas as pd

import csv

c3=1000000

res = []

OUTPUT = './output/'
mapng = pd.read_csv(OUTPUT+'result.csv', header=None).values
print(len(mapng))
mapng = mapng[mapng[:,0].argsort()]

for i in range(len(mapng)):
    if mapng[i][2] > 0:
        res.append[mapng[i]]

np.savetxt(OUTPUT+'result.csv', res, delimiter=",")