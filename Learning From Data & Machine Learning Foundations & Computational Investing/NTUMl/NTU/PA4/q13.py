import numpy as np
from numpy.linalg import norm
from sklearn import linear_model
import matplotlib.pyplot as plt
import random

def process(data):
    return map(lambda x:map(float,x.split()),data)

def toXY(data):
    arrdata = np.array(data)
    dim = len(data[0])
    X = arrdata[: , 0:dim-1]
    Y = arrdata[: , dim-1]
    return X,Y

def sign(x):
    if x>0:
        return 1
    else:
        return -1

raw_data_train = open('hw4_train.dat').readlines()
raw_data_test = open('hw4_test.dat').readlines()


X_train,Y_train = toXY(process(raw_data_train))
X_test,Y_test = toXY(process(raw_data_test))


def err_model(model,X,Y):
    y = np.array(map(lambda x: sign(model.predict(x)),X))
    return 1.0 * sum(y != Y) / len(Y)


def err(logalpha):
    model = linear_model.Ridge(alpha=10**logalpha)
    model.fit(X_train,Y_train)
    return err_model(model,X_train,Y_train),err_model(model,X_test,Y_test)



logalphas = range(2,-11,-1)
errs = map(err,logalphas)
e_in,e_out = zip(*errs)
print e_in
print e_out
plt.plot(logalphas,e_in,label='e_in')
plt.plot(logalphas,e_out,label='e_out')

plt.legend()

plt.show()

    
    
