from math import exp


eps = 1e-5
def e(u,v):
    return exp(u)+exp(2*v)+exp(u*v)+(u**2)-2*u*v+2*(v**2)-3*u-2*v

def grad(u,v):
    return (e(u+eps,v)-e(u,v))/eps,(e(u,v+eps)-e(u,v))/eps


ev = (0,0)
r = 0.01

print 'e0=',e(ev[0],ev[1])
for i in range(5):
    g = grad(ev[0],ev[1])
    print g
    ev = (ev[0]-r*g[0],ev[1]-r*g[1])
    
print e(ev[0],ev[1])