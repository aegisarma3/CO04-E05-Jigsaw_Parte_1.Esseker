enableSaving [false, false];

//[] execVM "aegis\init.sqf";
[] execVM "armas.sqf";
[] execVM "lanterna.sqf";

["Initialize"] call BIS_fnc_dynamicGroups;

_nul = []execVM "AF_Keypad\AF_KP_vars.sqf";
