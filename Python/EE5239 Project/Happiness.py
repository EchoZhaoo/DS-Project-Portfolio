import numpy as np
import pandas as pd

import csv

INPUT = './input/'
child_wishlist = pd.read_csv(INPUT+'child_wishlist_v2.csv', header=None).values
gift_goodkids = pd.read_csv(INPUT+'gift_goodkids_v2.csv', header=None).values

c1 = 5001       # triplets
c2 = 40000      # twins
c3 = 1000000   # total


#%% get total hapiness
def get_hap(child,gift):

    #hapiness of child
    h4c = dict()
    n = child.shape[1]      # number of children
    limt =42

    for i in range(0, c1):
        node = i - (i % 3)
        for j in range(limt):
            if (node, child[i][j]) in h4c:
                h4c[(node, child[i][j])] += 10 * (1 + (n - j) * 2)
            else:
                h4c[(node, child[i][j])] = 10 * (1 + (n - j) * 2)
    print("1 Done")
    for i in range(c1, c1+c2):
        node = i + (i % 2)
        for j in range(limt):
            if (node, child[i][j]) in h4c:
                h4c[(node, child[i][j])] += 10 * (1 + (n - j) * 2)
            else:
                h4c[(node, child[i][j])] = 10 * (1 + (n - j) * 2)
    print("2 Done")
    for i in range(c1+c2, c3):
        for j in range(limt):
            h4c[(i, child[i][j])] = 10 * (1 + (n - j) * 2)
    print("3 Done")
    # hapiness for santa
    h4s = dict()
    for i in range(gift.shape[0]):
        for j in range(gift.shape[1]):
            cur_child = gift[i][j]
            if cur_child < c1:
                cur_child -= cur_child % 3
            elif cur_child < c1+c2:
                cur_child += cur_child % 2
            h4s[(cur_child, i)] = (1 + (gift.shape[1] - j) * 2)
    print("4 Done")

    # for cutting some edges, if they ain't liked by each other.
    positive_cases = list(set(h4c.keys()) | set(h4s.keys()))
    print('Positive case tuples (child, gift): {}'.format(len(positive_cases)))
    print("5 Done")
    # final happiness dictionary
    h = dict()
    for p in positive_cases:
        h[p] = 0
        if p in h4c:
            a = h4c[p]
            h[p] += int((a ** 3) * 4)
        if p in h4s:
            b = h4s[p]
            h[p] += int((b ** 3) / 4)
    print("6 Done")

    w = csv.writer(open("graph.csv", "w"))
    for key, val in h.items():
        w.writerow([key, val])
    print("Write out Done")
