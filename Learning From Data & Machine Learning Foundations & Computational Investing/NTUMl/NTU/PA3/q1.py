def err(N,delta=0.1,d=8):
    return (delta**2.0) *(1.0 - (d+1.0)/N) 

n = [10,25,100,500]

print map(err,n)