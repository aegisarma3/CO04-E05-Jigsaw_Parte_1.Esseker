_Coleridge = Coleridge;
_Galanos = Galanos;
_Cosse = Cosse;
_Kollias = Kollias;
_Sewer_Sound = Sewer_Sound;
_Route_A = Route_A;
_Gorgon = AAF_Gorgon_Patrol;
_Trigger_Exit = Trigger_Exit;
_Orca = Orca_Loiter;

// Kill Some of the FIA

{

_x setDamage 1;

} forEach [

    FIA_01,
    FIA_02,
    FIA_03,
    FIA_04,
    FIA_05,
    FIA_06,
    FIA_07,
    FIA_08];

// AAF Garage

{
_X hideObject false;
_X enableSimulation true;
} forEach [_Gorgon, _Orca];

// Create FIA KIA Group

_Garage_FIA = createGroup WEST; 

// Create FIA KIA Units

"B_G_Medic_F" createUnit [getMarkerPos "Garage_KIA_01", _Garage_FIA, "Garage_KIA_01 = this;", 0.6, "PRIVATE"]; 
Garage_KIA_01 switchMove "KIA_passenger_boat_holdleft"; 
removeAllWeapons Garage_KIA_01; 
Garage_KIA_01 attachTo [Offroad_Garage, [1.35,-2,-1.515]]; 
Garage_KIA_01 setDir 180; 

"B_G_Soldier_F" createUnit [getMarkerPos "Garage_KIA_02", _Garage_FIA, "Garage_KIA_02 = this;", 0.6, "PRIVATE"]; 
Garage_KIA_02 switchMove "KIA_passenger_boat_holdleft"; 
removeAllWeapons Garage_KIA_02; 
Garage_KIA_02 setDir 180; 
Garage_KIA_02 switchMove "c5efe_AlexDeath"; 

"B_G_Soldier_SL_F" createUnit [getMarkerPos "Garage_KIA_03", _Garage_FIA, "Garage_KIA_03 = this;", 0.6, "SERGEANT"]; 
Garage_KIA_03 switchMove "AdthPercMstpSrasWrflDnon_NikitinDead2"; 
Garage_KIA_03 setDir 90;

{
    _x setCaptive true;
    _x setHit ["Body", 2];
} forEach [
    Garage_KIA_01, 
    Garage_KIA_02, 
    Garage_KIA_03]; 

// Create AAF Group

_Garage_AAF = createGroup INDEPENDENT; 

// Create AAF Units

"I_Soldier_GL_F" createUnit [getMarkerPos "Garage_AAF_01", _Garage_AAF, "Garage_AAF_01 = this;", 0.6, "CORPORAL"]; 
Garage_AAF_01 setDir -150;  
[Garage_AAF_01,"WATCH1","ASIS",{(player distance _this) < 5; _this knowsAbout player > 0.15; !alive AAF_Alerted_Trigger_Activation_A;}] call BIS_fnc_ambientAnimCombat;  

"I_Soldier_AR_F" createUnit [getMarkerPos "Garage_AAF_02", _Garage_AAF, "Garage_AAF_02 = this;", 0.6, "PRIVATE"]; 
Garage_AAF_02 setDir 280;  
[Garage_AAF_02,"STAND","ASIS",{(player distance _this) < 5; _this knowsAbout player > 0.15; !alive AAF_Alerted_Trigger_Activation_A;}] call BIS_fnc_ambientAnimCombat; 

"I_Soldier_F" createUnit [getMarkerPos "Garage_AAF_03", _Garage_AAF, "Garage_AAF_03 = this;", 0.6, "PRIVATE"]; 
Garage_AAF_03 setDir 10;  
[Garage_AAF_03,"STAND","ASIS",{(player distance _this) < 5; _this knowsAbout player > 0.15; !alive AAF_Alerted_Trigger_Activation_B;}] call BIS_fnc_ambientAnimCombat; 

"I_Soldier_F" createUnit [getMarkerPos "Garage_AAF_03", _Garage_AAF, "Garage_AAF_04 = this;", 0.7, "SERGEANT"]; 
Garage_AAF_04 setDir 100; 
removeHeadgear Garage_AAF_04;
Garage_AAF_04 unlinkItem "NVGoggles_INDEP"; 
[Garage_AAF_04,"STAND","ASIS",{(player distance _this) < 5; _this knowsAbout player > 0.15; !alive AAF_Alerted_Trigger_Activation_B;}] call BIS_fnc_ambientAnimCombat;     

