import numpy as np
import numpy.random as r

def get_prob(line1,line2,ntry=1000):
        data = np.hstack([r.rand(ntry,2)*2-1, np.ones([ntry,1])])
        label1 = np.sign(np.sum(data*line1,axis=1))
        label2 = np.sign(np.sum(data*line2,axis=1))
        return sum(label1!=label2)/ntry

def run_once(N):
    ## PLA Algorithms
    ## return (#iterations,#learned,#real)
    real = r.randn(3)*2-1
    data = np.hstack([r.rand(N,2)*2-1, np.ones([N,1])])
    label = np.sign(np.sum(data*real, axis=1))
    current = np.zeros(3)
    niter = 0

    def find_error(current):
        cur_label = np.sign(np.sum(data*current, axis=1))
        return [i for i in range(N) if cur_label[i]!=label[i]]


    while find_error(current):
        idx = r.choice(find_error(current))
        current += label[idx]*data[idx]
        niter+=1

    return niter,current,real

sumprob = 0
for i in range(1000):
    niter,current,real = run_once(100)
    current/=np.linalg.norm(current)
    real/=np.linalg.norm(real)
    prob = get_prob(current,real,1000)
    sumprob+=prob
    print(prob,current,real)
print(sumprob/1000)