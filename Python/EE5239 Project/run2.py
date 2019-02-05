#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec  4 19:34:40 2018

@author: chen6271
"""
INPUT_PATH = './input/'
from solve import solve_mcf

import csv
reader = csv.reader(open(INPUT_PATH+'graph.csv', 'r'), quotechar='"')
h = {}
#i = 1
for row in reader:
   k, v = row
   k = eval(k)
   h[k] = int(v)
   #i = i+1
   #if i>20:
      # break
   
print("Dict is Ready")

    
solve_mcf(h)