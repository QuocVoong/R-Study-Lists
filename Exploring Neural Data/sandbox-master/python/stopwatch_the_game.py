# "Stopwatch: The Game" by Nikolay Grishchenko
# Feedback is welcome in peer assesment or by email
# learning@grischenko.ru

import simpleguitk as sg

# I DID NOT EXACTLY FOLLOW INSTRUCTIONS!
# This seems crazy to save time as tenths of seconds!
# The "true way" is to save value in milliseconds (ms)
# and process/format it correctly as required.
t_value = 0

# Initialize other global variables
score = '' 	# Empty not to be diplayed before game starts
attempts = 0 # Attempts to stop watch
success = 0	# Successful attempts to stop on whole second

# Logic and formatting functions.
def format(t):
    """ Formats given time (ms) to string: 'M:SS.ts' """
    # We assume that nobody plays this game more than 
    # 1 hour. Not even Joe. Hours will not be displayed.
    mins = str(t / 60000)
    
    # Seconds
    if t % 60000 == 0 or t < 1000:
        secs = '00'
    else:
        secs = str((t % 60000) / 1000) if (t % 60000) >= 10000 \
                else '0' + str((t % 60000) / 1000)
    
    # Tenths of seconds
    tsecs = '0' if (t % 1000) == 0 \
            else str((t % 1000) / 100)
    
    return mins + ':' + secs + '.' + tsecs   

def new_game():
    """ Resets all settings to start a new game """
    global attempts, success, t_value
    attempts, success, t_value = 0, 0, 0
    update_score()
    
def update_score():
    """ Formats score to be displayed """
    global score 
    score = str(success) + '/' + str(attempts)

def process():
    """ Checks if attempt was successful """
    global attempts, success
    
    attempts += 1
    if t_value % 1000 == 0:
        success += 1
    
    update_score()    

# Event handlers for buttons: "Start", "Stop", "Reset"
def start():
    global sw # We declare timer "sw" (for StopWatch) later
    sw.start()

def stop():
    global sw
    # Result processing is called only if timer was running
    if sw.is_running():
        sw.stop()
        process()
    
def reset():
    global sw
    sw.stop()
    new_game() # Reset all settings
    
# Event handler for timer
def update():
    global t_value
    t_value += 100 # 100 ms = 0.1 s

# Draw handler
def draw(canvas):
    canvas.draw_text(format(t_value), (80, 110), 24, 'white')
    canvas.draw_text(score, (160, 40), 24, 'green')
    
# Create main objects (frame and timer)
f = sg.create_frame("Strange stopwatch", 200, 200)
sw = sg.create_timer(100, update)

# Register event handlers
f.add_button('Start', start, 120)
f.add_button('Stop', stop, 120)
f.add_button('Reset', reset, 120)
f.set_draw_handler(draw)


# Start frame and initialize game
f.start()
new_game()
