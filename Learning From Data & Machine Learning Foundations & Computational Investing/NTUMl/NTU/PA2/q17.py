from random import uniform

def sign(x):
    if x>0:
        return 1
    else:
        return -1

def runonce():
    N = 20
    X = [ uniform(-1,1) for i in xrange(2*N)]
    Y = map(sign,X)
    for i in xrange(len(Y)):
        if uniform(0,1)<0.2:
            Y[i]*=-1 
    X_train = X[:N]
    Y_train = Y[:N]
    d_train = zip(X_train,Y_train)
    X_test = X[N:]
    Y_test = Y[N:]
    d_test = zip(X_test,Y_test)
    d_train.sort
    d_test.sort 
    def h(x,s,theta):
        return s*sign(x-theta)
    def err(s,theta,data):
        err = 0
        for x,y in data:
            yhat = h(x,s,theta)
            err+= y!=yhat
        err *= 1.0
        err /= len(data)*1.0
        return err
    def train(data):
        rs = 0
        rt = 0
        error = 1.0
        for theta in [ (data[i][0]+data[i+1][0]) /2.0 for i in range(len(data)-1) ]:
            if err(1,theta,data)<error:
                error = err(1,theta,data)
                rs=1
                rt=theta
            if err(-1,theta,data)<error:
                error = err(-1,theta,data)
                rs=-1
                rt=theta
        return rs,rt
    s,theta = train(d_train)
    return err(s,theta,d_train),err(s,theta,d_test)

E_in,E_out = zip(*[runonce() for i in range(5000)])
print sum(E_in)/5000,sum(E_out)/5000
    
            