import numpy as np
from numpy.linalg import norm
import random

def process(data):
    return map(lambda x:map(float,x.split()),data)

def addone(X):
    XT = X.transpose()
    one = np.ones(len(X))
    XT = np.vstack((XT,one))
    return XT.transpose()
def toXY(data):
    arrdata = np.array(data)
    dim = len(data[0])
    X = addone(arrdata[: , 0:dim-1])
    Y = arrdata[: , dim-1]
    return X,Y

raw_data_train = open('hw3_train.dat').readlines()
raw_data_test = open('hw3_test.dat').readlines()


X_train,Y_train = toXY(process(raw_data_train))
X_test,Y_test = toXY(process(raw_data_test))

def sign(x):
    if x>=0:
        return 1
    else:
        return -1

def h(w,x):
    return 1.0/(1.0+ np.exp(-np.dot(w,x)))
def theta(x):
    if x<-50:
        return 0
    if x>50:
        return 1
    return 1.0/(1.0+ np.exp(-x))

def grad(w,x,y):
    return theta(np.dot(-y*w,x))*(-y*x)


def update_once(w,X,Y,i,rate=0.001):
    g = grad(w,X[i],Y[i]) 
    upd = rate * g 
    return w - upd



def trainsgd(X,Y,rate=0.001,T=2000,seq=False):
    dim = len(X_train[0])
    w = np.zeros(dim)
    
    curpos = 0
    for i in xrange(T):
        pos = random.randint(0,len(X)-1)
        if seq:
            pos = (curpos+1) % len(X)
            curpos = pos
        w = update_once(w[:], X, Y,pos, rate)
    return w


def train(X,Y,rate=0.001,T=2000):
    dim = len(X_train[0])
    w = np.zeros(dim)
    
    for t in range(T):
        if t%10==0:
            print 'doing',t
        upd = np.zeros(dim)
        for i in range(len(X)):
            upd += grad(w,X[i],Y[i])
        upd /= len(X)
        w-=upd *rate
    return w







def test(w,X,Y):
    Yhat = map(lambda x: sign(np.dot(w,x)),X)
    return 1.0 * sum(Yhat != Y) / len(X)


h18 = train(X_train,Y_train,0.001,2000)
h19 = train(X_train,Y_train,0.01,2000)
h20 = trainsgd(X_train,Y_train,0.001,2000,True)


print test(h18,X_test,Y_test)
print test(h19,X_test,Y_test)
print test(h20,X_test,Y_test)