// Short Pause

Sleep 3.75;

// Black Screen 

hideObject player; 
player attachTo [Death_Attachment, [0,0,100000]];
[format ["%1_blackScreen", missionName], false] call BIS_fnc_blackOut;