//Variables
_player = player;
_Trigger = Sound_Trigger_A;
_Sewer_Sound = Sewer_Sound;

_player enableSimulation false;

// Terminate Battlefield Ambience
missionNamespace setvariable ["Ambience",true];

// Fade Sound
3 fadeSound 0;
10 fadeMusic 0;

// Fade to Black
clearRadio;
enableRadio true;

_fadeSpeed = 2;

cuttext ["","black out",_fadeSpeed];

Sleep _fadeSpeed;

// Disable Environment
enableEnvironment false;

// Sewer Ambience
_Sewer_Sound attachTo [_player, [0,0,0]];

// Disable Navigation
showWatch false;
showMap false;
showCompass false;
showHUD false;
showGPS false;
[group player, currentWaypoint (group player)] setWaypointVisible false;

// OSD
if (missionNamespace getVariable ["BIS_fnc_camp_showOSD__running",false]) exitWith {};
BIS_fnc_camp_showOSD__running = true;

//Time
private["_date","_output","_showDate"];
private["_tDate","_tTime","_tTimeH","_tTimeM","_tDay","_tMonth","_tYear"];
_showDate 	= true;
_date 	   	= [_this, 1, date, [[]]] call BIS_fnc_param;
_date = _date call BIS_fnc_fixDate;

// Daytime Data
_tYear 	= _date select 0;
_tMonth = _date select 1;
_tDay 	= _date select 2;
if (_tMonth < 10) then {_tMonth = format["0%1",_tMonth]};
if (_tDay < 10) then {_tDay = format["0%1",_tDay]};

// Date Text
_tDate = format["%1-%2-%3 ",_tYear,_tMonth,_tDay];

// Time Text
_tTimeH = _date select 3;
_tTimeM = _date select 4;
if (_tTimeH < 10) then {_tTimeH = format["0%1",_tTimeH]};
if (_tTimeM < 10) then {_tTimeM = format["0%1",_tTimeM]};
_tTime = format["%1:%2",_tTimeH,_tTimeM];

// Output
_output =
[
	[_tDate,""],
	[_tTime,"font='PuristaMedium'"],["","<br/>"]
];
_output = _output + [["Esgotos da",""],["","<br/>"]];
_output = _output + [["Serraria Pilana",""],["","<br/>"]];

// Skip Time
skipTime -9;

// Change Weather
skipTime -24;
86400 setOvercast 1;
skipTime 24;
0 = [] spawn {
sleep 0.1;
simulWeatherSync;
};
0 setRain 0;
Sleep 0.25;
0 setWaves 0;
0 setWindStr 0;

// Move Coleridge into Sewer
_player setPos (getPos sewer_e);
Sleep 0.25;
_player switchMove "AmovPknlMstpSlowWrflDnon";
_player enableSimulation false;

// Reverb and Echo to Gunshots
_player addEventHandler ["Fired",{deleteVehicle Sewer_Patrol_FailSafe; if (_this select 1 != "THROW" && _this select 1 != "PUT") then {nul = [] execVM "Scripts\Sound_Effect.sqf"}}];

3 fadeSound 1;
playSound "Sewer_Entered_Sound";
Sleep 3;
0 setLightnings 0;
Sleep 5;
0 setFog 0;
Sleep 5;
_player enableSimulation true;

// Fade In
cuttext ["","black in",_fadeSpeed * 3];
sleep 0.5;
playMusic "";
player switchMove "AmovPknlMstpSlowWrflDnon";

// Print Text
private["_handle"];

// Vertical Alignment
_handle = [_output,safezoneX - 0.01,safeZoneY + (1 - 0.125) * safeZoneH,true,"<t align='right' size='1.0' font='PuristaLight'>%1</t>"] spawn BIS_fnc_typeText2;

Sleep 1;
BIS_fnc_camp_showOSD__running = false;

// Sewer Ambience Loop
while {alive _Trigger} do
{
_Sewer_Sound say3D "Sewer_Sound"; Sleep 150;};
