

if (isClass(configFile >> "CfgPatches" >> "task_force_radio") && KPLIB_Enable_TFAR_compatibility)  exitwith {

_article =	format ["
<br/><br/><t color='#00ff00'>Short Range:</t><br/>;                               
-    %1 (Ch.1) :  %17 <br/>
-    %2 (Ch.2) :  %18 <br/>
-    %3 (Ch.3) :  %19 <br/>
-    %4 (Ch.4) :  %20 <br/>
-    %5 (Ch.5) :  %21 <br/>
-    %6 (Ch.6) :  %22 <br/>
-    %7 (Ch.7) :  %23 <br/>
-    %8 (Ch.8) :  %24 <br/>
<br/><br/><t color='#00ff00'>Long Range:</t><br/>;  
-    %9  (Ch.1) :   %25 <br/>
-    %10 (Ch.2) :	%26 <br/>  
-    %11 (Ch.3) :	%27	<br/>
-    %12 (Ch.4) :	%28	<br/>
-    %13 (Ch.5) :	%29	<br/>
-    %14 (Ch.6) :	%30	<br/>
-    %15 (Ch.7) :	%31	<br/>
-    %16 (Ch.8) :	%32	<br/>
	",
	(KPLIB_TFAR_Default_SR_Channels select 0) select 0,
	(KPLIB_TFAR_Default_SR_Channels select 1) select 0,
	(KPLIB_TFAR_Default_SR_Channels select 2) select 0,
	(KPLIB_TFAR_Default_SR_Channels select 3) select 0,
	(KPLIB_TFAR_Default_SR_Channels select 4) select 0,
	(KPLIB_TFAR_Default_SR_Channels select 5) select 0,
	(KPLIB_TFAR_Default_SR_Channels select 6) select 0,
	(KPLIB_TFAR_Default_SR_Channels select 7) select 0,
											
	(KPLIB_TFAR_Default_LR_Channels select 0) select 0,
	(KPLIB_TFAR_Default_LR_Channels select 1) select 0,
	(KPLIB_TFAR_Default_LR_Channels select 2) select 0,
	(KPLIB_TFAR_Default_LR_Channels select 3) select 0,
	(KPLIB_TFAR_Default_LR_Channels select 4) select 0,
	(KPLIB_TFAR_Default_LR_Channels select 5) select 0,
	(KPLIB_TFAR_Default_LR_Channels select 6) select 0,
	(KPLIB_TFAR_Default_LR_Channels select 7) select 0,
											
	(KPLIB_TFAR_Default_SR_Channels select 0) select 1,
	(KPLIB_TFAR_Default_SR_Channels select 1) select 1,
	(KPLIB_TFAR_Default_SR_Channels select 2) select 1,
	(KPLIB_TFAR_Default_SR_Channels select 3) select 1,
	(KPLIB_TFAR_Default_SR_Channels select 4) select 1,
	(KPLIB_TFAR_Default_SR_Channels select 5) select 1,
	(KPLIB_TFAR_Default_SR_Channels select 6) select 1,
	(KPLIB_TFAR_Default_SR_Channels select 7) select 1,
	
	(KPLIB_TFAR_Default_LR_Channels select 0) select 1,
	(KPLIB_TFAR_Default_LR_Channels select 1) select 1,
	(KPLIB_TFAR_Default_LR_Channels select 2) select 1,
	(KPLIB_TFAR_Default_LR_Channels select 3) select 1,
	(KPLIB_TFAR_Default_LR_Channels select 4) select 1,
	(KPLIB_TFAR_Default_LR_Channels select 5) select 1,
	(KPLIB_TFAR_Default_LR_Channels select 6) select 1,
	(KPLIB_TFAR_Default_LR_Channels select 7) select 1
	];


	KPLIB_Tutorials_Articles pushBack ["Radio Channels",_article];
};