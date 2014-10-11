# -*- coding: utf-8 -*-
"""
Created on Sun Oct 05 10:02:23 2014

@author: grischenko
"""

#import numpy as np
import random
#import matplotlib.pyplot as plt
#import matplotlib.axes as axs
import pylab as mpl
    
x = range(25)
y = []
for i in range(25):
    y.append(random.randint(1,5))

print x, y

mpl.figure()
mpl.title("test")
mpl.xlabel("sdsf")

#mpl.axes.Axes.set_xlabel("time")


mpl.plot(x, y)
mpl.draw()

#plt.hold()
#plt.title('helo')
#my = plt.plot(x, y)
#plt.ylabel("vol")
#plt.ylabel = "vol"
#axs.Axes.set_xlabel(my.xlabel, "time")
#plt.draw()