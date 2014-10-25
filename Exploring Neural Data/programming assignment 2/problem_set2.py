#
#  NAME
#    problem_set2_solutions.py
#
#  DESCRIPTION
#    Open, view, and analyze action potentials recorded during a behavioral
#    task.  In Problem Set 2, you will write create and test your own code to
#    create tuning curves.
#

#Helper code to import some functions we will use
import numpy as np
import matplotlib.pylab as plt
import matplotlib.mlab as mlab
from scipy import optimize
from scipy import stats


def load_experiment(filename):
    """
    load_experiment takes the file name and reads in the data.  It returns a
    two-dimensional array, with the first column containing the direction of
    motion for the trial, and the second column giving you the time the
    animal began movement during thaht trial.
    """
    data = np.load(filename)[()];
    return np.array(data)

def load_neuraldata(filename):
    """
    load_neuraldata takes the file name and reads in the data for that neuron.
    It returns an arary of spike times.
    """
    data = np.load(filename)[()];
    return np.array(data)
    
def bin_spikes(trials, spk_times, time_bin):
    """
    bin_spikes takes the trials array (with directions and times) and the spk_times
    array with spike times and returns the average firing rate for each of the
    eight directions of motion, as calculated within a time_bin before and after
    the trial time (time_bin should be given in seconds).  For example,
    time_bin = .1 will count the spikes from 100ms before to 100ms after the 
    trial began.
    
    dir_rates should be an 8x2 array with the first column containing the directions
    (in degrees from 0-360) and the second column containing the average firing rate
    for each direction
    """
    
    #indicates all direction of the trials
    column0 = np.arange(0,360,45)
    #to store spikes_per_trials
    column1 = np.zeros(8)
    #to store trials numbers
    column2 = np.zeros(8)
    #combine two columns
    dir_rates = np.column_stack((column0, column1))
    
    #Count the number of spikes per trial
    for i in range(0, len(trials)):
        trials_dir = trials[i,0]
        low_bound_time = trials[i,1] - time_bin
        high_bound_time = trials[i,1] + time_bin
        spikes_per_trials = 0
        
        # check all spike times to see if they are in the time window
        for j in range(0, len(spk_times)):
            if (low_bound_time <= spk_times[j] <= high_bound_time):
                spikes_per_trials += 1
#                print spikes_per_trials
                
        #add the spike number by dir
        for k in range(0,8):
            if (dir_rates[k,0] == trials_dir):
                dir_rates[k,1] += spikes_per_trials
                column2[k] += 1
    
    #calculate means by dir
    for i in range(0,8):
        dir_rates[i,1] = dir_rates[i,1] / column2[i]
    
    return dir_rates
    
def plot_tuning_curves(direction_rates, title):
    """
    This function takes the x-values and the y-values  in units of spikes/s 
    (found in the two columns of direction_rates) and plots a histogram and 
    polar representation of the tuning curve. It adds the given title.
    """
    
    #plot histogram
    plt.subplot(2,2,1)
    #to set width turns bars into histograms
    plt.bar(direction_rates[:,0],direction_rates[:,1],width=45,align='center')
    plt.axis([-22.5,337.5,0,8])
    plt.xlabel('Direction of Motion (degrees)')
    plt.ylabel('Firing Rate (spike/s)')
    plt.title(title)
    plt.xticks(direction_rates[:,0])

    col0 = direction_rates[:,0]*np.pi/180
    col1 = direction_rates[:,1]
    #add space to store the first dir
    col0 = np.append(col0,direction_rates[0,0])
    #add space to store the first mean
    col1 = np.append(col1,direction_rates[0,1])
    #update the direction_rates
    direction_rates = np.column_stack((col0, col1))
    
    #plot polar plot
    plt.subplot(2,2,2,polar=True)
    plt.polar(direction_rates[:,0],direction_rates[:,1],label='Firing Rate (spikes/s)')
    plt.legend(loc=8)
    plt.title(title)
    
def roll_axes(direction_rates):
    """
    roll_axes takes the x-values (directions) and y-values (direction_rates)
    and return new x and y values that have been "rolled" to put the maximum
    direction_rate in the center of the curve. The first and last y-value in the
    returned list should be set to be the same. (See problem set directions)
    Hint: Use np.roll()
    """
    
    #create new x-axis
    new_xs = np.arange(-90,280,45)
    
    #store the original y-value
    col1 = direction_rates[:,1]
    col1 = np.roll(col1,2)
    col1 = np.append(col1,col1[0])
    new_ys = col1
    
    #calculate roll degrees
    roll_degrees = 90
    
    return new_xs, new_ys, roll_degrees    
    

def normal_fit(x,mu, sigma, A):
    """
    This creates a normal curve over the values in x with mean mu and
    variance sigma.  It is scaled up to height A.
    """
    n = A*mlab.normpdf(x,mu,sigma)
    return n

def fit_tuning_curve(centered_x,centered_y):
    """
    This takes our rolled curve, generates the guesses for the fit function,
    and runs the fit.  It returns the parameters to generate the curve.
    """

    #parameters to calculate p
    max_y = np.amax(centered_y)
    max_x = centered_x[np.argmax(centered_y)]
    sigma = 90
    
    #p is the parameter to fit our points with a curve
    p, cov = optimize.curve_fit(normal_fit,centered_x, centered_y, p0=[max_x, sigma, max_y])

    return p
    


def plot_fits(direction_rates,fit_curve,title):
    """
    This function takes the x-values and the y-values  in units of spikes/s 
    (found in the two columns of direction_rates and fit_curve) and plots the 
    actual values with circles, and the curves as lines in both linear and 
    polar plots.
    """
    
    new_xs,new_ys,deg = roll_axes(direction_rates)
    
    #generate the fit_ys
    curve_xs = np.arange(new_xs[0],new_xs[-1])
    fit_ys = normal_fit(curve_xs,fit_curve[0],fit_curve[1],fit_curve[2])
	
	#roll the x and y axis
	length = len(curve_xs)
	curve_xs = np.roll(curve_xs,deg)
	fit_ys = np.roll(fit_ys,deg)
    
    plt.subplot(2,2,3)
    plt.plot(direction_rates[:,0],direction_rates[:,1],'o')
    plt.plot(curve_xs,fit_ys,'-')
    
	plt.xlabel('Direction of Motion (degrees)')
    plt.ylabel('Firing Rate (spike/s)')
    plt.title(title)
    plt.xlim(-112.5, 382.5)
    plt.xticks(direction_rates[:,0])
    

def von_mises_fitfunc(x, A, kappa, l, s):
    """
    This creates a scaled Von Mises distrubition.
    """
    return A*stats.vonmises.pdf(x, kappa, loc=l, scale=s)


    
def preferred_direction(fit_curve):
    """
    The function takes a 2-dimensional array with the x-values of the fit curve
    in the first column and the y-values of the fit curve in the second.  
    It returns the preferred direction of the neuron (in degrees).
    """
  
    return pd
    
        
##########################
#You can put the code that calls the above functions down here    
if __name__ == "__main__":
    trials = load_experiment('C:/Users/enddylan/Desktop/programming assignment 2/trials.npy')   
    spk_times = load_neuraldata('C:/Users/enddylan/Desktop/programming assignment 2/example_spikes.npy') 
    rates = bin_spikes(trials,spk_times,0.1)
    
    #plot the rates
    plot_tuning_curves(rates, 'Example Neuron Tuning Curve')
    
    newx,newy,degrees = roll_axes(rates)
    p = fit_tuning_curve(newx,newy)
    plot_fits(rates,p,'Example Neuron Tuning Curve')