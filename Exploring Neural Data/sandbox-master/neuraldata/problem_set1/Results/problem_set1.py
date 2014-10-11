#
#  NAME
#    problem_set1.py
#
#  DESCRIPTION
#    Open, view, and analyze raw extracellular data
#    In Problem Set 1, you will write create and test your own spike detector.
#

import numpy as np
import matplotlib.pylab as plt

def load_data(filename):
    """
    load_data takes the file name and reads in the data.  It returns two 
    arrays of data, the first containing the time stamps for when they data
    were recorded (in units of seconds), and the second containing the 
    corresponding voltages recorded (in units of microvolts - uV)
    """
    data = np.load(filename)[()];
    return np.array(data['time']), np.array(data['voltage'])
    
def bad_AP_finder(time,voltage):
    """
    This function takes the following input:
        time - vector where each element is a time in seconds
        voltage - vector where each element is a voltage at a different time
        
        We are assuming that the two vectors are in correspondance (meaning
        that at a given index, the time in one corresponds to the voltage in
        the other). The vectors must be the same size or the code
        won't run
    
    This function returns the following output:
        APTimes - all the times where a spike (action potential) was detected
         
    This function is bad at detecting spikes!!! 
        But it's formated to get you started!
    """
    
    #Let's make sure the input looks at least reasonable
    if (len(voltage) != len(time)):
        print "Can't run - the vectors aren't the same length!"
        APTimes = []
        return APTimes
    
    numAPs = np.random.randint(0,len(time))//10000 #and this is why it's bad!!
 
    # Now just pick 'numAPs' random indices between 0 and len(time)
    APindices = np.random.randint(0,len(time),numAPs)
    
    # By indexing the time array with these indices, we select those times
    APTimes = time[APindices]
    
    # Sort the times
    APTimes = np.sort(APTimes)
    
    return APTimes
    
def good_AP_finder(time,voltage):
    """
    This function takes the following input:
        time - vector where each element is a time in seconds
        voltage - vector where each element is a voltage at a different time
        
        We are assuming that the two vectors are in correspondance (meaning
        that at a given index, the time in one corresponds to the voltage in
        the other). The vectors must be the same size or the code
        won't run
    
    This function returns the following output:
        APTimes - all the times where a spike (action potential) was detected
    """
 
    APTimes = []
       
    #Let's make sure the input looks at least reasonable
    if (len(voltage) != len(time)):
        print "Can't run - the vectors aren't the same length!"
        return APTimes
    
    ##Your Code Here!
# Standrd deviation represents passive neuron mode (noise)
    standard_deviation = np.std(voltage)
# Buffer is used to filter possible occasional false mini-spikes
    spike_detector_buffer = 25

# We need to get only the beginning of the spike.
# The flag is used to pause spike detection untill we get a negative value 
# This represents hyperpolarization of the refractory period.
    found_spike_flag = False

# We start looking for spikes in the given inputs
    for i, v in enumerate(voltage):
        if v > standard_deviation + spike_detector_buffer and not found_spike_flag:
# Once found we set pause flag True
            found_spike_flag = True
            APTimes.append(time[i])
# Once found negative voltage (most likely hyperpolyarization) 
# we clear the pause flag and the search continues
        elif v < 0 and found_spike_flag:
            found_spike_flag = False
            
    return APTimes
    

def get_actual_times(dataset):
    """
    Load answers from dataset
    This function takes the following input:
        dataset - name of the dataset to get answers for

    This function returns the following output:
        APTimes - spike times
    """    
    return np.load(dataset)
    
def detector_tester(APTimes, actualTimes):
    """
    returns percentTrueSpikes (% correct detected) and falseSpikeRate
    (extra APs per second of data)
    compares actual spikes times with detected spike times
    This only works if we give you the answers!
    """
    
    JITTER = 0.025 #2 ms of jitter allowed
    
    #first match the two sets of spike times. Anything within JITTER_MS
    #is considered a match (but only one per time frame!)
    
    #order the lists
    detected = np.sort(APTimes)
    actual = np.sort(actualTimes)
    
    #remove spikes with the same times (these are false APs)
    temp = np.append(detected, -1)
    detected = detected[plt.find(plt.diff(temp) != 0)]
 
    #find matching action potentials and mark as matched (trueDetects)
    trueDetects = [];
    for sp in actual:
        z = plt.find((detected >= sp-JITTER) & (detected <= sp+JITTER))
        if len(z)>0:
            for i in z:
                zz = plt.find(trueDetects == detected[i])
                if len(zz) == 0:
                    trueDetects = np.append(trueDetects, detected[i])
                    break;
    percentTrueSpikes = 100.0*len(trueDetects)/len(actualTimes)
    
    #everything else is a false alarm
    totalTime = (actual[len(actual)-1]-actual[0])
    falseSpikeRate = (len(APTimes) - len(actualTimes))/totalTime
    
    print 'Action Potential Detector Performance performance: '
    print '     Correct number of action potentials = ' + str(len(actualTimes))
    print '     Percent True Spikes = ' + str(percentTrueSpikes)
    print '     False Spike Rate = ' + str(falseSpikeRate) + ' spikes/s'
    print 
    return {'Percent True Spikes':percentTrueSpikes, 'False Spike Rate':falseSpikeRate}
    
    
