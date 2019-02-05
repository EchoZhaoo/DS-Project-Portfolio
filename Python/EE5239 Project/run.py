#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec  4 18:03:43 2018

@author: zhao1020
"""
import numpy as np
import pandas as pd
from Happiness import get_hap  

INPUT_PATH = './input/'

from solve import solve_mcf
child_wishlist = pd.read_csv(INPUT_PATH+'child_wishlist_v2.csv', header=None).values
gift_goodkids = pd.read_csv(INPUT_PATH+'gift_goodkids_v2.csv', header=None).values

