_player = player;
_Sewer_Sound = Sewer_Sound;

playSound "Sewer_Entered_Sound";

// Fade Sound

3 fadeSound 0;
3 fadeMusic 0.85;

// Fade to Black

clearRadio;
enableRadio true;

_fadeSpeed = 5;

cuttext ["","black out",_fadeSpeed];

Sleep _fadeSpeed;

// Disable Environment

enableEnvironment false;

_player enableSimulation false;

// Reverse Time

skipTime 9;

// Disable Navigation

showWatch true;
showMap true;
showCompass true;
showHUD true;
showGPS true;

[group player, currentWaypoint (group player)] setWaypointVisible true;

skipTime -24;

// Move Coleridge into Sewer

_player setPos (getPos sewer_s);
_player setDir 0;

0 = [] spawn {
  sleep 0.1;
  simulWeatherSync;
};

84600 setOvercast 0.85;
0 setRain 1;

Sleep 0.25;

0 setWaves 1;
0 setWindStr 1;
0 setFog 0.25;
0 setLightnings 0.7;
skipTime 24;


// Quotation

deleteVehicle _Sewer_Sound;

// Remove Sewer EventHandlers

_player removeAllEventHandlers "Fired";

// Fade In
cuttext ["","black in",_fadeSpeed * 3];
Sleep 1;
3 fadeSound 1;
_player enableSimulation true;
