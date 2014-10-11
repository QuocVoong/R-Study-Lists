import math

op = []

def fibPlus((a,b),(c,d)):
    bd = b*d
    return (bd-(b-a)*(d-c), a*c+bd)
 
def unFib((a,b),n):
    if n<a:
        return (0,0,1)
    else:
        (k,c,d) = unFib(fibPlus((a,b),(a,b)),n)
        (e,f) = fibPlus((a,b),(c,d))
        if n<e: return (2*k, c, d)
        else:
            return (2*k+1,e,f)
 
def isfib(n):
    (k,a,b) = unFib((1,1),n)
    return n==a

age = 0
opc = 10000
while age < 5000:
    if isfib(age):
        opc -= age
    else:
        opc += 1

    op.insert(age, opc)
    age += 1

def checkio(opacity):
    if op.index(opacity):
        return op.index(opacity)
    else:    
        return False

print checkio(10000) == 0, "Newborn"
print checkio(9999) == 1, "1 year"
print checkio(9997) == 2, "2 years"
print checkio(9994) == 3, "3 years"
print checkio(9995) == 4, "4 years"
print checkio(9990) == 5, "5 years"
