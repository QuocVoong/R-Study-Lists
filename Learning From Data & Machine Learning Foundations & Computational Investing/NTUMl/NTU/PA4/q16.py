import numpy as np
from sklearn import linear_model
import matplotlib.pyplot as plt


def process(data):
    return map(lambda x:map(float,x.split()),data)

def toXY(data):
    arrdata = np.array(data)
    dim = len(data[0])
    X = arrdata[: , 0:dim-1]
    Y = arrdata[: , dim-1]
    return zip(X,Y)

def sign(x):
    if x>=0:
        return 1
    else:
        return -1

raw_data_train = open('hw4_train.dat').readlines()
raw_data_test = open('hw4_test.dat').readlines()


D_train = toXY(process(raw_data_train))
D_cv = D_train[120:]
D_train = D_train[:120]
D_all = D_train + D_cv
D_test = toXY(process(raw_data_test))


def err_model(model,D):
    X,Y = zip(*D)
    y = np.array(map(lambda x: sign(model.predict(x)),X))
    return 1.0 * sum(y != Y) / len(Y)

def getmodel(logalpha,D=D_train):
    model = linear_model.Ridge(alpha=10**logalpha)
    X_train,Y_train=zip(*D)
    model.fit(X_train,Y_train)
    return model

logalphas = range(2,-11,-1)

models = map(getmodel,logalphas)

err_train = map(lambda m: err_model(m,D_train),models)
err_cv = map(lambda m:err_model(m,D_cv),models)
err_cv2 = np.zeros(len(logalphas))

err_test = map(lambda m:err_model(m,D_test),models)





for i in range(5):
    D_train_temp = D_all[0:i*40] + D_all[i*40+40:]
    D_val_temp = D_all[i*40:i*40+40]
    models = map(lambda m: getmodel(m,D_train_temp),logalphas)
    err_delta =map(lambda m:err_model(m,D_val_temp),models)
    err_cv2 +=  err_delta

err_cv2/=5.0




print err_train
print err_cv
print err_cv2
print err_test
plt.plot(logalphas,err_train,label='err_train')
plt.plot(logalphas,err_cv,label='err_cv')
plt.plot(logalphas,err_test,label='err_test')
plt.plot(logalphas,err_cv2,label='err_cv_5fold')
plt.legend()
plt.show()
    
    
