( Integer math routines for Pocket Forth 0.6 )forget task : task ; decimal: 2ROOT ( d -- n ) ( square root ) ( Forth assembler syntax )    ,$ 48E7  ,$ 2800  ( .long SP -] 2800 movem>, )    ,$ 2016           ( PS ] D0 move, )    ,$ 383C  ,$ 000F  ( .word  15 # D4 move,  .long )    ,$ 7200  ,$ 7400  ( 0 D1 moveq, 0 D2 moveq, )    ,$ E380  ,$ E391  ( DO,  1 # D0 asl,  1 # D1 roxl, )    ,$ E380  ,$ E391  (   1 # D0 asl,  1 # D1 roxl, )    ,$ E382  ,$ 2602  (   1 # D2 asl,  D2 D3 move, )    ,$ E383  ,$ B283  (   1 # D3 asl,  D3 D1 cmp, )    ,$ 6306           (   ls IF, )    ,$ 5282  ,$ 5283  (     1 D2 addq,  1 D3 addq, )    ,$ 9283           (     D3 D1 sub,  THEN, )    ,$ 51CC  ,$ FFE6  ( D4 LOOP, )    ,$ 2C82           ( D2 PS ] move, )    ,$ 4CDF  ,$ 0014  ( 14 SP ]+ movem<, )    drop ;: ^2 ( n -- d ) dup u* ;  ( square )variable TTABLE  0 ttable !  ( sines*10000 )    00175 , 00349 , 00524 , 00698 , 00872 , 01045 , 01219 , 01392 ,    01571 , 01736 , 01908 , 02079 , 02250 , 02419 , 02588 , 02756 ,    02924 , 03090 , 03256 , 03420 , 03584 , 03746 , 03907 , 04067 ,    04226 , 04384 , 04540 , 04695 , 04848 , 05000 , 05150 , 05299 ,    05446 , 05592 , 05736 , 05878 , 06018 , 06157 , 06293 , 06428 ,    06561 , 06691 , 06820 , 06947 , 07071 , 07193 , 07314 , 07431 ,    07547 , 07660 , 07771 , 07880 , 07986 , 08090 , 08192 , 08290 ,    08387 , 08480 , 08572 , 08660 , 08746 , 08829 , 08910 , 08988 ,    09063 , 09135 , 09205 , 09272 , 09336 , 09397 , 09455 , 09511 ,    09563 , 09613 , 09659 , 09703 , 09744 , 09781 , 09816 , 09848 ,    09877 , 09903 , 09925 , 09945 , 09962 , 09976 , 09986 , 09994 ,    09998 , 10000 ,: ?NEGATE ( n f -- n or -n ) IF negate THEN ;: FIXANGLE ( degrees -- degrees' ) ( map angle to -180� to 180� range )    dup abs  BEGIN  dup 180 > WHILE  360 - REPEAT    swap 0< ?negate ;: SIN ( degrees -- sin*10000 ) ( -180��angle�180� )    fixangle dup 0< >r  abs  dup 90 > IF  180 swap - THEN      2* ttable + @  r> ?negate ;: COS ( degrees -- cos*10000 )    dup 0< IF 90 + sin  ELSE  90 - sin negate THEN ;: ARCSIN ( sine*10000 -- degrees )    dup 0< >r  abs  ( save sign )      91 0 DO  ( check all angles )        dup r 2* ttable + @ > 0= IF  ( if sin>table value )        drop r  leave THEN  LOOP 1-    r> ?negate ; ( restore sign )( interpolate for greater accuracy ): SINE ( angle thousanths -- sine*10000 )    >r  >r  r sin  r> 1+ sin  over -  r> 1000 */ + ;: COSINE ( angle thousanths -- cosine*10000 )    >r >r  r cos  r> 1+ cos  over -  r> 1000 */ + ;: TEST  ( test this out )    100 150 !pen  275 150 -to  275 75 -to  100 150 -to    277 120 !pen ." 30 mm."  170 162 !pen ." 75 mm."    128 148 !pen  30 ^2  75 ^2 d+ 2root  ( hypotenuse )    30 10000 rot */  arcsin . 161 emit  cr ;room  page( You have just loaded some integer math routines. They're )( about twice as fast as their floating point counterparts,)( with a coprocessor, ten times as fast without.           )( Examine the IntegerTrig file to see how it was done      ).( bytes of dictionary left. ) test