/*
                                          OLD
//Radiation script
_unit = _this select 0;
_rad = 0;

//contador geiger + som
0 = nuke spawn {
  while {radarea} do {
    ["<t size='8' ><img image=""images\geiger.paa"" />",0.74,0.1,5,0,0.0] spawn bis_fnc_dynamictext;
    if (random (player distance _this) < 1) then {
      nuke say3D "geiger";
      };
      sleep 0.01;
  };
};

//radiação + hint da racição absorvida
while {radarea} do {
  _raddist = (round ((getPosASL _unit) vectorDistance (getPosASL nuke))*(10 ^ 2)) / (10 ^ 2); // arredonda a distancia para 2 casa decimais após a virgula
  _rad = _rad + round(0.05/(0.5 + _raddist)*(10 ^ 2)) / (10 ^ 2);// incrementa a potencia da radiação conforme a distância arredonda a distancia para 2 casa decimais após a virgula
  [_unit, _rad] call ace_medical_fnc_adjustPainLevel;
  sleep 1;
  hint format["nível de radiação 122uSv/h, radiação absorvida: %1uGy. Distância da fonte: %2m", _rad, _raddist];
  if (_rad >0.6) then {
    [_unit, true] call ace_medical_fnc_setUnconscious;
  };
};*/

//Radiation script
_unit = _this select 0;
_rad = _this select 1;

//contador geiger + som
0 = nuke spawn {
  while {radarea} do {
    ["<t size='8' ><img image=""images\geiger.paa"" />",0.74,0.1,5,0,0.0] spawn bis_fnc_dynamictext;
    if (random (player distance _this) < 2) then {
      nuke say3D "geiger";
      };
      sleep 0.01;
  };
};

//radiação + hint da racição absorvida
while {radarea} do {
  _dor = _unit getvariable ["ace_medical_pain", 0];
  _raddist = (round ((getPosASL _unit) vectorDistance (getPosASL nuke))*(10 ^ 2)) / (10 ^ 2); // arredonda a distancia para 2 casa decimais após a virgula
  _radpm = round(0.0001 + (_rad/_raddist)*(10 ^ 6)) / (10 ^ 6);// incrementa a potencia da radiação conforme a distância arredonda a distancia para 2 casa decimais após a virgula
  [_unit, _radpm] call ace_medical_fnc_adjustPainLevel;
  sleep 1;
  hint format["nível de radiação %1uSv/h. Distância da fonte: %2m. Dor %3", _radpm*10000, _raddist,_dor];
  if ((_unit getvariable ["ace_medical_pain", 0]) >0.75) then {
    [_unit, true] call ace_medical_fnc_setUnconscious;
  };
};
