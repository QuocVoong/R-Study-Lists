
from random import uniform
def sign(x):
    if x>0:
        return 1
    else:
        return -1
N = 10000
X = [ uniform(-1,1) for i in xrange(N)]
Y = map(sign,X)
for i in xrange(len(Y)):
    if uniform(0,1)<0.2:
        Y[i]*=-1 
eout = 0
s = 1
theta = 0

def h(x,s,theta):
    return sign(sign(x-theta)*float(s))

for x,y in zip(X,Y):
    ybar = h(x,s,theta)
    eout += y != ybar
print 'Eout=',eout/10000.0
