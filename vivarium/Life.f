\ ****** LIFE  in  FORTH  by  MERVYN@xs4all.nl *******
--> Extended.f
variable FIELD 2600 allot  variable FIELD2 2600 allot  
variable PLACE variable PL variable X variable Y  create "TITLE" ," Life"  
: COPYFIELDS  2600 0 Do  I FIELD2 + @  I FIELD + !  2 +Loop ;
: SETUP Begin  2480 80 Do  80 0 Do   
	I J + FIELD2 + @  1 = if I 5 * J 80 - 6 / !PEN ." *" then 
	2 +Loop  80 +Loop  key 
	dup 28 = if PLACE @ 2 - PLACE ! then
	dup 29 = if PLACE @ 2 + PLACE ! then
	dup 30 = if PLACE @ 80 - PLACE ! then
	dup 31 = if PLACE @ 80 + PLACE ! then
	dup 32 = if  1 FIELD2 PLACE @ + !  then
	       13 = Until ;
: INIT  FIELD2 2600 0 fill  COPYFIELDS 1400 PLACE !  
	BLACK bcolor WHITE fcolor 500 310 wsize  "TITLE" wtitle page 
	CR CR 
	."       LIFE by Mervyn@xs4all.nl (programmed in Forth)" CR CR
	."       LIFE calculates new board populations using these rules:" CR
	."       -3 neighbours? -> Birth " CR
	."       -Less than 2 or more than 3 neighbours? -> Death" CR CR
	."       Press any key to toggle between <Field setup> and <Life>" CR
	."       (Use space/arrow keys to create a field)  " 
	key drop page SETUP ; 
: MAINLOOP  2480 80 Do  80 0 Do  I J + FIELD + PL !	
	PL @ 2 + @ 		PL @ 2 - @	
	PL @ 78 + @		PL @ 78 - @ 
	PL @ 80 + @		PL @ 80 - @ 	
	PL @ 82 + @		PL @ 82 - @	
	+ + + + + + +  PL @ @ 
	0 = if 3 = if 1 I J + FIELD2 + !  I 5 * J 80 - 6 / !PEN ." *" then else
	dup 2 < if 0 I J + FIELD2 + ! I 5 * J 80 - 6 / !PEN ."  " drop else 
	       3 > if 0 I J + FIELD2 + ! I 5 * J 80 - 6 / !PEN ."  " then then then
	2 +Loop  80 +Loop ?TERMINAL if SETUP then ;
: LIFE INIT Begin  COPYFIELDS  MAINLOOP Again ; 
READY							\ "echo on"
LIFE 							\ "types LIFE to run itself"

