\ ****** Afarm  in  FORTH  by  MERVYN@xs4all.nl *******
--> Extended.f
variable AT 1000 allot  variable EN 1000 allot  variable DE 1000 allot
variable SP 1000 allot  variable REP 1000 allot
variable SUN variable RISK variable PL variable GEN
variable NPL variable FA variable FA0 variable FL variable FL0
create "TITLE" ," Animal Farm"
: INIT  BLACK bcolor WHITE fcolor  600 370 wsize  "TITLE" wtitle  page
	EN 1000 0 fill  DE 1000 0 fill  AT 1000 0 fill  SP 1000 0 fill
	REP 1000 0 fill randomize 0 GEN ! 0 FL ! 0 FA ! 2 EN 90 + ! 3 REP 90 + !
	." Animal Farm  by  Mervyn@xs4all.nl (programmed in Forth)" CR CR
	." Animal Farm is a program that can create the evolution " CR
	." of a biosystem consisting of entities with different features: " CR
	." e=energy a=attacking force d=defensive force  s=speed " CR
	." Character='specie': a+4*d+10*s -> 0-25=A-Z" CR 
	." Each step: e -> e+sun-(a+d+2s) 	[+e(from attacked entity)]" CR
	." Flora=white     Fauna=red (s>0)" CR
	." Sun (free energy): "	key 48 - dup . SUN ! CR 
	." By means of mutation offspring can be differ from the parent." CR
	." Mutation risk (%): " 	key 48 - RISK ! PAGE ;
: MUT 100 RANDOM RISK @ < if 5 RANDOM 2 - else 0 then ;
: NEWPOS 4 RANDOM
	DUP 0= if 	PL @ 2 - NPL !	drop else
	DUP 1 = if 	PL @ 2+ NPL ! 	drop else
	DUP 2 = if 	PL @ 40 - NPL !	drop else
	       3 = if 	PL @ 40 + NPL !	then then then then
	NPL @ DUP 0< if 800 NPL ! drop else
	             800 > if 0 NPL ! then then ;
: REPRIF
	PL @ EN + @ 2/   	NPL @ EN + !
	PL @ EN + @ 2/    	PL @ EN + !
	PL @ DE + @ MUT + 	NPL @ DE + !
	PL @ AT + @ MUT + 	NPL @ AT + !
	PL @ SP + @ MUT + 	NPL @ SP + !
	PL @ REP + @ MUT + 	NPL @ REP + ! ;
: REPRODUCE  NEWPOS 	NPL @ EN + @ 1 	< if REPRIF
	else PL @ AT + @   	NPL @ DE + @ 	> if REPRIF then then ;
: MOVE	
	PL @ EN + @ 	NPL @ EN + !	PL @ AT + @	NPL @ AT + !
	PL @ DE + @	NPL @ DE + !	PL @ SP + @	NPL @ SP + !
	PL @ REP + @	NPL @ REP + !	0 PL @ EN + ! ;
: COMPARE  PL @ AT + @ 1+  NPL @ DE + @ 
	> if  NPL @ EN + @  PL @ EN + +!  MOVE then ;
: VIEW 0 30 !PEN  760 0 Do  40 0 Do I J + PL !  
	PL @ EN + @ 0> if 
		PL @ SP + @ 0> if RED fcolor else WHITE fcolor then
		65  PL @  AT + @ +  	PL @ DE + @ 4 * +  
		PL @ SP + @ 10 * + 	."  " emit else ."  ." then
	2 +Loop  CR  40 +Loop 
	RED fcolor GEN @ 360 FA0 @ 4 / - !PEN GEN @ 1+ 360 FA @ 4 / - -TO  
	WHITE fcolor GEN @ 360 FL0 @ 4 / - !PEN GEN @ 1+ 360 FL @ 4 / - -TO ;
: AFARM INIT Begin 	FL @ FL0 ! FA @ FA0 ! 0 FL ! 0 FA !  1 GEN +! 
	800 0 Do I PL ! I EN + @ 0> if
		0 I SP + @ dabs 2* - I DE + @ dabs -  I AT + @ dabs - SUN @ +
		I EN + +!
		I EN + @ I REP + @ > if REPRODUCE then 
		I SP + @ 0> if NEWPOS 1 FA +!
			NPL EN + @ 1 < if MOVE 
			else COMPARE then else 1 FL +! then then
	2 +Loop VIEW ?BUTTON if QUIT then  Again ; 
READY							\ "echo on"
AFARM 							\ "types AFARM to run itself"

