# The program takes 'x' and 'y' coordinates for 3 apexes of a triangle.
# Then computes the length of each side.
# Using these lengths computes the area of a triangle using Heron's formula.

def dist( x0, y0, x1, y1 ):
    """ Compute the distance between the points
    (x0, y0) and (x1, y1). """
    return ( (x0 - x1) ** 2 + (y0 - y1)**2 ) ** 0.5

def heron( coords ):
    """ Compute the area of a triangle with given
    coordinates using Heron's formula. """
    a = dist( coords[0][0], coords[0][1], coords[1][0], coords[1][1] )
    b = dist( coords[1][0], coords[1][1], coords[2][0], coords[2][1] )
    c = dist( coords[2][0], coords[2][1], coords[0][0], coords[0][1] )
    s = 0.5 * ( a + b + c )
    
    A = ( s * (s - a) * (s - b) * (s - c) ) ** 0.5
    return A

# User input of 'x' and 'y' coordinates for 3 apexes
apxs = []
for point in range(3):
    apxs.append([i for i in map(int, raw_input('Enter apex coordinates separated by space:').split())])

print 'The area of given triange is: ', heron(apxs)