def plot_spikes(time,voltage,APTimes,titlestr):
    """
    plot_spikes takes four arguments - the recording time array, the voltage
    array, the time of the detected action potentials, and the title of your
    plot.  The function creates a labeled plot showing the raw voltage signal
    and indicating the location of detected spikes with red tick marks (|)
    """
# Make a plot and markup
    plt.figure()
    plt.title(titlestr)
    plt.xlabel("Time (s)")
    plt.ylabel("Voltage (uV)") 

    plt.plot(time, voltage)
    
# Vertical positions for red marker
# The following attributes are configurable if required    
    vertical_markers_indent = 0.01 # 1% of Voltage scale height
    vertical_markers_height = 0.03 # 5% of Voltage scale height
    y_scale_height = 400 # Max of scale
    
    marker_ymin = 0.5 + ( max(voltage) / y_scale_height / 2 ) + vertical_markers_indent
    marker_ymax = marker_ymin + vertical_markers_height

# Drawing red markers for detected spikes
    for spike in APTimes:
        plt.axvline(spike, ymin=marker_ymin, ymax=marker_ymax, color='red')
    
    plt.draw()
    
def plot_waveforms(time,voltage,APTimes,titlestr):
    """
    plot_waveforms takes four arguments - the recording time array, the voltage
    array, the time of the detected action potentials, and the title of your
    plot.  The function creates a labeled plot showing the waveforms for each
    detected action potential
    """

# Configurable settings
# Indent before start of spike
    indent_before_spike = 30 # measured in records
# Length of spike period drawing
    period_after_start_of_spike = 90 # measured in records
   
# Make a plot and markup
    plt.figure()
    plt.title(titlestr)
    plt.xlabel("Time (s)")
    plt.ylabel("Voltage (uV)") 

# Initialize new plot datasets. They would become two-dimensional (2 layers).
    wave_time = []
    wave_v = []

    print len(voltage)
# Iterate through given dataset to find matches with APTimes (spikes)
# Once found a match, we append new object to the 1-st layer of our datasets
    wave_i = 0 # This is index for our new datasets.
    for i, t in enumerate(time):
        if t in APTimes:
            wave_time.append([]) # Initialized as arrays
            wave_v.append([])

# Now we extract data from indent_before_spike till period_after_start_of_spike
# And push this data to 2-nd layer of our new datasets.
            start_time = time[i-indent_before_spike]
            for j in range(period_after_start_of_spike):
                if not i-indent_before_spike+j >= len(voltage):
                    wave_time[wave_i].append(start_time + (time[j]-start_time))
                    wave_v[wave_i].append(voltage[i-indent_before_spike+j])
            wave_i +=1

# Now we have two two-dimensional datasets we are ready to draw.
    plt.hold() # To draw all the waveform plots on a single figure() object.
    for i in range(len(wave_time)):   
        plt.plot(wave_time[i], wave_v[i], 'b')
    plt.draw()
    

##########################
#You can put the code that calls the above functions down here    
if __name__ == "__main__":

###############
# Example datasets
    t,v = load_data('spikes_easy_practice.npy')
    t, v = load_data('spikes_easy_test.npy')
    APTimes = good_AP_finder(t, v)    
    
    plot_spikes(t, v, APTimes, 'Action Potentials in Raw Signal')
    plot_waveforms(t, v, APTimes, 'Waveforms')

# This is to check detection accuracy
    actualTimes = get_actual_times('spikes_example_answers.npy')
    detector_tester(APTimes, actualTimes)    

###############
# Hard datasets
    t1, v1 = load_data('spikes_hard_practice.npy')
    """
    t1, v1 = load_data('spikes_hard_test.npy')
    APTimes1 = good_AP_finder(t1, v1)
    
    plot_spikes(t1, v1, APTimes1, 'Action Potentials in Raw Signal')
    plot_waveforms(t1, v1, APTimes1, 'Waveforms')
"""
# This is to check detection accuracy
    actualTimes1 = get_actual_times('spikes_hard_practice_answers.npy')
    detector_tester(APTimes1, actualTimes1)    
