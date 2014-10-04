# -*- coding: utf-8 -*-
"""
Created on Tue Sep 09 13:33:38 2014

@author: Administrator

cite from : http://glowingpython.blogspot.tw/2011/10/perceptron.html
more about PLA : http://lcn.epfl.ch/tutorial/english/perceptron/html/learning.html
"""

from pylab import rand,plot,show,norm

class Perceptron:
 def __init__(self):
  """ perceptron initialization """
  self.w = rand(2)*2-1 # weights
  self.learningRate = 0.1

 def response(self,x):
  """ perceptron output """
  y = x[0]*self.w[0]+x[1]*self.w[1] # dot product between w and x
  if y >= 0:
   return 1
  else:
   return -1

 def updateWeights(self,x,iterError):
  """
   updates the weights status, w at time t+1 is
       w(t+1) = w(t) + learningRate*(d-r)*x
   where d is desired output and r the perceptron response
   iterError is (d-r)
  """
  self.w[0] += self.learningRate*iterError*x[0]
  self.w[1] += self.learningRate*iterError*x[1]

 def train(self,data):
  """ 
   trains all the vector in data.
   Every vector in data must have three elements,
   the third element (x[2]) must be the label (desired output)
  """
  learned = False
  iteration = 0
  while not learned:
   globalError = 0.0
   for x in data: # for each sample
    r = self.response(x)    
    if x[2] != r: # if we have a wrong response
     iterError = x[2] - r # desired response - actual response
     self.updateWeights(x,iterError)
     globalError += abs(iterError)
   iteration += 1
   if globalError == 0.0 or iteration >= 100: # stop criteria
    print 'iterations',iteration
    learned = True # stop learning
    
def generateData(n):
 """ 
  generates a 2D linearly separable dataset with n samples. 
  The third element of the sample is the label
 """
 xb = (rand(n)*2-1)/2-0.5
 yb = (rand(n)*2-1)/2+0.5
 xr = (rand(n)*2-1)/2+0.5
 yr = (rand(n)*2-1)/2-0.5
 inputs = []
 for i in range(len(xb)):
  inputs.append([xb[i],yb[i],1])
  inputs.append([xr[i],yr[i],-1])
 return inputs
 
trainset = generateData(30) # train set generation
perceptron = Perceptron()   # perceptron instance
perceptron.train(trainset)  # training
testset = generateData(20)  # test set generation

# Perceptron test
for x in testset:
 r = perceptron.response(x)
 if r != x[2]: # if the response is not correct
  print 'error'
 if r == 1:
  plot(x[0],x[1],'ob')  
 else:
  plot(x[0],x[1],'or')

# plot of the separation line.
# The separation line is orthogonal to w
n = norm(perceptron.w)
ww = perceptron.w/n
ww1 = [ww[1],-ww[0]]
ww2 = [-ww[1],ww[0]]
plot([ww1[0], ww2[0]],[ww1[1], ww2[1]],'--k')
show()