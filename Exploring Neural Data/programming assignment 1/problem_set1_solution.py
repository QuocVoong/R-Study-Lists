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
        APTime - all the times where a spike (action potential) was detected
    """
 
    APTimes = []
       
    #Let's make sure the input looks at least reasonable
    if (len(voltage) != len(time)):
        print "Can't run - the vectors aren't the same length!"
        return APTimes
    
    # Voltage that the signal must cross to indicate a spike occurred
    threshold = -80
    
    # find all the indices whose corresponding voltage is lower than the threshold
    crossThreshold = np.logical_and(voltage[:-1] >= threshold,
                                    voltage[1:] < threshold)
    
    # find the times (in sec) based on the places where the signal crossed the threshold
    APTimes = time[crossThreshold]
    
    return APTimes
    
def good_AP_finder2(time,voltage):
    """
    This function takes the following input:
        time - vector where each element is a time in seconds
        voltage - vector where each element is a voltage at a different time
        
        We are assuming thaht he two vectors are in correspondance (meaning
        that at a given index, the time in one corresponds to the voltage in
        the other). The vectors must be the same size or the code
        won't run
    
    This function returns the following output:
        APTime - all the times where a spike (action potential) was detected
    """
    
    #Let's make sure the input looks at least reasonable
    if (len(voltage) != len(time)):
        print "Can't run - the vectors aren't the same length!"
        APTime = []
        return APTime
     
    
    # Pick a threshold. You can eyeball it by looking at the plot, or you can 
    # write code to find it.  Code would be better, but isn't 100% necessary.
    thrd = -80
    
    # find all the indices whose corresponding voltage is lower than the threshold
    detectedAPIndex = plt.find(voltage < thrd)
    # note that now several neighboring indices could correspond to the same spike
    
    
    # we only want the first index for one spike
    # so we will throw away several frames following the first one
    
    # calculate difference of the picked neiboring indices
    diff_detectedAPIndex= plt.diff(detectedAPIndex)
    
    # if diff_detectedAPIndex>1, we know that it's a new spike
    # note that diff omits the first element, which is a spike, so I insert the first one
    detectedAPIndex_select = np.insert(diff_detectedAPIndex>1, 0, True)
    # detectedAPIndex_select is a boolean array with the same length of detectedAPIndex
    
    # we selecte the indices that correspond to the begginning frame of each spikes
    detectedAPIndex = detectedAPIndex[detectedAPIndex_select]
    
    # find the time im ms based on the indices
    APTime =list(time[i] for i in detectedAPIndex)
    
    return APTime
    
def good_AP_finder3(time,voltage):
    """
    This function takes the following input:
        time - vector where each element is a time in seconds
        voltage - vector where each element is a voltage at a different time
        
        We are assuming that the two vectors are in correspondance (meaning
        that at a given index, the time in one corresponds to the voltage in
        the other). The vectors must be the same size or the code
        won't run
    
    This function returns the following output:
        APTime - all the times where a spike (action potential) was detected
    """
 
    APTimes = []
       
    #Let's make sure the input looks at least reasonable
    if (len(voltage) != len(time)):
        print "Can't run - the vectors aren't the same length!"
        return APTimes
    
    # Voltage that the signal must cross to indicate a spike occurred
    threshold = -80
    
    # find all the indices whose corresponding voltage is lower than the threshold
    for i in np.arange(1,len(voltage)):
        if voltage[i-1] >= threshold and voltage[i] < threshold:
            APTimes.append(time[i])
    
    # find the times (in sec) based on the places where the signal crossed the threshold
    APTimes = np.array(APTimes)
    
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
    plt.plot(time,voltage,hold=True)
    p = np.ones(len(APTimes))
    p = p*max(voltage)+25
    plt.plot(APTime,p,'|r',hold=True)
    plt.xlabel('Time (s)')
    plt.ylabel('Voltage (uV)')
    plt.title(titlestr)
    plt.show()
    
def plot_waveforms(time,voltage,APTimes,titlestr):
    """
    plot_waveforms takes four arguments - the recording time array, the voltage
    array, the time of the detected action potentials, and the title of your
    plot.  The function creates a labeled plot showing the waveforms for each
    detected action potential
    """
    # calculate sample rate (frames per ms)

    sample_rate = float(len(time)-1)/(1000*(time[-1]-time[0]))
    plt.figure()
    # cycle for each detected spike
    
    for i in range(0, len(APTime)): 
        # find the index for the i-th detected spike time in the time, 
        # using plt.find
        idx_spike = plt.find(time == APTime[i])
        #please note that the use of "==" as an condition could be dangerous,
        #since it requires that the the detectedSpikeTimesMS[i] to be exact the same with one element in the timesMS, """
        #to avoild this, we can instead use  
        idx_spike = min(plt.find(abs(time - APTime[i])<0.00001))
        #to allow 0.01ms jittering
        #I use min() here in case it returns several indices
               
        # find the start and end index for plotting
        idx_start = idx_spike - int(3*sample_rate)
        idx_end   = idx_spike + int(3*sample_rate)

     
        #remeber that sample_rate may not be an interger, 
        #so we have to use int() to convert it into an interger
        
        #note if the index could potentially be negative or bigger
        #than the length of the array at this point, an error will occur
        #we have to make sure that this does not happen 
        if (idx_start>=0) & (idx_end < len(time)-1):
            # plot the waveform for the i-th spike
            xx = np.linspace(-3,3,sample_rate*6)
            yy = voltage[range(idx_start, idx_end)]
            plt.plot(xx, yy, 'b',hold=True,)
    
    # add axis labels and title
    plt.xlabel('Time (ms)')
    plt.ylabel('Voltage (uV)')  
    plt.title(titlestr)
    plt.show()
    

        
##########################
#You can put the code that calls the above functions down here    
if __name__ == "__main__":
    t,v = load_data('spikes_example.npy')    
    actualTimes = get_actual_times('spikes_example_answers.npy')
    APTime = good_AP_finder(t,v)
    plot_spikes(t,v,APTime,'Action Potentials - Example ')
    plot_waveforms(t,v,APTime,'Waveforms - Example')
    detector_tester(APTime,actualTimes)


