   scenario = "consis";  

default_font_size = 48;
default_picture_duration = 8000;
randomize_trials = true; 
active_buttons = 2;
button_codes = 111,112;
response_matching = simple_matching;
target_button_codes = 100,200;   
write_codes = true;
pulse_width = 20; # if parallel port


begin; 

box { height = 5; width = 30; color = 255,255,255; } box1;
box { height = 30; width = 5; color = 255,255,255; } box2;

picture {box box1; x = 0; y = 0; box box2; x = 0; y = 0;} default;
 
bitmap { filename = "in-phase.bmp"; } in;


$d=4000;  
$a=4000;

LOOP $i 60; 
         
trial {
   picture {
      bitmap in;
      x=0;y=0;
   }; 
   time= $d;
    duration = $a;       
    code = "in";
      port_code = 1;  
};          




ENDLOOP ;