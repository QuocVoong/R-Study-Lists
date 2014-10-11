from numpy import *
import random

def process(data):
    return map(lambda x:map(float,x.split()),data)

def toXY(data):
    arrdata = array(data)
    dim = len(data[0])
    X = append(arrdata[: , 0:dim-1],[[1] for i in range(len(data))],axis=1)
    Y = arrdata[: , dim-1]
    return X,Y

def sign(x):
    if x>0:
        return 1
    else:
        return -1
    
raw_data_train = process(open('p18_train.dat').readlines())
raw_data_test = process(open('p18_test.dat').readlines())

train_X , train_Y = toXY(raw_data_train)
test_X , test_Y = toXY(raw_data_test)


def verify(w,X,Y): #return #no of correct cases
    return len([ y for x,y in zip(X,Y) if sign(dot(w,x))==y])

def train(X,Y,times=50,pocket=True):
    w = zeros(len(X[0]))
    retw = w.copy()
    mx = 0
    order = range(len(X))
    while True:
        i = random.choice(order)
        x = X[i]
        y = Y[i]
        if sign(dot(w,x))!=y:
            w = w + y*x
            if pocket:   
                tmx = verify(w, X, Y)
                if tmx>mx:
                    mx=tmx
                    retw=w.copy()
            times-=1
        if times==0:
            break
    if not pocket:
        retw = w.copy()
    return retw

def test(times=50,pocket=True,testtimes=2000):
    print 'doing test ',testtimes,' times with update time',times,'and pocket',pocket
    errlist = []
    for i in range(testtimes):
        w = train(train_X,train_Y,times,pocket)
        err = 1.0-verify(w,test_X, test_Y)*1.0/len(test_X)
        errlist.append(err)
    errlist = array(errlist)
    print 'error mean:',mean(errlist),'variance',var(errlist)
 
test(50,True,2000)
test(50,False,2000)
test(100,False,2000)
    

    