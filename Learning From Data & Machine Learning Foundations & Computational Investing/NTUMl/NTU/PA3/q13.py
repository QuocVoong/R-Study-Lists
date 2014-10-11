import random
import numpy as np
from sklearn import linear_model

def sign(x):
    if x>=0:
        return 1
    else:
        return -1

def f(X):
    return sign(X[0]**2+X[1]**2-0.6)

def genX(N=1000):
    return np.array([ np.array([random.uniform(-1.0,1.0),random.uniform(-1.0,1.0)]) for i in xrange(N)])


def addnoise(Y):
    ret= Y[:]
    for i in range(len(Y)):
        if random.random()<0.1:
            ret[i]*=-1
    return ret

def transform(x):
    return np.array([x[0],x[1],x[0]*x[1],x[0]**2,x[1]**2])


def genXY(N=1000):
    X = genX()
    Y = addnoise(map(f,X))
    return X,Y


def run_q13_once(t=0):
    #print 't=',t
    X_train,Y_train = genXY()
   
    regr = linear_model.LinearRegression()
    
    regr.fit(X_train,Y_train)
    
    E_in = sum(np.array(map(sign,regr.predict(X_train))) != np.array(Y_train))
    return E_in *1.0 / len(X_train)
    
def run_q14():
    X_train,Y_train = genXY()
    X_train = map(transform,X_train)
    regr = linear_model.LinearRegression()
    regr.fit(X_train,Y_train)
    print regr.coef_,regr.intercept_
    


def run_q15_once(t):
    print 't=',t
    X_train,Y_train = genXY()
    X_test,Y_test = genXY()
    X_train = map(transform,X_train)
    X_test = map(transform,X_test)
    regr = linear_model.LinearRegression()
    regr.fit(X_train,Y_train)
    
    E_out = sum(np.array(map(sign,regr.predict(X_test))) != np.array(Y_test))
    
    return E_out *1.0 / len(X_train)
#print 'q13 E_in=', sum([run_q13_once(i) for i in xrange(1000)])/1000.0

print 'q15 E_out=',sum([run_q15_once(i) for i in xrange(1000)])/1000.0



