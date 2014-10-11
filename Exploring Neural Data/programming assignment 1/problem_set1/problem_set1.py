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
 
    # Constants
    peak_voltage = max(voltage) if abs(max(voltage)) > abs(min(voltage)) else min(voltage)
#    THRESHOLD = abs(get_absolute_peak(voltage)) / 2.0
    THRESHOLD = abs(peak_voltage) / 2.0
    SAMPLING_RATE = time[1]-time[0]  
    AP_SLOPE = np.std(voltage) * 2 
    SPREAD = int(.0008 / SAMPLING_RATE) # number of samples in 1 ms
    
    # Data stores
    APTimes = []
    AP_set = set()

    # for seeing steep changes in voltage
    voltage_delta = np.diff(voltage)     
       
    #Let's make sure the input looks at least reasonable
    if (len(voltage) != len(time)):
        print "Can't run - the vectors aren't the same length!"
        return APTimes
        
#    def find_local_peak(index):
#        """
#        Return local peak (either a spike or valley) index. 
#        (Local is within a .002s spread)
#        """
#        sample = voltage[index-SPREAD:index+SPREAD+1]
#        # now find the biggest spike (neg or positive)
#        local_peak = get_absolute_peak(sample)
#        
#        # note: sorting idea came from http://stackoverflow.com/a/12141207
#        peak_index = min(plt.find(voltage==local_peak), key=lambda x:abs(x-index))
#        return peak_index

    # Use steep slopes to find local peaks and valleys
    for i, v in enumerate(voltage_delta):
        # Check for a string of slopes above threshold
        if abs(v) > AP_SLOPE and abs(voltage_delta[i+1]) > AP_SLOPE and abs(voltage_delta[i+2]) > AP_SLOPE:
            # find local max near the second one 
            # b/c it's more likely to be closer to the peak
#            local_peak = find_local_peak(i+2)
            # testing removal of inner fcn
            i2 = i+2
            sample = voltage[i2-SPREAD:i2+SPREAD+1]
            local_peak = max(sample) if abs(max(sample)) > abs(min(sample)) else min(sample)
            # note: sorting idea came from http://stackoverflow.com/a/12141207
            local_peak = min(plt.find(voltage==local_peak), key=lambda x:abs(x-i2))

            if abs(voltage[local_peak]) > THRESHOLD:
                # set prevents duplicates
                AP_set.add(time[local_peak])
                
    APTimes = list(AP_set)
    
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
    plt.figure()
    
    ##Your Code Here 
    
    plt.figure()
    plt.title(titlestr)
    plt.xlabel("Time (s)")
    plt.ylabel("Voltage (uV)") 

    plt.plot(time, voltage)
    
    for i in APTimes:
        plt.axvline(x=i, ymin=0.93, ymax=0.96, color='red')
    
    plt.show()
    
def plot_waveforms(time,voltage,APTimes,titlestr):
    """
    plot_waveforms takes four arguments - the recording time array, the voltage
    array, the time of the detected action potentials, and the title of your
    plot.  The function creates a labeled plot showing the waveforms for each
    detected action potential
    """
   
    ## Your Code Here 
   
    plt.figure()
    plt.title(titlestr)
    plt.xlabel("Time (s)")
    plt.ylabel("Voltage (uV)") 
    
    for apt in APTimes:
        index_list = [i for i in range(len(time)) if time[i] >= apt+0.00025 -3e-3 and time[i]<= apt+0.00025 +3e-3]
#        w=len(index_list)/12
#        index_list = [i for i in range(len(time)) if time[i] >= apt +w -3e-3 and time[i]<= apt +w +3e-3]
        x=np.linspace(-0.003,0.003,len(index_list))
        plt.plot(x,voltage[index_list],hold=True)
    
    plt.show()
    

        
##########################
#You can put the code that calls the above functions down here    
if __name__ == "__main__":
    t1, v1 = load_data('spikes_hard_test.npy')
    APTimes1 = good_AP_finder(t1, v1)
    
    plot_spikes(t1, v1, APTimes1, 'Spikes for easy datasets')
    plot_waveforms(t1, v1, APTimes1, 'Waveforms')
