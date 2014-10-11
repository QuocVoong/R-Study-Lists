from numpy import *
from random import *

raw_data = map(lambda x : map(float,x.split()),open('p15_train.dat').readlines())
data = array(raw_data)
dim = len(data[0])-1
X = data[: , 0:dim]
X=append(X,[ [1] for i in range(len(data)) ],axis=1) # adding a extra dimension
Y = data[: , dim]


 
def sign(x):
    if x<=0:
        return -1
    else:
        return 1
    
def run_once(naive=True,delta=1.0):
    cnt = 0
    update_cnt = 0
    w = zeros(dim+1)
    while True:
        cnt+=1
        finished = True
        order = range(0,len(X))
        if not naive:
            shuffle(order)
        for i in order:
            x = X[i]
            y = Y[i]
            if sign(dot(w,x))!=y:
                w=w + delta*y*x
                update_cnt += 1
                finished=False
        if finished:
            return array([update_cnt,sqrt((w**2).sum())])
    
print 'naive cycle:',run_once(),'updates'
print 'random cycle:',array([run_once(False) for i in range(2000)]).sum(axis=0)/2000.0,'updates'
print 'random cycle with learning rate 0.5:',array([run_once(False,0.5) for i in range(2000)]).sum(axis=0)/2000.0,'updates'