#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sat Dec  8 10:34:13 2018

@author: echozhao
"""

#%%
import numpy as np
import matplotlib.pyplot as plt
import operator
import seaborn as sns


#%%
child_wishlist = child_wishlist.values
gift_goodkids = gift_goodkids.values
gift_ranking = child_wishlist[:, 1:]
child_ranking = gift_goodkids[:, 1:]


#%% 
c_3 = 5001          # triplets
c_2 = 40000         # twins
c_n = 1000000
g_n = 1000

# Count gift fo all kids
n = dict([(key, 0) for key in range(g_n)])
for i in range(1000):  # Only the first 1000 rows to test
    gift = gift_ranking[i,:].tolist()   # Gift list for one kid
    for j in range(g_n):
        n[j] = n[j] + gift.count(j)

# Count children for all gifts
m = dict([(key, 0) for key in range(10000)])
for i in range(g_n):   # Iterate each gift
    child = child_ranking[i,:].tolist()     # A wish list full of ChildId for one gift
    for j in range(10000):                  # Only consider the first 10000 kids
        m[j] = m[j] + child.count(j) 

# Count gift for triplets
n_3 = dict([(key, 0) for key in range(g_n)])
for i in range(c_3):  
    gift_3 = gift_ranking[i,:].tolist()   # Gift list for one triplet
    for j in range(g_n):
        n_3[j] = n_3[j] + gift_3.count(j)
        
        
# Count gift for twins
n_2 = dict([(key, 0) for key in range(g_n)])
for i in range(c_2):  
    gift_2 = gift_ranking[i,:].tolist()   # Gift list for one twin
    for j in range(g_n):
        n_2[j] = n_2[j] + gift_2.count(j)
        
        
#%% Sort the dictionary by values
# Sort Gift
sorted_n = sorted(n.items(), key = operator.itemgetter(1), reverse = True)
sorted_n = sorted_n[:50]
present = [i[0] for i in sorted_n]
frequency_g = [i[1] for i in sorted_n]

# Sord Children
sorted_m = sorted(m.items(), key = operator.itemgetter(1), reverse = True)
sorted_m = sorted_m[:50]
kid = [i[0] for i in sorted_m]
frequency_c = [i[1] for i in sorted_m]

# For triplets
sorted_n_3 = sorted(n_3.items(), key = operator.itemgetter(1), reverse = True)
sorted_n_3 = sorted_n_3[:50]
present_3 = [i[0] for i in sorted_n_3]
frequency_g_3 = [i[1] for i in sorted_n_3]

# For twins
sorted_n_2 = sorted(n_2.items(), key = operator.itemgetter(1), reverse = True)
sorted_n_2 = sorted_n_2[:50]
present_2 = [i[0] for i in sorted_n_2]
frequency_g_2 = [i[1] for i in sorted_n_2]

#%% Plot the first 50 favorable gifts
plt.figure(figsize = (14, 8))
plt.rcParams['axes.facecolor'] = 'gainsboro'
sns.set(font = "serif")
ax1 = plt.bar(range(50), frequency_g, width = 0.4)
for idx, freq in enumerate(frequency_g):
    if freq > 210:
        ax1.patches[idx].set_color('#023325')
    elif freq > 205:
        ax1.patches[idx].set_color('#02684b')
    elif freq > 200:
        ax1.patches[idx].set_color('#25d1b7')
    elif freq > 195:
        ax1.patches[idx].set_color('#67e0bf')
    elif freq > 190: 
        ax1.patches[idx].set_color('#94fce0')
#    elif freq > 185: 
#        ax1.patches[idx].set_color('#94fce0')
    else:
        ax1.patches[idx].set_color('#c2f9ea')
                       
font_label = {'family': 'Times New Roman', 'weight': 'normal', 'size': 22,}
# x axis
plt.xticks(range(50), present, fontsize = 11, rotation = 60)
plt.xlabel('Gifts Number', font_label)
# y axis
plt.yticks(fontsize = 17)
plt.ylabel('Gift Frequency', font_label)
# add title
font_title = {'family' : 'Times New Roman', 'weight' : 'bold', 'size' : 28}
plt.title('The First 50 liked Gifts', font_title)
# set grid
plt.grid(color = 'black', linestyle = '--', linewidth = 1, axis = 'y')
# save image
#plt.savefig("//Files.umn.edu/cse/UmSaveDocs/zhao1020/Desktop/TalkingData_data/Undersampling/count_uniq.jpg") 


#%% Plot the first 50 favorable children
plt.figure(figsize = (14, 8))
plt.rcParams['axes.facecolor'] = 'gainsboro'
sns.set(font = "serif")
ax1 = plt.bar(range(50), frequency_c, width = 0.4)
for idx, freq in enumerate(frequency_c):
    if freq > 7:
        ax1.patches[idx].set_color('#5a0196')
    elif freq > 6:
        ax1.patches[idx].set_color('#9f68c4')
    elif freq > 5:
        ax1.patches[idx].set_color('#c69fe0')
    elif freq > 4:
        ax1.patches[idx].set_color('#edd3ff')
#    elif freq > 190: 
#        ax1.patches[idx].set_color('#94fce0')
#    elif freq > 185: 
#        ax1.patches[idx].set_color('#94fce0')
#    else:
#        ax1.patches[idx].set_color('#c2f9ea')
                       
font_label = {'family': 'Times New Roman', 'weight': 'normal', 'size': 22,}
# x axis
plt.xticks(range(50), present, fontsize = 11, rotation = 60)
plt.xlabel('Child ID', font_label)
# y axis
plt.yticks(fontsize = 17)
plt.ylabel('Child Frequency', font_label)
# add title
font_title = {'family' : 'Times New Roman', 'weight' : 'bold', 'size' : 28}
plt.title('The First 50 liked Children', font_title)
# set grid
plt.grid(color = 'black', linestyle = '--', linewidth = 1, axis = 'y')
# save image
#plt.savefig("//Files.umn.edu/cse/UmSaveDocs/zhao1020/Desktop/TalkingData_data/Undersampling/count_uniq.jpg") 


#%% Plot the first 50 favorable gifts for triplets
plt.figure(figsize = (14, 8))
plt.rcParams['axes.facecolor'] = 'gainsboro'
sns.set(font = "serif")
ax1 = plt.bar(range(50), frequency_g_3, width = 0.4)
for idx, freq in enumerate(frequency_g_3):
    if freq > 1000:
        ax1.patches[idx].set_color('#000656')
    elif freq > 990:
        ax1.patches[idx].set_color('#0b17a8')
    elif freq > 980:
        ax1.patches[idx].set_color('#2838ff')
    elif freq > 970:
        ax1.patches[idx].set_color('#0b8eed')
    elif freq > 960: 
        ax1.patches[idx].set_color('#31d0f7')
    elif freq > 950: 
        ax1.patches[idx].set_color('#30f0f7')
    elif freq > 940: 
        ax1.patches[idx].set_color('#77cbff')
    elif freq > 930: 
        ax1.patches[idx].set_color('#adf4f7')
    else:
        ax1.patches[idx].set_color('#ddf1ff')
                       
font_label = {'family': 'Times New Roman', 'weight': 'normal', 'size': 22,}
# x axis
plt.xticks(range(50), present_3, fontsize = 11, rotation = 60)
plt.xlabel('Gifts Number', font_label)
# y axis
plt.yticks(fontsize = 17)
plt.ylabel('Gift Frequency', font_label)
# add title
font_title = {'family' : 'Times New Roman', 'weight' : 'bold', 'size' : 28}
plt.title('The First 50 liked Gifts for Triplets', font_title)
# set grid
plt.grid(color = 'black', linestyle = '--', linewidth = 1, axis = 'y')
# save image
plt.savefig("/Users/echozhao/Documents/2018 Fall/EE 5239/Project/Gift_Freq_Triplets.jpg") 


#%% Plot the first 50 favorable gifts for twins
plt.figure(figsize = (14, 8))
plt.rcParams['axes.facecolor'] = 'gainsboro'
sns.set(font = "serif")
ax1 = plt.bar(range(50), frequency_g_2, width = 0.4)
for idx, freq in enumerate(frequency_g_2):
    if freq > 7800:
        ax1.patches[idx].set_color('#223a00')
    elif freq > 7700:
        ax1.patches[idx].set_color('#467701')
    elif freq > 7650:
        ax1.patches[idx].set_color('#29a004')
    elif freq > 7600:
        ax1.patches[idx].set_color('#35db02')
    elif freq > 7550: 
        ax1.patches[idx].set_color('#aaf43a')
    elif freq > 7500: 
        ax1.patches[idx].set_color('#e1f943')
    elif freq > 7450: 
        ax1.patches[idx].set_color('#dfffad')
    else:
        ax1.patches[idx].set_color('#f9ffd3')
                       
font_label = {'family': 'Times New Roman', 'weight': 'normal', 'size': 22,}
# x axis
plt.xticks(range(50), present_2, fontsize = 11, rotation = 60)
plt.xlabel('Gifts Number', font_label)
# y axis
plt.yticks(fontsize = 17)
plt.ylabel('Gift Frequency', font_label)
# add title
font_title = {'family' : 'Times New Roman', 'weight' : 'bold', 'size' : 28}
plt.title('The First 50 liked Gifts for Twins', font_title)
# set grid
plt.grid(color = 'black', linestyle = '--', linewidth = 1, axis = 'y')
# save image
plt.savefig("/Users/echozhao/Documents/2018 Fall/EE 5239/Project/Gift_Freq_Twins.jpg") 








        
