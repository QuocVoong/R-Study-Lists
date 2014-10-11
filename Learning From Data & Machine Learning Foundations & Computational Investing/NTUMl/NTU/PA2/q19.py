import numpy as np

def process(data):
    return map(lambda x:map(float,x.split()),data)

def toXY(data):
    arrdata = np.array(data)
    dim = len(data[0])
    X = arrdata[: , 0:dim-1]
    Y = arrdata[: , dim-1]
    return X,Y

raw_data_train = open('hw2_train.dat').readlines()
raw_data_test = open('hw2_test.dat').readlines()


X_train,Y_train = toXY(process(raw_data_train))
X_test,Y_test = toXY(process(raw_data_test))
D_train = zip(X_train,Y_train)
D_test = zip(X_test,Y_test)


def sign(x):
    if x>0:
        return 1
    else:
        return -1
    
def h(s,i,theta,x):
    return s*sign(x[i]-theta)

def err(s,i,theta,data):
    return 1.0 * len([1 for x,y in data if h(s,i,theta,x)!=y])/len(data)

def train(data):
    rs=0
    ri=0
    rt=0
    error = 1.0

    X , Y = zip(*data)
    X = np.array(X)
    dim = len(X[0])
    for i in range(dim):
        Xi = X[: , i]
        Xis = sorted(Xi)
        for theta in [ (Xis[z]+Xis[z+1])/2.0 for z in range(len(Xis)-1)]:
            if err(1,i,theta,data)<error:
                error = err(1,i,theta,data)
                rs=1
                rt=theta
                ri=i
            if err(-1,i,theta,data)<error:
                error = err(-1,i,theta,data)
                rs=-1
                rt=theta
                ri=i
    return rs,ri,rt

s,i,theta = train(D_train)

print err(s, i, theta, D_train),err(s,i,theta,D_test)
           