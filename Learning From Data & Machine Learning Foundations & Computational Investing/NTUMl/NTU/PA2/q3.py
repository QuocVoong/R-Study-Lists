from math import log,exp,sqrt

def ln(x):
    return log(x)/log(exp(1.0))
def lnmh(N,dvc):
    return dvc*ln(N)
def vcbound(N,dvc=10,delta=0.05):
    return sqrt(8.0/N/log(exp(1.0))*(log(4)+dvc*log(2*N)-log(delta)))

def devbound(N,dvc,delta,eps):
    return sqrt(1.0/2.0/N*(4*eps*(1+eps)+ln(4)-ln(delta)+lnmh(N**2,dvc)))



def bisect(f,N,dvc,delta):
    left=0.0
    right=10000.0
    mid=0.5
    while right-left>1e-8:
        mid = (left+right)*0.5
        if f(N,dvc,delta,mid)<mid:
            right=mid
        else:
            left=mid
    return mid
def pvbound(N,dvc,delta,eps):
    return sqrt(1.0/N*(2*eps+ln(6)-ln(delta)+lnmh(2*N,dvc)))

def rpbound(N,dvc,delta):
    return sqrt(2.0/N*lnmh(N,dvc)+ln(2)+ln(N))+ sqrt(2.0/N*ln(1.0/delta)) + 1.0/N

NS = [460000,440000,420000,480000]

print 'q3',NS,map(vcbound,NS)

print 'q4'

vcb = vcbound(10000,50,0.05)
rpb = rpbound(10000,50,0.05)
mb = min(vcb,rpb)
print vcb,rpb,bisect(devbound,10000,50,0.05),bisect(pvbound, 10000, 50.0, 0.05)

print 'q5'

print vcbound(5, 50, 0.05),rpbound(5, 50, 0.05),bisect(devbound, 5, 50, 0.05),bisect(pvbound,5, 50, 0.05)
