ExileClientMoonLight = "#lightpoint" createVehicleLocal [0, 0, 0];
ExileClientMoonLight setLightAttenuation [10e10, 150, 4.31918e-005, 4.31918e-005];
ExileClientMoonLight setLightAmbient [63/255, 102/255, 155/255];
ExileClientMoonLight setLightBrightness 0.40;
ExileClientMoonLight setLightDayLight false;



/* Código do Paraquedas para funcionar com o @EM  */
/*waituntil {!IsNil "babe_fd_init"};
EM_fd_min_dam_h = 9000;
EM_fd_mu = 0;

player setVelocity [(sin (getDir player)) * 50, (cos (getDir player)) * 50, -5];

waitUntil {count(lineIntersectsObjs [ATLToASL(player modelToWorld [0,0,0]), ATLToASL(player modelToWorld [0,0,-2])]) > 1 || ((getPosATL player) select 2) < 2};

player setVelocity [0, 0, 0];
deleteVehicle (vehicle player);
player switchMove "";
sleep 1;

EM_fd_min_dam_h = 4;
EM_fd_mu = 1;*/

// Fade de luz logo depois de pousar

/*_light = 0.40;
_desired_light = 0.30;
_step = 0.1;

while { _desired_light < _light } do {
  _light = _light + _step * (_desired_light - _light);
  ExileClientMoonLight setLightBrightness _light;
  sleep _step;
};*/



["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;




player addEventHandler ["Killed",
{
   ["Initialize", [player]] call BIS_fnc_EGSpectator;
}];

/*player addEventHandler ["Respawn",
{
   ["Terminate"] call BIS_fnc_EGSpectator;
}];*/

//Área Radioativa
radarea = false;
_rad = 0;
