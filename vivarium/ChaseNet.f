\ ****** ChaseNet  in  FORTH *******
--> Extended.f
variable A 300 allot  variable B 300 allot  
variable X 10 allot  variable Y 10 allot  
variable N variable HEAD variable P variable EYE variable DIR
variable SC  variable SC0 variable SCM variable SOM variable MAX
variable SP variable T variable GEN  create "TITLE" ," ChaseNet" 
: INIT randomize 44 N !  1 HEAD !  0 P !  0 SC !  0 SCM ! 0 T ! 0 SP ! 0 SC0 !
	1 X ! 1 Y ! 12 2 Do 5 X I + ! 5 Y I + ! 2 +Loop 0 GEN ! 0 MAX !
	250 200 Do 10 A I + !  10 B I + !	2 +Loop 
	200 0 do 0 A I + !  2 +Loop 
	BLACK bcolor WHITE fcolor 500 300 wsize "TITLE" wtitle page
	." ChaseNet " CR CR
	." ChaseNet demonstrates how a neural net can be used to solve" CR
	." a problem. This Neural Net is trained by means of 'hill climbing'."  CR
	." The factors are randomly changed and stored when they break" CR
	." the 'HiScore'. If not, then the last Net will be restored." CR
	." The Net is linked to a virtual robot with 4 eyes and two wheels." CR
	." The top of the net is the input: 4 eyes and one channel that" CR
	." is activated when no eye is activated. The 'eyes' can only " CR
	." indicate if an object is present in that direction or not. " CR
	." So the input indicators are: front right behind left nothing" CR
	." The output is the two wheels. " CR
	." The robot is shown as a digit that indicates its direction:" CR
	." 1) north 2) east 3) south 4) west" CR
	." The robot 'scores' each step its drives over the screen." CR
	." This score resets however when it reaches an edge of the screen!" CR  
	." As a result the robot will chase the only object (O) it can see" CR
	." and thereby have a better score than just the ten steps from" CR
	." one side of the screen to the other!" CR
	." (the object jumps away when it is noticed by the robot!) " CR
	." Note that it is a strange criterium to solve the" CR
	." problem: let the robot chase the object..." key drop page  
	130 0 !pen 130 115 -to 0 115 -to ;
: INPUT 12 0 do 0 A I + !  2 +Loop 
	0 DIR !
	Y @  Y 2 + @ < if X @ X 2 + @ = if 1 DIR ! then else
	Y @  Y 2 + @ > if X @ X 2 + @ = if 3 DIR ! then else
	X @  X 2 + @ < if Y @ Y 2 + @ = if 4 DIR ! then else
	X @  X 2 + @ > if Y @ Y 2 + @ = if 2 DIR ! then then then then then
	DIR @ 0 > if 
		DIR @ HEAD @ 1 - - dup EYE ! 1 < if 4 EYE +! then
		1 A EYE @ 2 * + !   else 1 A 10 + ! then
	X 2 + @  X 4 + !	Y 2 + @  Y 4 + ! ;
: THINK
	A 2 + @  202 A + @ *  
	A 4 + @  204 A + @ * + 
	A 6 + @  206 A + @ * +
	A 8 + @  208 A + @ * +  
	A 10 + @  210 A + @ * + 
	10 > if 1 A 20 + ! else 0 A 20 + ! then 
	A 2 + @  212 A + @ *  
	A 4 + @  214 A + @ * + 
	A 6 + @  216 A + @ * +
	A 8 + @  218 A + @ * +  
	A 10 + @  220 A + @ * + 
	10 > if 1 A 22 + ! else 0 A 22 + ! then 
	A 2 + @  222 A + @ *  
	A 4 + @  224 A + @ * + 
	A 6 + @  226 A + @ * +
	A 8 + @  228 A + @ * +  
	A 10 + @  230 A + @ * + 
	10 > if 1 A 24 + ! else 0 A 24 + ! then 
	A 20 + @  232 A + @ *  
	A 22 + @  234 A + @ * + 
	A 24 + @  236 A + @ * +
	10 > if 1 A 26 + ! else 0 A 26 + ! then 
	A 20 + @  238 A + @ *  
	A 22 + @  240 A + @ * + 
	A 24 + @  242 A + @ * +
	10 > if 1 A 28 + ! else 0 A 28 + ! then ;
