from math import exp

#written by 'brute force'
eps = 1e-5
def e(u,v):
    return exp(u)+exp(2*v)+exp(u*v)+(u**2)-2*u*v+2*(v**2)-3*u-2*v

def gradfu(f,u,v):
    return (f(u+eps,v)-f(u,v))/eps

def gradfv(f,u,v):
    return (f(u,v+eps)-f(u,v))/eps


def grad(u,v):
    return (e(u+eps,v)-e(u,v))/eps,(e(u,v+eps)-e(u,v))/eps

def h(u,v):
    return [ [gradfu(lambda u,v: gradfu(e,u,v),u,v),gradfv(lambda u,v: gradfu(e,u,v),u,v)],
            [gradfu(lambda u,v: gradfv(e,u,v),u,v),gradfv(lambda u,v: gradfv(e,u,v),u,v)]]

def inv2(mat):
    a = mat[0][0]
    b = mat[0][1]
    c = mat[1][0]
    d = mat[1][1]
    det = a*d - b*c
    a/=det
    b/=det
    c/=det
    d/=det
    return [[d,-b],[-c,a]]

def mul(mat,v):
    ret = [0,0]
    for i in range(len(mat)):
        for j in range(len(mat[0])):
            ret[i] += mat[i][j]*v[i]
    return (ret[0],ret[1])

def gradfinal(u,v):
    print h(u,v)
    return mul(inv2(h(u,v)),grad(u,v))


ev = (0,0)
r = 1

print 'e0=',e(ev[0],ev[1])
for i in range(5):
    g = gradfinal(ev[0],ev[1])
    ev = (ev[0]-r*g[0],ev[1]-r*g[1])
    print e(ev[0],ev[1])
    
print e(ev[0],ev[1])