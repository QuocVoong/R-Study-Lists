pcl_file = "practise_YN.pcl";  
scenario = "bitmap picture part example 1";
active_buttons = 2;
button_codes = 111,112;
response_matching = simple_matching;
target_button_codes = 100,200;   
write_codes = true;
pulse_width = 20;
default_background_color = 255, 255, 255;
begin;

picture {} default;

array {  
 
   bitmap { filename = "1.bmp"; preload = false; };
   bitmap { filename = "2.bmp"; preload = false; };
   bitmap { filename = "3.bmp"; preload = false; };
   bitmap { filename = "4.bmp"; preload = false; };
   bitmap { filename = "5.bmp"; preload = false; };
   bitmap { filename = "6.bmp"; preload = false; };
   bitmap { filename = "7.bmp"; preload = false; };
   bitmap { filename = "8.bmp"; preload = false; };
   bitmap { filename = "9.bmp"; preload = false; };
   bitmap { filename = "10.bmp"; preload = false; };
   bitmap { filename = "11.bmp"; preload = false; };
   bitmap { filename = "12.bmp"; preload = false; };
   bitmap { filename = "13.bmp"; preload = false; };
   bitmap { filename = "14.bmp"; preload = false; };
   bitmap { filename = "15.bmp"; preload = false; };
   bitmap { filename = "16.bmp"; preload = false; };
   bitmap { filename = "17.bmp"; preload = false; };
   bitmap { filename = "18.bmp"; preload = false; };
   bitmap { filename = "19.bmp"; preload = false; };
   bitmap { filename = "20.bmp"; preload = false; };
   bitmap { filename = "21.bmp"; preload = false; };
   bitmap { filename = "22.bmp"; preload = false; };
   bitmap { filename = "23.bmp"; preload = false; };
   bitmap { filename = "24.bmp"; preload = false; };
   bitmap { filename = "25.bmp"; preload = false; };
   bitmap { filename = "26.bmp"; preload = false; };
   bitmap { filename = "27.bmp"; preload = false; };
   bitmap { filename = "28.bmp"; preload = false; };
   bitmap { filename = "29.bmp"; preload = false; };
   bitmap { filename = "30.bmp"; preload = false; };
   bitmap { filename = "31.bmp"; preload = false; };
   bitmap { filename = "32.bmp"; preload = false; };
   bitmap { filename = "33.bmp"; preload = false; };
   bitmap { filename = "34.bmp"; preload = false; };
   bitmap { filename = "35.bmp"; preload = false; };
   bitmap { filename = "36.bmp"; preload = false; };
   bitmap { filename = "37.bmp"; preload = false; };
   bitmap { filename = "38.bmp"; preload = false; };
   bitmap { filename = "39.bmp"; preload = false; };
   bitmap { filename = "40.bmp"; preload = false; };
   bitmap { filename = "41.bmp"; preload = false; };
   bitmap { filename = "42.bmp"; preload = false; };
   bitmap { filename = "43.bmp"; preload = false; };
   bitmap { filename = "44.bmp"; preload = false; };
   bitmap { filename = "45.bmp"; preload = false; };
   bitmap { filename = "46.bmp"; preload = false; };
   bitmap { filename = "47.bmp"; preload = false; };
   bitmap { filename = "48.bmp"; preload = false; };
   bitmap { filename = "49.bmp"; preload = false; };
   bitmap { filename = "50.bmp"; preload = false; };
   bitmap { filename = "51.bmp"; preload = false; };
   bitmap { filename = "52.bmp"; preload = false; };
   bitmap { filename = "53.bmp"; preload = false; };
   bitmap { filename = "54.bmp"; preload = false; };
   bitmap { filename = "55.bmp"; preload = false; };
   bitmap { filename = "56.bmp"; preload = false; };
   bitmap { filename = "57.bmp"; preload = false; };
   bitmap { filename = "58.bmp"; preload = false; };
   bitmap { filename = "59.bmp"; preload = false; };
   bitmap { filename = "60.bmp"; preload = false; };
   bitmap { filename = "61.bmp"; preload = false; };
   bitmap { filename = "62.bmp"; preload = false; };
   bitmap { filename = "63.bmp"; preload = false; };
   bitmap { filename = "64.bmp"; preload = false; };
   bitmap { filename = "65.bmp"; preload = false; };
   bitmap { filename = "66.bmp"; preload = false; };
   bitmap { filename = "67.bmp"; preload = false; };
   bitmap { filename = "68.bmp"; preload = false; };
   bitmap { filename = "69.bmp"; preload = false; };
   bitmap { filename = "70.bmp"; preload = false; };
   bitmap { filename = "71.bmp"; preload = false; };
   bitmap { filename = "72.bmp"; preload = false; };
   bitmap { filename = "73.bmp"; preload = false; };
   bitmap { filename = "74.bmp"; preload = false; };
   bitmap { filename = "75.bmp"; preload = false; };
   bitmap { filename = "76.bmp"; preload = false; };
   bitmap { filename = "77.bmp"; preload = false; };
   bitmap { filename = "78.bmp"; preload = false; };
   bitmap { filename = "79.bmp"; preload = false; };
   bitmap { filename = "80.bmp"; preload = false; };
   bitmap { filename = "81.bmp"; preload = false; };
   bitmap { filename = "82.bmp"; preload = false; };
   bitmap { filename = "83.bmp"; preload = false; };
   bitmap { filename = "84.bmp"; preload = false; };
   bitmap { filename = "85.bmp"; preload = false; };
   bitmap { filename = "86.bmp"; preload = false; };
   bitmap { filename = "87.bmp"; preload = false; };
   bitmap { filename = "88.bmp"; preload = false; };
   bitmap { filename = "89.bmp"; preload = false; };
   bitmap { filename = "90.bmp"; preload = false; };
   bitmap { filename = "91.bmp"; preload = false; };
   bitmap { filename = "92.bmp"; preload = false; };
   bitmap { filename = "93.bmp"; preload = false; };
   bitmap { filename = "94.bmp"; preload = false; };
   bitmap { filename = "95.bmp"; preload = false; };
   bitmap { filename = "96.bmp"; preload = false; };
   bitmap { filename = "97.bmp"; preload = false; };
   bitmap { filename = "98.bmp"; preload = false; };
   bitmap { filename = "99.bmp"; preload = false; };
   bitmap { filename = "100.bmp"; preload = false; }; 
   

} graphics;

trial {
   trial_duration = 200;
   
   picture {
      bitmap { filename = "cross.bmp"; };
      x = 0; y = 0;
   };
} instruction_trial;

trial {
   trial_duration = 500;
   
   picture {
      bitmap { filename = "rest.bmp"; };
      x = 0; y = 0;
   };
} resting_trial;

trial {
   
   trial_duration = 1000;
   stimulus_event {    
      
   picture { 
         box { height = 1; width = 1; color = 0,0,0; };
      x = 0; y = 0;
   } pic1;
      } event1;
} trial1;