: OUTPUT	
		A 26 + @ A 28 + @ + 2 = 				if HEAD @ 
		dup 1 = if -1 Y 2 + +! 1 SC +! drop else			
		dup 2 = if 1 X 2 + +! 1 SC +! drop else
		dup 3 = if 1 Y 2 + +! 1 SC +! drop else
		       4 = if -1 X 2 + +! 1 SC +! then then then then  	
		X 2 + @ dup 1 < if 10 X 2 + ! 50 T ! drop else
			     	10 > if 1 X 2 + ! 50 T !  else
		Y 2 + @ dup 1 < if 10 Y 2 + ! 50 T !  drop else
				10 > if 1 Y 2 + ! 50 T !  then then then then 
										else
		A 26 + @ 1 = if 1 HEAD +! then
		A 28 + @ 1 = if -1 HEAD +! then
		HEAD @ dup 1 < if 4 HEAD +! drop else 
				   4 > if -4 HEAD +! then then 	then ;
: VIEWNET 
	10 0 Do 150 220 !PEN 50 I 50 * + 150 -TO  A 202 + I + @ .  2 +Loop
	10 0 Do 250 220 !PEN 50 I 50 * + 162 -TO  A 212 + I + @ .  2 +Loop
	10 0 Do 350 220 !PEN 50 I 50 * + 174 -TO  A 222 + I + @ .  2 +Loop
	6 0 Do 200 270 !PEN 150 I 50 * + 220 -TO  A 232 + I + @ .  2 +Loop
	6 0 Do 300 270 !PEN 150 I 50 * + 232 -TO  A 238 + I + @ .  2 +Loop ;
: JUMPAWAY 3 random 1 - X +!  3 random 1 - Y +!
	X @ dup 1 < if 10 X ! drop else
		   10 > if 1 X ! then then
	Y @ dup 1 < if 10 Y ! drop else
		   10 > if 1 Y ! then then ;
: MUT  3 0 do 5 random 8 +  A 200 + 25 random 2 * + ! loop VIEWNET ;
: EVAL 
	T @ 5 = if SC @ 0= if 50 T ! then then
	DIR @ 0> if JUMPAWAY then
	1 T +!  T @ 50 > if  0 T !  ?BUTTON if QUIT then 
		200 80 !PEN
		SC @ SCM @ 1 - > if  ." Store            " 
			SC @ MAX @ > if SC @ MAX ! then
			SC @ SCM ! 250 200 Do A I + @  B I + !  2 +Loop  else
		SC @ SCM @ < if ." Restore      " SC @ 11 < if -1 SCM +! then
			250 200 Do B I + @  A I + !  2 +Loop  
			then else MUT then
		1 GEN +! 200 GEN @ + 60 SC0 @ - !PEN 201 GEN @ + 60 SC @ - -TO 
		GEN @ 300 = if 0 GEN ! page 
			130 0 !pen 130 115 -to 0 115 -to then
		SC @ SC0 !  0 SC ! then ;
: VIEW  
	12 2 do 50 I 2 - * 50 + 136 !PEN A I + @ .   2 +Loop 	
	150 208 !pen A 20 + @ . 250 208 !pen A 22 + @ .
	350 208 !pen A 24 + @ . 					
	200 282 !pen A 26 + @ . 300 282 !pen A 28 + @ . 	
	X 8 + @ 11 *  Y 8 + @ 11 * !PEN ."   "	
	X @ 11 *  Y @ 11 * !PEN ."  O"
	X 6 + @ 11 *  Y 6 + @ 11 * !PEN ."   "
	X 2 + @ 11 *  Y 2 + @ 11 * !PEN HEAD @ . ."  "
	200 94 !PEN ." Score: " SC0 @ . ."   (max: " MAX @ .  ." out of 50)  "
	X 2 + @  X 6 + !   Y 2 + @  Y 6 + !
	X @  X 8 + !   Y @  Y 8 + ! ; 
: CHASENET INIT Begin INPUT THINK OUTPUT EVAL VIEW Again ;
READY							\ "echo on"
CHASENET 						\ "types CHASENET to run itself"

