#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec  4 17:57:15 2018

@author: zhao1020
"""
from ortools.graph import pywrapgraph
from Happiness import get_hap
import pickle

g_n = 1000 #gift number

c1 = 5001       # triplets
c2 = 40000      # twins
c3 = 1000000   # total

def solve_mcf(h):
    start_n = []
    end_n = []
    capacities = []
    unit_costs =[]
    supplies = []
    for hh in h:
        (c, g) = hh
        
        start_n.append(int(c))
        end_n.append(int(c3 + g))
        
        # Capacities
        if c < c1:
            capacities.append(3)
        elif c < c1+c2:
            capacities.append(2)
        else:
            capacities.append(1)
        
        unit_costs.append(-h[hh])
        
    # Supplies
    for i in range(c3):
        if i < c1:
            supplies.append(3)
        elif i < c1+c2:
            supplies.append(2)
        else:
            supplies.append(1)
            
    for j in range(c3, c3+g_n):
        supplies.append(-1000)

    # Instance        
    min_cost_flow = pywrapgraph.SimpleMinCostFlow()
    
    #print(len(start_n),len(end_n),len(capacities),len(unit_costs),len(supplies))
            
     # Add each arc.
    for i in range(0, len(start_nodes)):
         min_cost_flow.AddArcWithCapacityAndUnitCost(start_nodes[i], end_nodes[i],
                                                    capacities[i], unit_costs[i])
    
      # Add node supplies.
    
    for i in range(0, len(supplies)):
         min_cost_flow.SetNodeSupply(i, supplies[i])    
     
        
    # Find the minimum cost flow
    print('Start solve....')
    min_cost_flow.SolveMaxFlowWithMinCost()
    res1 = min_cost_flow.MaximumFlow()
    print('Maximum flow:', res1)
    res2 = min_cost_flow.OptimalCost()
    print('Optimal cost:', -res2 / 2000000000)
    print('Num arcs:', min_cost_flow.NumArcs())
        