{
    _x addEventHandler ["FiredNear", {_x reveal [player, 1]; _x reveal [player, 1]}]; 
    _x addEventHandler ["Hit", {_x reveal [player, 1]; _x reveal [player, 1]}]; 
} forEach [
    Garage_AAF_01,
    Garage_AAF_02,
    Garage_AAF_03,
    Garage_AAF_04];

// Delete Route A Trigger

deleteVehicle _Route_A;

// Reveal FIA Group

{
_X hideObject false;
} forEach [_Cosse, _Kollias, _Galanos];

// Fade Sound

3 fadeSound 0;
3 fadeMusic 0.85;

// Fade to Black

clearRadio;
enableRadio true;

_fadeSpeed = 2; 

Sleep 1;

0 cuttext ["","black out",_fadeSpeed]; 

Sleep _fadeSpeed;

// Disable Environment

enableEnvironment false;

_Coleridge enableSimulation false;

// Reverse Time

skipTime -4.30;

// Disable Navigation

showWatch true; 
showMap true; 
showCompass true; 
showHUD true;
showGPS true;

[group player, currentWaypoint (group player)] setWaypointVisible true;
    
skipTime -24;  

// Move Coleridge into Sewer

player AttachTo [Sewer_Entrance_Attachment_B, [-5,-3.35,-0.5]]; 
player setDir 50; 
player AttachTo [Sewer_Entrance_Attachment_B, [-5,-3.35,-0.5]]; 
player setDir 50; 
["Resist_OnEachFrameEH", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

_Galanos doWatch player;

detach player;

0 = [] spawn {sleep 0.1; simulWeatherSync;};

84600 setOvercast 0.85;
0 setRain 0;

skipTime 24; 

// Quotation

private ["_SomeTimeLater"];
_SomeTimeLater = ["Sewer_Exit.ogv"] spawn BIS_fnc_playVideo;
	
waitUntil {scriptDone _SomeTimeLater};

deleteVehicle _Sewer_Sound;

// Battlefield Ambience

nul = [] execVM "Scripts\Battlefield_Ambience.sqf";

// Remove Sewer EventHandlers

_Coleridge removeAllEventHandlers "Fired";
_Coleridge removeAllEventHandlers "Killed";

Sleep 1;

_Cosse addWeapon "Binocular";
Cosse attachTo [Kollias,[1,0,0]];
_Cosse disableAI "ANIM";
_Cosse disableAI "MOVE";
_Cosse selectWeapon "Binocular";
_Galanos switchMove "rfl_Up_Shoulder";

0 setLightnings 0;

Sleep 1;
 
0 setWaves 0; 

Sleep 1;

0 setFog 0.25;  

_Galanos disableAI "MOVE";

_Coleridge enableSimulation true;

// Fade In

0 cuttext ["","black in",_fadeSpeed * 3]; 

Sleep 1;

3 fadeSound 1;

_Coleridge enableSimulation true;

// Conversation 

Sleep 1;

_Galanos kbAddTopic ["conv", "Sentences.bikb", "", ""];
_Galanos kbTell [_Coleridge, "conv", "AT_00_Galanos_05"];
enableSentences false;

Sleep 2;

_Galanos kbAddTopic ["conv", "Sentences.bikb", "", ""];
_Galanos kbTell [_Coleridge, "conv", "AT_00_Galanos_06"];
enableSentences false;

Sleep 4;

_Galanos kbAddTopic ["conv", "Sentences.bikb", "", ""];
_Galanos kbTell [_Coleridge, "conv", "AT_00_Galanos_07"];
enableSentences false;

Sleep 6;

// Reveal Marker 

"AAF_Ambush" setMarkerAlpha 1;
"Sewer_02" setMarkerAlpha 1;

deleteVehicle _Trigger_Exit;

Sleep 5;

APD_Offroad allowDamage true;
private ["_Bomb"];
_Bomb = "Bo_GBU12_LGB" createVehicle getMarkerPos "Explosion_01";
_Bomb hideObject true;
_Bomb setVelocity [0,0,-1];

Sleep 15;

Galanos enableAI "MOVE";

Sleep 10;

saveGame; 

10 setRain 0.25;

Sleep 5;

playMusic "AT_Track_14";

Sleep 15;

10 setRain 0;
